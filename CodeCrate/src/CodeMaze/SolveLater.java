package CodeMaze;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.util.List;

import static CodeMaze.DisplayQuestion.manager;
import static CodeMaze.DisplayQuestion.stack;

public class SolveLater extends JPanel {

    private final DefaultTableModel tableModel;
    private final JTable table;
//    private SolveLaterManager manager;


    public SolveLater(CardLayout cardLayout, JPanel mainPanel) {


        setLayout(new BorderLayout());
        setBackground(new Color(205, 193, 181));

        // Title
        JLabel title = new JLabel(" Solve Later Tasks", SwingConstants.CENTER);
        title.setFont(new Font("Verdana", Font.BOLD, 24));
        title.setForeground(Color.WHITE);
        title.setBorder(BorderFactory.createEmptyBorder(10, 0, 10, 0));
        add(title, BorderLayout.NORTH);

        // Table
        String[] columns = {"SrNo", "Chapter", "Question", "Reminder(s)", "Status"};
        tableModel = new DefaultTableModel(columns, 0) {
            @Override
            public boolean isCellEditable(int row, int col) { return false; }
        };

        table = new JTable(tableModel);
        table.setRowHeight(28);
        table.setFont(new Font("Consolas", Font.PLAIN, 15));
        table.getTableHeader().setFont(new Font("Segoe UI", Font.BOLD, 16));
        table.setShowGrid(true);
        table.setGridColor(Color.GRAY);
        add(new JScrollPane(table), BorderLayout.CENTER);

        // Buttons
        JPanel buttonPanel = new JPanel(new FlowLayout());
        buttonPanel.setBackground(new Color(60, 30, 10));

        JButton completeBtn = new JButton("Mark Completed");
        completeBtn.addActionListener(e -> markCompleted());

        JButton removeBtn = new JButton("Remove Selected");
        removeBtn.addActionListener(e -> removeSelected());

        JButton backBtn = new JButton("⬅ Back");
        backBtn.addActionListener(e -> cardLayout.show(mainPanel, "leetcode"));

        Font buttonFont = new Font("Segoe UI Semibold", Font.BOLD, 15);
        for (JButton btn : new JButton[]{completeBtn, removeBtn, backBtn}) {
            //btn.setPreferredSize(buttonSize);
            btn.setFont(buttonFont);
            btn.setBackground(new Color(222, 184, 135));
            btn.setForeground(new Color(60, 30, 10));
            btn.setFocusPainted(false);
            btn.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        buttonPanel.add(completeBtn);
        buttonPanel.add(removeBtn);
        buttonPanel.add(backBtn);
        add(buttonPanel, BorderLayout.SOUTH);
        try {
            refreshTable();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null , "Assign solve later first" , "Status" , JOptionPane.INFORMATION_MESSAGE);
        }
    }

    public void refreshTable() {
        tableModel.setRowCount(0);
        List<String> tasks = stack.getAllTasks();
        for (int i = 0; i < tasks.size(); i++) {
            String[] parts = tasks.get(i).split("\\.");

            String chapter = parts.length > 0 ? parts[0] : "";
            String question = parts.length > 1 ? parts[1] : "";
            String reminder = parts.length > 2 ? parts[2] : "0";
            String status = parts.length > 3 ? parts[3] : "Pending";

            tableModel.addRow(new Object[]{

                    i + 1,
                    chapter,
                    question,
                    reminder,
                    status
            });
        }
    }

    private void markCompleted() {
        int row = table.getSelectedRow();
        if (row == -1) return;
        stack.markCompleted(row);
        manager.stopReminder(row);
        refreshTable();
    }

    private void removeSelected() {
        int row = table.getSelectedRow();
        if (row == -1) return;
        stack.removeTask(row);
        manager.stopReminder(row);
        refreshTable();
    }

    public JPanel getPanel() { return this; }
}
