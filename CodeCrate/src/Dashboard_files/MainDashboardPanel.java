package Dashboard_files;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class MainDashboardPanel extends JPanel {

    public MainDashboardPanel(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout(10, 10));
        setBackground(new Color(139, 69, 19)); // 🤎 Brown background

        JLabel title = new JLabel(" Welcome to CodeCrate", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI Black", Font.BOLD, 50));
        title.setForeground(new Color(245, 245, 220)); // Cream text

        // 🔹 Buttons
        JButton codeSnippetBtn = new JButton("  Code Snippet Manager");
        JButton leetcodeBtn = new JButton("  LeetCode");

        Dimension btnSize = new Dimension(500, 100); // Bigger size
        Font btnFont = new Font("Segoe UI Semibold", Font.BOLD, 32);

        for (JButton btn : new JButton[]{codeSnippetBtn, leetcodeBtn}) {
            btn.setPreferredSize(btnSize);
            btn.setFont(btnFont);
            btn.setBackground(new Color(222, 184, 135)); // Cream / Beige button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
            btn.setHorizontalAlignment(SwingConstants.CENTER);
            btn.setVerticalAlignment(SwingConstants.CENTER);
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(222, 184, 135), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        // 🔹 Panel for buttons
        JPanel buttonPanel = new JPanel();
        buttonPanel.setBackground(new Color(245, 222, 179)); // Same brown as bg
        buttonPanel.setLayout(new GridLayout(2, 1, 30, 30));
        buttonPanel.add(codeSnippetBtn);
        buttonPanel.add(leetcodeBtn);

        JPanel center = new JPanel(new GridBagLayout());
        center.setBackground(new Color(245, 222, 179)); // Light cream
        center.add(buttonPanel);

        add(title, BorderLayout.NORTH);
        add(center, BorderLayout.CENTER);

        // 🔹 Actions (unchanged)
        codeSnippetBtn.addActionListener((ActionEvent e) -> {
            cardLayout.show(mainPanel, "CodeSnippetdashboard");
        });

        leetcodeBtn.addActionListener((ActionEvent e) -> {
            cardLayout.show(mainPanel, "leetcode");
        });
    }

    public JPanel getPanel() {
        return this;
    }
}
