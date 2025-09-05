package Dashboard_files;

import CodeSnippet.RecycleBinPanel;
import CodeSnippet.ViewSnippetPanel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class CodeSnippetDashboardPanel extends JPanel {

    public CodeSnippetDashboardPanel(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout(20, 20));
        setBackground(new Color(139, 69, 19)); // 🤎 Brown background

        // 🔹 Title
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.setOpaque(false);
        topPanel.setBorder(BorderFactory.createEmptyBorder(50, 0, 35, 0));

        JLabel title = new JLabel(" CODE SNIPPET DASHBOARD", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI Black", Font.BOLD, 50));
        title.setForeground(new Color(245, 245, 220)); // Cream text
        topPanel.add(title, BorderLayout.CENTER);

        // 🔹 Buttons
        Dimension buttonSize = new Dimension(600, 90);
        Font buttonFont = new Font("Segoe UI Semibold", Font.BOLD, 36);

        JButton addBtn = new JButton(" Add Snippet");
        JButton editBtn = new JButton(" Edit Snippet");
        JButton viewBtn = new JButton(" View Snippet");
        JButton recycleBtn = new JButton(" Recycle Bin");
        JButton backBtn = new JButton(" Back");

        for (JButton btn : new JButton[]{addBtn, editBtn, viewBtn, recycleBtn, backBtn}) {
            btn.setPreferredSize(buttonSize);
            btn.setFont(buttonFont);
            btn.setBackground(new Color(222, 184, 135)); // Beige / cream button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
           // btn.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        // 🔹 Panel for buttons
        JPanel btnPanel = new JPanel(new GridLayout(5, 1, 20, 20));
        btnPanel.setBackground(new Color(245, 222, 179)); // Brown background
        btnPanel.add(addBtn);
        btnPanel.add(editBtn);
        btnPanel.add(viewBtn);
        btnPanel.add(recycleBtn);
        btnPanel.add(backBtn);

        JPanel center = new JPanel(new GridBagLayout());
        center.setBackground(new Color(245, 222, 179)); // Light cream highlight
        center.add(btnPanel);

        add(topPanel, BorderLayout.NORTH);
        add(center, BorderLayout.CENTER);

        // 🔹 Button actions (unchanged)
        addBtn.addActionListener((ActionEvent e) -> {
            cardLayout.show(mainPanel, "addSnippet");
        });

        editBtn.addActionListener((ActionEvent e) -> cardLayout.show(mainPanel, "editSnippet"));

        viewBtn.addActionListener((ActionEvent e) -> {
            new ViewSnippetPanel();
            ViewSnippetPanel.reloadSnippets();
            cardLayout.show(mainPanel, "ViewSnippet");
            cardLayout.show(mainPanel, "viewSnippet");
        });

        recycleBtn.addActionListener((ActionEvent e) -> {
            RecycleBinPanel recycleBinPanel = new RecycleBinPanel(cardLayout, mainPanel);
            mainPanel.add(recycleBinPanel.getPanel(), "recycleBin");

            cardLayout.show(mainPanel, "recycleBin");

        });
        backBtn.addActionListener((ActionEvent e) -> cardLayout.show(mainPanel, "Dashboard_files"));
    }

    public JPanel getPanel() {
        return this;
    }
}
