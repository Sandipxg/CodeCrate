package Dashboard_files;

import CodeMaze.LeaderBoard;
import CodeMaze.SolveLater;

import javax.swing.*;
import java.awt.*;

public class LeetcodePanel extends JPanel {
    public LeetcodePanel(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout(20, 20));
        setBackground(new Color(245, 245, 220)); // 🤎 Brown background

        // 🔹 Title
        JLabel title = new JLabel("⚡ LeetCode Section", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI Black", Font.BOLD, 45));
        title.setForeground(new Color(139, 69, 19)); // Cream text
        title.setBorder(BorderFactory.createEmptyBorder(40, 0, 40, 0));

        JPanel titlePanel = new JPanel(new BorderLayout());
        titlePanel.setBackground(new Color(222, 184, 135)); // Beige/Cream background for title
        titlePanel.add(title, BorderLayout.CENTER);

        add(titlePanel, BorderLayout.NORTH);

        // 🔹 Buttons
        JButton codeMaze = new JButton(" CODE MAZE");
        JButton solveLater = new JButton(" Solve Later");
        JButton LeaderBoard = new JButton(" LEADERBOARD");
        JButton backBtn = new JButton(" Back to Dashboard");

        LeaderBoard leaderBoard = new LeaderBoard(cardLayout, mainPanel);
        mainPanel.add(leaderBoard.getPanel(), "leaderBoard");
        LeaderBoard.addActionListener(e -> cardLayout.show(mainPanel, "leaderBoard"));

        JButton[] buttons = {codeMaze, solveLater, LeaderBoard, backBtn};
        for (JButton btn : buttons) {
            btn.setPreferredSize(new Dimension(500, 90));
            btn.setFont(new Font("Segoe UI Semibold", Font.BOLD, 32));
            btn.setBackground(new Color(222, 184, 135)); // Beige / Cream button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
            btn.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        // 🔹 Actions (logic unchanged)
        codeMaze.addActionListener(e -> cardLayout.show(mainPanel, "fetchingChapters"));

        solveLater.addActionListener(e -> {
            SolveLater solveLater1 = new SolveLater(cardLayout, mainPanel);
            mainPanel.add(solveLater1.getPanel(), "solveLater1");
            cardLayout.show(mainPanel, "solveLater1");
        });
        LeaderBoard leaderBoard1 = new LeaderBoard(cardLayout, mainPanel);
        mainPanel.add(leaderBoard1 .getPanel(),"leaderBoard1");

        LeaderBoard.addActionListener(e -> cardLayout.show(mainPanel, "LeaderBoard"));
        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "Dashboard_files"));

        // 🔹 Center Layout
        JPanel centerPanel = new JPanel(new GridLayout(4, 1, 30, 30));
        centerPanel.setBackground(new Color(245, 245, 220));
        centerPanel.add(codeMaze);
        centerPanel.add(solveLater);
        centerPanel.add(LeaderBoard);
        centerPanel.add(backBtn);

        JPanel wrapper = new JPanel(new GridBagLayout());
        wrapper.setOpaque(false);
        wrapper.add(centerPanel);

        add(wrapper, BorderLayout.CENTER);
    }

    public JPanel getPanel() {
        return this;
    }
}
