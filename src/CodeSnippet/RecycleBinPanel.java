package CodeSnippet;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.TreeSet;

public class RecycleBinPanel extends JPanel {
    private final DefaultListModel<String> deletedListModel;
    private final JList<String> deletedList;
    private final JTextArea deletedCodeArea;
    private final HashMap<String, File> deletedFileMap = new HashMap<>();

    public RecycleBinPanel(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout(10, 10));

        deletedListModel = new DefaultListModel<>();
        deletedList = new JList<>(deletedListModel);
        JScrollPane listScroll = new JScrollPane(deletedList);

        deletedCodeArea = new JTextArea(20, 60);
        deletedCodeArea.setEditable(false);
        JScrollPane codeScroll = new JScrollPane(deletedCodeArea);


        File recycleDir = new File("Recycle Bin");
        if (recycleDir.exists()) {
            File[] files = recycleDir.listFiles();
            if (files != null) {
                TreeSet<String> sortedNames = new TreeSet<>(); // TreeSet stores snippet names in alphabetical order automatically
                for (File f : files) {
                    if (f.getName().endsWith(".txt")) {
                        sortedNames.add(f.getName());
                        deletedFileMap.put(f.getName(), f);
                    }
                }
                for (String name : sortedNames) {
                    deletedListModel.addElement(name);
                }
            }
        }

        /*
                for (File f : files) { // this arranges files in random order
                    if (f.getName().endsWith(".txt")) {
                        deletedListModel.addElement(f.getName());
                    }
                }
        */


        deletedList.addListSelectionListener(e -> {
            String selected = deletedList.getSelectedValue();
            if (selected != null) {
                File file = deletedFileMap.get(selected);

                /*  Old logic : recreating File object is not efficient
                File file = new File("Recycle Bin/" + selected);
                */

                try {
                    String content = new String(Files.readAllBytes(file.toPath()));
                    deletedCodeArea.setText(content);
                } catch (IOException ex) {
                    JOptionPane.showMessageDialog(this, "Could not read deleted snippet.");
                }
            }
        });

        // Restore Button
        JButton restoreBtn = new JButton("Restore");
        restoreBtn.addActionListener((ActionEvent e) -> {
            String selected = deletedList.getSelectedValue();
            if (selected == null) {
                JOptionPane.showMessageDialog(this, "Please select a snippet to restore.");
                return;
            }

            File deletedFile = deletedFileMap.get(selected);
            /*  File deletedFile = new File("Recycle Bin/" + selected);  */

            File restoreTo = new File("snippets/" + selected);
            try {
                Files.copy(deletedFile.toPath(), restoreTo.toPath());
                deletedFile.delete();
                deletedListModel.removeElement(selected);
                deletedCodeArea.setText("");
                JOptionPane.showMessageDialog(this, "Snippet restored successfully.");
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Failed to restore snippet.");
            }
        });

        // Permanently Delete Button
        JButton deletePermanentlyBtn = new JButton("Delete Permanently");
        deletePermanentlyBtn.addActionListener((ActionEvent e) -> {
            String selected = deletedList.getSelectedValue();
            if (selected == null) {
                JOptionPane.showMessageDialog(this, "Please select a snippet to delete.");
                return;
            }

            File deletedFile = deletedFileMap.get(selected); // 🔁 use mapped file
            /* File deletedFile = new File("Recycle Bin/" + selected); */

            if (deletedFile.delete()) {
                deletedListModel.removeElement(selected);
                deletedCodeArea.setText("");
                JOptionPane.showMessageDialog(this, "Snippet permanently deleted.");
            } else {
                JOptionPane.showMessageDialog(this, "Failed to delete snippet.");
            }
        });

        // Back Button
        JButton backBtn = new JButton("Back to Dashboard");
        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "CodeSnippetdashboard"));
        Font buttonFont = new Font("Segoe UI Semibold", Font.BOLD, 15);

        for (JButton btn : new JButton[]{restoreBtn, deletePermanentlyBtn, backBtn}) {
            btn.setFont(buttonFont);
            btn.setBackground(new Color(222, 184, 135)); // Beige / cream button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        JPanel bottomPanel = new JPanel();
        bottomPanel.add(restoreBtn);
        bottomPanel.add(deletePermanentlyBtn);
        bottomPanel.add(backBtn);

        add(listScroll, BorderLayout.WEST);
        add(codeScroll, BorderLayout.CENTER);
        add(bottomPanel, BorderLayout.SOUTH);
    }

    public JPanel getPanel() {
        return this;
    }
}
