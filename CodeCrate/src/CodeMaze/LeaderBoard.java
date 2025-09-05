package CodeMaze;

import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class LeaderBoard extends JPanel {

    CardLayout cardLayout;
    JPanel mainPanel;
    JPanel thisPanel;

    public LeaderBoard(CardLayout cardLayout, JPanel mainPanel) {
        this.cardLayout = cardLayout;
        this.mainPanel = mainPanel;
        setLayout(new BorderLayout());
        thisPanel = this;
        setLayout(new BorderLayout(20, 20));
        setBackground(new Color(210, 180, 140)); // 🤎 Cream background
        new jdbcConnections();

        // Column names for JTable
        String[] columnNames = {"Rank", "User Name", "Total Points", "beginner_points", "intermediate_points", "expert_points"};

        String sql = "SELECT user_name, total_points, beginner_points, intermediate_points, expert_points " +
                "FROM user_data ORDER BY total_points DESC";

        java.util.List<Object[]> rows = new java.util.ArrayList<>();

        try (Statement st = jdbcConnections.con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            int rank = 1;
            while (rs.next()) {
                Object[] row = new Object[6];
                row[0] = rank++;
                row[1] = rs.getString("user_name");
                row[2] = rs.getInt("total_points");
                row[3] = rs.getInt("beginner_points");
                row[4] = rs.getInt("intermediate_points");
                row[5] = rs.getInt("expert_points");
                rows.add(row);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Convert List → 2D array
        Object[][] data = rows.toArray(new Object[0][]);

        // JTable
        JTable table = new JTable(data, columnNames);
        table.setEnabled(false); // read-only
        table.setRowHeight(30);
        table.setFont(new Font("Segoe UI", Font.PLAIN, 16));
        table.getTableHeader().setFont(new Font("Segoe UI Semibold", Font.BOLD, 20));

        // 🟤 Cream + Brown theme for table
        table.setBackground(new Color(255, 248, 220)); // Light cream rows
        table.setForeground(new Color(60, 30, 10)); // Dark text
        table.setGridColor(new Color(139, 69, 19)); // Brown grid

        table.getTableHeader().setBackground(new Color(139, 69, 19)); // Brown header
        table.getTableHeader().setForeground(Color.WHITE);

        // Scroll pane for table
        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.getViewport().setBackground(new Color(210, 180, 140));
        add(scrollPane, BorderLayout.CENTER);

        // Title at the top
        JLabel title = new JLabel("🏆 Leaderboard", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI Black", Font.BOLD, 40));
        title.setBorder(BorderFactory.createEmptyBorder(20, 0, 20, 0));
        title.setForeground(new Color(139, 69, 19)); // Dark brown
        add(title, BorderLayout.NORTH);

        // Back button
        JButton backBtn = new JButton("Back");
        backBtn.setBackground(new Color(139, 69, 19));
        backBtn.setForeground(Color.WHITE);
        backBtn.setFocusPainted(false);
        backBtn.setFont(new Font("Segoe UI Semibold", Font.BOLD, 20));
        add(backBtn, BorderLayout.SOUTH);
        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "Dashboard_files"));
    }

    public JPanel getPanel() {
        return this;
    }
}
