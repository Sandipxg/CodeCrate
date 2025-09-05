package CodeMaze;

import org.fife.ui.rsyntaxtextarea.RSyntaxTextArea;
import org.fife.ui.rsyntaxtextarea.SyntaxConstants;
import org.fife.ui.rtextarea.RTextScrollPane;

import javax.swing.*;
import java.awt.*;
import java.io.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static CodeMaze.ConnectionToAPI.stdout;
import static CodeMaze.jdbcConnections.con;
import static CodeMaze.FetchingChapters.selectedChapterId;
import static CodeMaze.FetchPracticeQuestion.selectedQuestionId;


public class DisplayQuestion extends JPanel {

    private final RSyntaxTextArea codeEditor;
    public static final JTextArea outputConsole = new JTextArea();
    private final JTextArea questionArea;
    private static Timer swingTimer;
    private static int secondsElapsed = 0;
    static String cleanedCode;
    static int timeTaken;
    static CustomizedStack stack;
    public static SolveLaterManager manager;

    public DisplayQuestion(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout());

        // --- Question panel ---
        questionArea = new JTextArea(3, 60);
        questionArea.setEditable(false);
        questionArea.setLineWrap(true);
        questionArea.setWrapStyleWord(true);

        JScrollPane questionScroll = new JScrollPane(questionArea);
        questionScroll.setPreferredSize(new Dimension(800, 60));
        loadQuestion();

        // --- Timer label ---
        JLabel timerLabel = new JLabel("Time: 00:00");
        timerLabel.setFont(new Font("Arial", Font.BOLD, 14));
        timerLabel.setHorizontalAlignment(SwingConstants.CENTER);

        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.add(questionScroll, BorderLayout.CENTER);
        topPanel.add(timerLabel, BorderLayout.EAST);

        // --- Code editor ---
        codeEditor = new RSyntaxTextArea(20, 60);
        codeEditor.setSyntaxEditingStyle(SyntaxConstants.SYNTAX_STYLE_JAVA);
        codeEditor.setCodeFoldingEnabled(true);
        RTextScrollPane codeScroll = new RTextScrollPane(codeEditor);

        // --- Output console ---
        outputConsole.setEditable(false);
        outputConsole.setFont(new Font("Consolas", Font.PLAIN, 14));
        JScrollPane outputScroll = new JScrollPane(outputConsole);

        // Split pane
        JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, codeScroll, outputScroll);
        splitPane.setResizeWeight(0.7);

        // --- Buttons ---
        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        JButton runButton = new JButton("Run Code");
        JButton submitButton = new JButton("Submit");
        JButton solveLaterButton = new JButton("Solve Later");
        JButton backButton = new JButton("Back");
        Font buttonFont = new Font("Segoe UI Semibold", Font.BOLD, 15);

        for (JButton btn : new JButton[]{runButton, submitButton, solveLaterButton,backButton}) {
            btn.setFont(buttonFont);
            btn.setBackground(new Color(222, 184, 135)); // Beige / cream button
            btn.setForeground(new Color(60, 30, 10));    // Dark brown text
            btn.setFocusPainted(false);
            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(139, 69, 19), 3, true), // Brown border
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        buttonPanel.add(runButton);
        buttonPanel.add(submitButton);
        buttonPanel.add(solveLaterButton);
        buttonPanel.add(backButton);

        add(topPanel, BorderLayout.NORTH);
        add(splitPane, BorderLayout.CENTER);
        add(buttonPanel, BorderLayout.SOUTH);

        // --- Timer starts only when typing ---
        codeEditor.addKeyListener(new java.awt.event.KeyAdapter() {
            @Override
            public void keyTyped(java.awt.event.KeyEvent e) {
                if (swingTimer == null || !swingTimer.isRunning()) {
                    startTimer(timerLabel);
                }
            }
        });

        // --- Run button ---
        runButton.addActionListener(e -> runCode());

        // --- Submit button ---
        submitButton.addActionListener(e -> {
            stopTimerAndShowTime(timerLabel);


            cleanedCode = codeEditor.getText().trim();
            if (cleanedCode.isEmpty()) {
                outputConsole.append("⚠ Empty code!\n");
                return;
            }

            try {
                ConnectionToAPI obj = new ConnectionToAPI();
                outputConsole.append("\n---- Submission Result ----\n");
                outputConsole.append(obj.getFormattedOutput());
                outputConsole.append("\n----------------------------\n");
                new AnswerValidation(stdout,timeTaken);
            } catch (IOException ex) {
                outputConsole.append("⚠ Error connecting to Judge0\n");
            }

            timerLabel.setText("Time: 00:00");
        });



// For "Solve Later" button:
        solveLaterButton.addActionListener(e -> {
            stack = new CustomizedStack();
            stack.loadFromFile();
            manager = new SolveLaterManager(stack);
            manager.addTask(selectedChapterId,selectedQuestionId);
            SolveLater solveLaterPanel = new SolveLater(cardLayout, mainPanel);
            solveLaterPanel.refreshTable();
        });



        // --- Back button ---
        backButton.addActionListener(e -> cardLayout.show(mainPanel, "fetchingChapters"));
    }

    private void loadQuestion() {
        try {
            Statement st = con.createStatement();

            //🤡
            String sql = "SELECT question FROM practicequestion"
                    +" WHERE chapterId = " + selectedChapterId +
                    " AND questionId = " + selectedQuestionId;
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                questionArea.setText(rs.getString("question"));
            } else {
                questionArea.setText("⚠ No question found in database");
            }
        } catch (SQLException e) {
            questionArea.setText("⚠ Error loading question.");
        }
    }


    private void runCode() {
        cleanedCode = codeEditor.getText().trim();

        if (cleanedCode.isEmpty()) {
            outputConsole.append("⚠ Cannot run empty code!\n\n");
            return;
        }

        outputConsole.append("⏳ Compiling & Running Code...\n");

        try {
            ConnectionToAPI obj = new ConnectionToAPI();
            outputConsole.append("\n---- Execution Result ----\n");
            outputConsole.append(obj.getFormattedOutput());
            outputConsole.append("\n---------------------------\n\n");
        } catch (IOException ex) {
            outputConsole.append("⚠ Error connecting to Judge0\n");
        }
    }


    private static void startTimer(JLabel timerLabel) {
        secondsElapsed = 0;
        timerLabel.setText("Time: 00:00");

        swingTimer = new Timer(1000, e -> {
            secondsElapsed++;
            int minutes = secondsElapsed / 60;
            int seconds = secondsElapsed % 60;
            timerLabel.setText(String.format("Time: %02d:%02d", minutes, seconds));
        });
        swingTimer.start();
    }


    private void stopTimerAndShowTime(JLabel timerLabel) {
        if (swingTimer != null && swingTimer.isRunning()) {
            swingTimer.stop();
        }

        int minutes = secondsElapsed / 60;
        int seconds = secondsElapsed % 60;
        timeTaken = secondsElapsed;  // ✅ keep full elapsed seconds

        String formattedTime = String.format("Time Taken: %02d:%02d", minutes, seconds);
        outputConsole.append(formattedTime + " : Submission Time\n\n");
        timerLabel.setText("Time: 00:00");
    }

    public JPanel getPanel() {
        return this;
    }
}