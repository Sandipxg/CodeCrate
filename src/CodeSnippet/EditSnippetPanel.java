//
//
//package codesnippet;
//
//import javax.swing.*;
//import javax.swing.event.ListSelectionEvent;
//import javax.swing.event.ListSelectionListener;
//import java.awt.*;
//import java.awt.event.ActionEvent;
//import java.io.*;
//
//import org.fife.ui.rsyntaxtextarea.*;
//import org.fife.ui.rtextarea.*;
//import utils.CurrentCreditionals;
//
//public class EditSnippetPanel extends JPanel {
//    private final DefaultListModel<String> snippetListModel; // for live refreshing of JList in gui |  any changes made to the model are automatically shown in the GUI.
//    private final JList<String> snippetList;
//    private final RSyntaxTextArea codeEditor;
//
//    public EditSnippetPanel(CardLayout cardLayout, JPanel mainPanel) {
//        setLayout(new BorderLayout(10, 10));
//
//        snippetListModel = new DefaultListModel<>();
//        snippetList = new JList<>(snippetListModel);
//        JScrollPane listScroll = new JScrollPane(snippetList);
//        add(listScroll, BorderLayout.WEST);
//
//        // Populate snippet list
//        File snippetDir = new File("snippets");
//        if (snippetDir.exists()) {
//            File[] files = snippetDir.listFiles();
//            if (files != null) {
//                for (File f : files) {
//                    if (f.getName().endsWith(".txt")) {
//                        snippetListModel.addElement(f.getName());
//                    }
//                }
//            }
//        }
//
//        // Code editing area
//        codeEditor = new RSyntaxTextArea(20, 60);
//        codeEditor.setSyntaxEditingStyle(SyntaxConstants.SYNTAX_STYLE_JAVA);
//        codeEditor.setCodeFoldingEnabled(true);
//        RTextScrollPane editorScroll = new RTextScrollPane(codeEditor);
//        add(editorScroll, BorderLayout.CENTER);
//
//        // List selection logic
//        // When a user clicks on an item in the list (or moves the selection), the ListSelectionListener is triggered.
//        snippetList.addListSelectionListener(new ListSelectionListener() {
//            @Override
//            public void valueChanged(ListSelectionEvent e) {
//                String selected = snippetList.getSelectedValue();
//                if (selected != null) {
//                    try (BufferedReader reader = new BufferedReader(new FileReader("snippets/" + selected))) {
//                        codeEditor.setText("");
//                        String line;
//                        while ((line = reader.readLine()) != null) {
//                            codeEditor.append(line + "\n");
//                        }
//                        codeEditor.setCaretPosition(0);
//                    } catch (IOException ex) {
//                        JOptionPane.showMessageDialog(EditSnippetPanel.this, "Could not read file.");
//                    }
//                }
//            }
//        });
//
//        // Bottom Buttons
//        JButton saveBtn = new JButton("Save Changes");
//        JButton deleteBtn = new JButton("Delete Snippet");
//        JButton backBtn = new JButton("Back to Dashboard");
//
//        JPanel bottomPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
//        bottomPanel.add(deleteBtn);
//        bottomPanel.add(saveBtn);
//        bottomPanel.add(backBtn);
//        add(bottomPanel, BorderLayout.SOUTH);
//
//        // Save Changes Button Logic
//        saveBtn.addActionListener((ActionEvent e) -> {
//            String selected = snippetList.getSelectedValue(); // JList represents what the user sees and interacts with,
//                                                              // whereas DefaultListModel is just the internal data structure behind it.
//            if (selected == null) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "No snippet selected.");
//                return;
//            }
//
//            File originalFile = new File("snippets/" + selected);
//            if (!originalFile.exists()) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Original file does not exist.");
//                return;
//            }
//
//            File oldDir = new File("old version snippets");
//            if (!oldDir.exists()) oldDir.mkdirs();
//
//            String baseName = selected.replace(".txt", "");
//
//            // Auto-detect latest version
//            int latestVersion = 0;
//            File[] oldFiles = oldDir.listFiles();
//            if (oldFiles != null) {
//                for (File file : oldFiles) {
//                    String name = file.getName();
//                    if (name.startsWith(baseName + "_v") && name.endsWith(".txt")) {
//                        try {
//                            int ver = Integer.parseInt(name.substring((baseName + "_v").length(), name.length() - 4));
//                            if (ver > latestVersion) latestVersion = ver;
//                        } catch (NumberFormatException ignored) {}
//                    }
//                }
//            }
//
//            // Move original to old version folder
//            File oldVersion = new File(oldDir, baseName + "_v" + (latestVersion + 1) + ".txt");
//            if (!originalFile.renameTo(oldVersion)) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Failed to archive old snippet.");
//                return;
//            }
//
//            // Save new version
//            try (FileWriter fw = new FileWriter("snippets/" + baseName + ".txt")) {
//                fw.write(codeEditor.getText());
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Snippet saved as version v" + (latestVersion + 2));
//            } catch (IOException ex) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Error saving new snippet version.");
//            }
//
//            // 🔁 OLD LOGIC  is not valid because it just check till v3 then if v8 exits it still alots v4  instead of alloting v9
//    /*
//    // Find version number
//        // If ArrayLoop_v1.txt and ArrayLoop_v2.txt already exist, then:
//             //It checks v3 (not found)
//             //So, we stop and use version = 2 as the latest version
//    String baseName = selected.replace(".txt", "");
//    int version = 1;
//    File versionedFile;
//    do {
//        versionedFile = new File(oldDir, baseName + "_v" + version + ".txt");
//        version++;
//    } while (versionedFile.exists());
//    version--;
//
//    // Move original to old version folder
//    File oldVersion = new File(oldDir, baseName + "_v" + version + ".txt");
//    originalFile.renameTo(oldVersion);
//
//    // Save new version
//    try (FileWriter fw = new FileWriter("snippets/" + baseName + ".txt")) {
//        fw.write(codeEditor.getText());
//        JOptionPane.showMessageDialog(EditSnippetPanel.this, "Snippet saved as version v" + (version + 1));
//    } catch (IOException ex) {
//        JOptionPane.showMessageDialog(EditSnippetPanel.this, "Error saving new snippet version.");
//    }
//    */
//        });
//
//        // Delete Button Logic
//        deleteBtn.addActionListener((ActionEvent e) -> {
//            String selected = snippetList.getSelectedValue();
//            if (selected == null) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Please select a snippet to delete.");
//                return;
//            }
//
//            String password = JOptionPane.showInputDialog(EditSnippetPanel.this, "Enter your password to confirm deletion:");
//            if (password == null || password.isEmpty()) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Password is required to delete.");
//                return;
//            }
//
//            boolean matched = false;
//            try (BufferedReader br = new BufferedReader(new FileReader("users.txt"))) {
//                String line;
//                while ((line = br.readLine()) != null) {
//                    String[] parts = line.split(",");
//                    if (parts.length >= 3 && parts[2].equals(password)) {
//                        matched = true;
//                        break;
//                    }
//                }
//            } catch (IOException ex) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Error reading user credentials.");
//                return;
//            }
//
//            if (!matched) {
//                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Incorrect password. Deletion cancelled.");
//                return;
//            }
//            int confirm = JOptionPane.showConfirmDialog(EditSnippetPanel.this, "Are you sure you want to delete '" + selected + "'?", "Confirm Deletion", JOptionPane.YES_NO_OPTION);
//            if (confirm == JOptionPane.YES_OPTION) {
//                File fileToDelete = new File("snippets/" + selected);
//                File recycleDir = new File("Recycle Bin");
//                if (!recycleDir.exists()) recycleDir.mkdirs();
//
//                File movedFile = new File(recycleDir, selected);
//                if (fileToDelete.renameTo(movedFile)) { // If the move is successful, it returns true.
//                    snippetListModel.removeElement(selected);
//                    codeEditor.setText("");
//                    JOptionPane.showMessageDialog(EditSnippetPanel.this, "Snippet moved to Recycle Bin.");
//                } else {
//                    JOptionPane.showMessageDialog(EditSnippetPanel.this, "Failed to delete snippet.");
//                }
//            }
//        });
//
//        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "CodeSnippetdashboard"));
//    }
//
//    public JPanel getPanel() {
//        return this;
//    }
//}
//


package CodeSnippet;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.*;
import java.util.ArrayList;
import java.util.TreeSet;

import org.fife.ui.rsyntaxtextarea.*;
import org.fife.ui.rtextarea.*;

public class EditSnippetPanel extends JPanel {
    private final DefaultListModel<String> snippetListModel; // for live refreshing of JList in gui |  any changes made to the model are automatically shown in the GUI.
    private final JList<String> snippetList;
    private final RSyntaxTextArea codeEditor;
    private final JTextField searchField = new JTextField(); // 🔍 Search field
    private final ArrayList<String> allSnippets = new ArrayList<>(); // keep all snippets for search

    public EditSnippetPanel(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout(10, 10));

        snippetListModel = new DefaultListModel<>();
        snippetList = new JList<>(snippetListModel);
        JScrollPane listScroll = new JScrollPane(snippetList);

        // 🔍 Top panel for search bar
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.add(new JLabel("Search: "), BorderLayout.WEST);
        topPanel.add(searchField, BorderLayout.CENTER);
        JButton searchButton = new JButton("Search");
        topPanel.add(searchButton, BorderLayout.EAST);
        add(topPanel, BorderLayout.NORTH);

        add(listScroll, BorderLayout.WEST);

        // Populate snippet list
        File snippetDir = new File("snippets");
        if (snippetDir.exists()) {
            File[] files = snippetDir.listFiles();
            if (files != null) {
                for (File f : files) {
                    if (f.getName().endsWith(".txt")) {
                        allSnippets.add(f.getName());
                        snippetListModel.addElement(f.getName());
                    }
                }
            }
        }

        // 🔍 Search functionality (TreeSet logic same as ViewSnippetPanel)
        TreeSet<String> snippetTree = new TreeSet<>(allSnippets);
        searchButton.addActionListener(e -> {
            String query = searchField.getText().toLowerCase();
            snippetListModel.clear();

            for (String name : snippetTree) {
                if (name.toLowerCase().contains(query)) {
                    snippetListModel.addElement(name);
                }
            }
        });

        // Code editing area
        codeEditor = new RSyntaxTextArea(20, 60);
        codeEditor.setSyntaxEditingStyle(SyntaxConstants.SYNTAX_STYLE_JAVA);
        codeEditor.setCodeFoldingEnabled(true);
        RTextScrollPane editorScroll = new RTextScrollPane(codeEditor);
        add(editorScroll, BorderLayout.CENTER);

        // List selection logic
        // When a user clicks on an item in the list (or moves the selection), the ListSelectionListener is triggered.
        snippetList.addListSelectionListener(new ListSelectionListener() {
            @Override
            public void valueChanged(ListSelectionEvent e) {
                String selected = snippetList.getSelectedValue();
                if (selected != null) {
                    try (BufferedReader reader = new BufferedReader(new FileReader("snippets/" + selected))) {
                        codeEditor.setText("");
                        String line;
                        while ((line = reader.readLine()) != null) {
                            codeEditor.append(line + "\n");
                        }
                        codeEditor.setCaretPosition(0);
                    } catch (IOException ex) {
                        JOptionPane.showMessageDialog(EditSnippetPanel.this, "Could not read file.");
                    }
                }
            }
        });

        // Bottom Buttons
        JButton saveBtn = new JButton("Save Changes");
        JButton deleteBtn = new JButton("Delete Snippet");
        JButton backBtn = new JButton("Back to Dashboard");
        Dimension buttonSize = new Dimension(600, 100);
        Font buttonFont = new Font("Segoe UI Semibold", Font.BOLD, 15);
        for (JButton btn : new JButton[]{saveBtn, deleteBtn, backBtn}) {
            btn.setFont(buttonFont);
            btn.setBackground(new Color(222, 184, 135)); // Beige / cream button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        JPanel bottomPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        bottomPanel.add(deleteBtn);
        bottomPanel.add(saveBtn);
        bottomPanel.add(backBtn);
        add(bottomPanel, BorderLayout.SOUTH);

        // Save Changes Button Logic
        saveBtn.addActionListener((ActionEvent e) -> {
            String selected = snippetList.getSelectedValue(); // JList represents what the user sees and interacts with,
            // whereas DefaultListModel is just the internal data structure behind it.
            if (selected == null) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "No snippet selected.");
                return;
            }

            File originalFile = new File("snippets/" + selected);
            if (!originalFile.exists()) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Original file does not exist.");
                return;
            }

            File oldDir = new File("old version snippets");
            if (!oldDir.exists()) oldDir.mkdirs();

            String baseName = selected.replace(".txt", "");

            // Auto-detect latest version
            int latestVersion = 0;
            File[] oldFiles = oldDir.listFiles();
            if (oldFiles != null) {
                for (File file : oldFiles) {
                    String name = file.getName();
                    if (name.startsWith(baseName + "_v") && name.endsWith(".txt")) {
                        try {
                            int ver = Integer.parseInt(name.substring((baseName + "_v").length(), name.length() - 4));
                            if (ver > latestVersion) latestVersion = ver;
                        } catch (NumberFormatException ignored) {}
                    }
                }
            }

            // Move original to old version folder
            File oldVersion = new File(oldDir, baseName + "_v" + (latestVersion + 1) + ".txt");
            if (!originalFile.renameTo(oldVersion)) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Failed to archive old snippet.");
                return;
            }

            // Save new version
            try (FileWriter fw = new FileWriter("snippets/" + baseName + ".txt")) {
                fw.write(codeEditor.getText());
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Snippet saved as version v" + (latestVersion + 2));
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Error saving new snippet version.");
            }

            // 🔁 OLD LOGIC  is not valid because it just check till v3 then if v8 exits it still alots v4  instead of alloting v9
    /*
    // Find version number
        // If ArrayLoop_v1.txt and ArrayLoop_v2.txt already exist, then:
             //It checks v3 (not found)
             //So, we stop and use version = 2 as the latest version
    String baseName = selected.replace(".txt", "");
    int version = 1;
    File versionedFile;
    do {
        versionedFile = new File(oldDir, baseName + "_v" + version + ".txt");
        version++;
    } while (versionedFile.exists());
    version--;

    // Move original to old version folder
    File oldVersion = new File(oldDir, baseName + "_v" + version + ".txt");
    originalFile.renameTo(oldVersion);

    // Save new version
    try (FileWriter fw = new FileWriter("snippets/" + baseName + ".txt")) {
        fw.write(codeEditor.getText());
        JOptionPane.showMessageDialog(EditSnippetPanel.this, "Snippet saved as version v" + (version + 1));
    } catch (IOException ex) {
        JOptionPane.showMessageDialog(EditSnippetPanel.this, "Error saving new snippet version.");
    }
    */
        });

        // Delete Button Logic
        deleteBtn.addActionListener((ActionEvent e) -> {
            String selected = snippetList.getSelectedValue();
            if (selected == null) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Please select a snippet to delete.");
                return;
            }

            String password = JOptionPane.showInputDialog(EditSnippetPanel.this, "Enter your password to confirm deletion:");
            if (password == null || password.isEmpty()) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Password is required to delete.");
                return;
            }

            boolean matched = false;
            try (BufferedReader br = new BufferedReader(new FileReader("users.txt"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3 && parts[2].equals(password)) {
                        matched = true;
                        break;
                    }
                }
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Error reading user credentials.");
                return;
            }

            if (!matched) {
                JOptionPane.showMessageDialog(EditSnippetPanel.this, "Incorrect password. Deletion cancelled.");
                return;
            }
            int confirm = JOptionPane.showConfirmDialog(EditSnippetPanel.this, "Are you sure you want to delete '" + selected + "'?", "Confirm Deletion", JOptionPane.YES_NO_OPTION);
            if (confirm == JOptionPane.YES_OPTION) {
                File fileToDelete = new File("snippets/" + selected);
                File recycleDir = new File("Recycle Bin");
                if (!recycleDir.exists()) recycleDir.mkdirs();

                File movedFile = new File(recycleDir, selected);
                if (fileToDelete.renameTo(movedFile)) { // If the move is successful, it returns true.
                    snippetListModel.removeElement(selected);
                    codeEditor.setText("");
                    JOptionPane.showMessageDialog(EditSnippetPanel.this, "Snippet moved to Recycle Bin.");
                } else {
                    JOptionPane.showMessageDialog(EditSnippetPanel.this, "Failed to delete snippet.");
                }
            }
        });

        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "CodeSnippetdashboard"));
    }

    public JPanel getPanel() {
        return this;
    }
}
