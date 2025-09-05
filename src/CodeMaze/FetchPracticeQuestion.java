package CodeMaze;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import static CodeMaze.FetchingChapters.*;


public class FetchPracticeQuestion extends JPanel {

    public static int noOfQuestion;
    static int selectedQuestionId;
    CardLayout cardLayout;
    JPanel mainPanel;
    static String challengeLevel = "";

    public FetchPracticeQuestion(CardLayout cardLayout, JPanel mainPanel) {

        this.cardLayout = cardLayout;
        this.mainPanel = mainPanel;

        setLayout(new BorderLayout(20, 20));
        setBackground(new Color(205, 193, 181)); // 🤎 cream background

        // 🔹 Title
        JLabel title = new JLabel("📘 Practice Questions", SwingConstants.CENTER);
        title.setFont(new Font("Segoe UI Black", Font.BOLD, 40));
        title.setForeground(new Color(101, 67, 33)); //
        title.setBorder(BorderFactory.createEmptyBorder(20, 0, 20, 0));
        add(title, BorderLayout.NORTH);

        // 🔹 Button Panel (Grid inside ScrollPane)
        JPanel buttonPanel = new JPanel(new GridLayout(0, 5, 20, 20)); // 5 per row
        buttonPanel.setOpaque(false);

        JScrollPane questionScrollPane = new JScrollPane(buttonPanel);
        questionScrollPane.setBorder(null);
        add(questionScrollPane, BorderLayout.CENTER);

        JPanel bottomPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        bottomPanel.setOpaque(false);

        JButton backButton = new JButton("🔙 Back");
        backButton.setPreferredSize(new Dimension(250, 70));
        backButton.setFont(new Font("Segoe UI Semibold", Font.BOLD, 28));
        backButton.setBackground(new Color(101, 67, 33)); //
        backButton.setForeground(Color.WHITE);
        backButton.setFocusPainted(false);

        bottomPanel.add(backButton);
        add(bottomPanel, BorderLayout.SOUTH);

        backButton.addActionListener(e -> cardLayout.show(mainPanel, "fetchingChapters"));

        // ✅ Add buttons to buttonPanel (not this panel)
        for (int q = 1; q <= 30; q++) {
            JButton questionButton;
            if(solvedInChapter.contains1(q)) {
                questionButton = new JButton("Q" + q + " ☑️");
            } else {
                questionButton = new JButton("Q" + q);
            }

            questionButton.setName("" + q);
            questionButton.setPreferredSize(new Dimension(100, 25));
            questionButton.setFont(new Font("Arial", Font.PLAIN, 12));
            questionButton.setBackground(new Color(101, 67, 33)); //
            questionButton.setForeground(Color.WHITE);
            questionButton.setFocusPainted(false);

            buttonPanel.add(questionButton);  // ✅ Add inside scrollable panel

            JButton finalQuestionButton = questionButton;
            questionButton.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    selectedQuestionId = Integer.parseInt(finalQuestionButton.getName());
                    System.out.println(selectedQuestionId);
                    if (selectedQuestionId<=10) challengeLevel = "beginner_questions";
                    else if(selectedQuestionId<=20) challengeLevel = "intermediate_questions";
                    else if(selectedQuestionId<=30) challengeLevel = "expert_questions" ;
                    DisplayQuestion displayQuestion = new DisplayQuestion(cardLayout, mainPanel);
                    mainPanel.add(displayQuestion.getPanel(), "displayQuestion");
                    cardLayout.show(mainPanel, "displayQuestion");
                }
            });

        }

        revalidate();
        repaint();
    }

    public JPanel getPanel() {
        return this;
    }
}
