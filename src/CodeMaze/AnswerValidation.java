package CodeMaze;

import ApplicationStart.Start;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static CodeMaze.FetchPracticeQuestion.challengeLevel;
import static CodeMaze.FetchPracticeQuestion.selectedQuestionId;
import static UserData.CurrentCreditionals.getUsername;
import static CodeMaze.FetchingChapters.selectedChapterId;

public class AnswerValidation {
    String answer;
    int time;
    String expectedAnswer;
    int expectedPoint = 0;
    int normalTime;

    public AnswerValidation() {}
    public AnswerValidation(String answer, int time) {
        this.answer = answer;
        this.time = time;
        assignPoints();
    }

    public void assignPoints() {
        try {
            new jdbcConnections();

            String setPoints = "Select answer,marks,averageTime from practicequestion where questionId = ? " +
                    "and chapterId=?";
            PreparedStatement pst = jdbcConnections.con.prepareStatement(setPoints);
            pst.setInt(2, selectedChapterId);
            pst.setInt(1, selectedQuestionId);

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                expectedAnswer = rs.getString("answer");
                expectedPoint = expectedPoint + rs.getInt("marks");
                normalTime = rs.getInt("averageTime");
                System.out.println(expectedAnswer);
            }

            if (expectedAnswer.trim().equalsIgnoreCase(answer.trim())) {

                DisplayQuestion.outputConsole.append("✅ Correct Answer 🎊\n");

                // BONUS points
                if (time < normalTime) {
                    expectedPoint = expectedPoint + 10;
                    DisplayQuestion.outputConsole.append("+10 added for faster response! KEEP YOUR PACE HIGH ✨\n");
                }

                CallableStatement cst = jdbcConnections.con.prepareCall("{call updatepoints(?,?,?)}");
                cst.setString(1, getUsername());
                cst.setInt(2, expectedPoint);
                cst.setString(3, challengeLevel);

                cst.execute();


                // Save attempt in file
                File f = new File(getUsername() + ".txt");
                FileWriter fw = new FileWriter(f, true);
                fw.write(challengeLevel + "." + selectedChapterId + "." + selectedQuestionId + "\n");
                fw.flush();
                fw.close();

                Start.cardLayout.show(Start.mainPanel, "practiceQuestions");

            } else {
                DisplayQuestion.outputConsole.append("❌ Incorrect answer. Try again!\n");
            }

        } catch (SQLException e) {
            DisplayQuestion.outputConsole.append("SQL Error: " + e.getMessage() + "\n");
        } catch (IOException e) {
            DisplayQuestion.outputConsole.append("File Error: " + e.getMessage() + "\n");
        }
    }
}
