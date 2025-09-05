package CodeSnippet;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.*;
import java.sql.SQLException;
import java.sql.Statement;

import org.fife.ui.rsyntaxtextarea.*;
import org.fife.ui.rtextarea.*;

import static CodeMaze.jdbcConnections.con;
import static UserData.CurrentCreditionals.getUsername;


public class AddSnippetPanel extends JPanel {
    private final JTextField snippetNameField;
    private final JComboBox<String> languageBox;
    private final RSyntaxTextArea codeArea;
    Statement st ;

    public AddSnippetPanel(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout(10, 10));

        // 🔼 Top Panel - Snippet Name & Language
        JPanel topPanel = new JPanel(new GridLayout(2, 2, 5, 5));
        snippetNameField = new JTextField();
        String[] languages = {"Java", "Python", "C++", "HTML", "SQL"};
        languageBox = new JComboBox<>(languages);

        topPanel.add(new JLabel("Snippet Name:"));
        topPanel.add(snippetNameField);
        topPanel.add(new JLabel("Language:"));
        topPanel.add(languageBox);
        add(topPanel, BorderLayout.NORTH);


        // 📄 Code Editor Area
        codeArea = new RSyntaxTextArea(20, 60);
        codeArea.setSyntaxEditingStyle(SyntaxConstants.SYNTAX_STYLE_JAVA);
        codeArea.setCodeFoldingEnabled(true);
        add(new RTextScrollPane(codeArea), BorderLayout.CENTER);

        // ⬇ Bottom Buttons
        JButton saveBtn = new JButton("Save Snippet");
        JButton loadBtn = new JButton("Load File"); // ✅ New button
        JButton backBtn = new JButton("Back to Dashboard");
        Dimension buttonSize = new Dimension(600, 100);
        Font buttonFont = new Font("Segoe UI Semibold", Font.BOLD, 15);
        for (JButton btn : new JButton[]{saveBtn, loadBtn, backBtn}) {
            //btn.setPreferredSize(buttonSize);
            btn.setFont(buttonFont);
            btn.setBackground(new Color(222, 184, 135)); // Beige / cream button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
            btn.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        buttonPanel.add(saveBtn);
        buttonPanel.add(loadBtn);
        buttonPanel.add(backBtn);
        add(buttonPanel, BorderLayout.SOUTH);

        // 💾 Save Button Logic
        saveBtn.addActionListener((ActionEvent e) -> {
            String name = snippetNameField.getText().trim();
            String lang = (String) languageBox.getSelectedItem();
            String code = codeArea.getText();

            if (name.isEmpty() || code.isEmpty()) {
                JOptionPane.showMessageDialog(this, "Snippet name and code cannot be empty.");
                return;
            }

            File dir = new File("snippets");
            if (!dir.exists()) dir.mkdir();
            File file = new File(dir, name + ".txt");

            try (FileWriter fw = new FileWriter(file)) {
                fw.write("// Language: " + lang + "\n");
                fw.write(code);
                JOptionPane.showMessageDialog(this, "✅ Snippet saved successfully!");

                //store the file path in the database
                st  = con.createStatement();
                String sql = "INSERT INTO snippets(language, code, added_by,name) VALUES ('"
                        + lang + "', '"
                        + file.getAbsolutePath().replace("\\", "/") + "', '"
                        + getUsername()  + "' , '" + snippetNameField.getText().trim() + "')" ;

                int r = st.executeUpdate(sql);
                if(r!=0) System.out.println("succcessfull");

                snippetNameField.setText("");
                codeArea.setText("");
                languageBox.setSelectedIndex(0);

                cardLayout.show(mainPanel, "CodeSnippetdashboard");

            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "❌ Error saving snippet: " + ex.getMessage());
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        });

        // 📂 Load File Button Logic
        loadBtn.addActionListener(e -> {
            String path = JOptionPane.showInputDialog(this, "Enter file path to load:");
            if (path != null && !path.trim().isEmpty()) {
                File file = new File(path.trim());
                if (file.exists() && file.isFile()) {
                    try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                        codeArea.setText(""); // clear editor before loading
                        String line;
                        while ((line = br.readLine()) != null) {
                            codeArea.append(line + "\n");
                        }
                        JOptionPane.showMessageDialog(this, "✅ File loaded successfully!");
                    } catch (IOException ex) {
                        JOptionPane.showMessageDialog(this, "❌ Error reading file: " + ex.getMessage());
                    }
                } else {
                    JOptionPane.showMessageDialog(this, "❌ Invalid file path. Please try again.");
                }
            }
        });

        // 🔙 Back Button Logic
        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "CodeSnippetdashboard"));

    }

    public JPanel getPanel() {
        return this;
    }
}
