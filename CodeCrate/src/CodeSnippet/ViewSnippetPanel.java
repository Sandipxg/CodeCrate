package CodeSnippet;

import MailSenders.SendAttachment;
import UserData.CurrentCreditionals;
import org.fife.ui.rsyntaxtextarea.*;
import org.fife.ui.rtextarea.*;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.*;
import java.util.ArrayList;
import java.util.TreeSet;

public class ViewSnippetPanel extends JPanel {
    private static DefaultListModel<String> snippetListModel;
    private JList<String> snippetList;
    private final RSyntaxTextArea codeView = new RSyntaxTextArea(20, 60);
    private final JTextField searchField = new JTextField();

    public ViewSnippetPanel(CardLayout cardLayout, JPanel mainPanel) {

        snippetListModel = new DefaultListModel<>();
        snippetList = new JList<>(snippetListModel);

        setLayout(new BorderLayout(10, 10));

        // Top: Search bar
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.add(new JLabel("Search: "), BorderLayout.WEST);
        topPanel.add(searchField, BorderLayout.CENTER);
        JButton searchButton = new JButton("Search");
        topPanel.add(searchButton, BorderLayout.EAST);
        add(topPanel, BorderLayout.NORTH);

        // Load snippet list
        ArrayList<String> allSnippets = new ArrayList<>();
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

       /*
        searchButton.addActionListener(e -> {
            String query = searchField.getText().toLowerCase();
            snippetListModel.clear();
            for (String name : allSnippets) {
                if (name.toLowerCase().contains(query)) {
                    snippetListModel.addElement(name);
                }
            }
        });
        */

        // Search functionality
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


        // Snippet code display area
        codeView.setSyntaxEditingStyle(SyntaxConstants.SYNTAX_STYLE_JAVA);
        codeView.setEditable(false);
        codeView.setCodeFoldingEnabled(true);
        RTextScrollPane codeScroll = new RTextScrollPane(codeView);

        // Snippet selection
        snippetList.addListSelectionListener(e -> {
            String selected = snippetList.getSelectedValue();
            if (selected != null) {
                try (BufferedReader reader = new BufferedReader(new FileReader("snippets/" + selected))) {
                    codeView.setText("");
                    String line;
                    while ((line = reader.readLine()) != null) {
                        codeView.append(line + "\n");
                    }
                    codeView.setCaretPosition(0);
                } catch (IOException ex) {
                    JOptionPane.showMessageDialog(this, "Could not read file.");
                }
            }
        });

        // Export button
        JButton exportBtn = new JButton("Export");
        exportBtn.addActionListener((ActionEvent e) -> {
            String selected = snippetList.getSelectedValue();
            if (selected == null) {
                JOptionPane.showMessageDialog(this, "⚠️ Please select a snippet to export.");
                return;
            }

            File fileToSend = new File("snippets/" + selected);
            if (!fileToSend.exists()) {
                JOptionPane.showMessageDialog(this, "❌ File not found.");
                return;
            }

            try {
                SendAttachment.sendSnippetWithAttachment(CurrentCreditionals.getEmail(), CurrentCreditionals.getUsername(), fileToSend);
                JOptionPane.showMessageDialog(this, "✅ Snippet exported to your email!");
            } catch (Exception ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(this, "❌ Failed to send email.");
            }
        });

        // Back button
        JButton backBtn = new JButton("Back to Dashboard");
        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "CodeSnippetdashboard"));
        Font buttonFont = new Font("Segoe UI Semibold", Font.BOLD, 15);

        for (JButton btn : new JButton[]{searchButton,exportBtn, backBtn}) {
            btn.setFont(buttonFont);
            btn.setBackground(new Color(222, 184, 135)); // Beige / cream button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        // Bottom Panel
        JPanel bottomPanel = new JPanel();
        bottomPanel.add(exportBtn);
        bottomPanel.add(backBtn);

        // Layout
        add(new JScrollPane(snippetList), BorderLayout.WEST);
        add(codeScroll, BorderLayout.CENTER);
        add(bottomPanel, BorderLayout.SOUTH);
    }


    //for live refreshing of the code
    public ViewSnippetPanel() {
        File snippetDir = new File("snippets");
    }

    public static void reloadSnippets() {
        snippetListModel.clear();
        File snippetDir = new File("snippets");
        if (snippetDir.exists()) {

            File[] files = snippetDir.listFiles();
            if (files != null) {
                for (File f : files) {
                    if (f.getName().endsWith(".txt")) {
                        snippetListModel.addElement(f.getName());
                    }
                }
            }
        }
    }


    public JPanel getPanel() {
        return this;
    }
}
