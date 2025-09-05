package ApplicationStart;

import CodeMaze.*;
//import TaskManager1.TaskManagerPanel;
import Verification.LoginPage;
import Verification.SignupPage;
import CodeSnippet.AddSnippetPanel;
import CodeSnippet.EditSnippetPanel;
import CodeSnippet.ViewSnippetPanel;
import CodeSnippet.RecycleBinPanel;
import Dashboard_files.LeetcodePanel;
import Dashboard_files.MainDashboardPanel;
import CodeSnippet.manager.CodeSnippetManagerPanel;
import Verification.WelcomePage;
//import taskmanager.TaskManager;

import javax.swing.*;
import java.awt.*;

public class Start {
    public static CardLayout cardLayout;
    public static  JPanel mainPanel;
    public static void main(String[] args) {

        //connecting to database
        new jdbcConnections();

        //to prevent overlap of gui elements
        SwingUtilities.invokeLater(() -> {
            JFrame frame = new JFrame("CodeCrate - Developer's Buddy ");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setSize(900, 650);
            frame.setLocationRelativeTo(null); // Centers the JFrame to the monitor screen
            frame.setResizable(false);
            // default layout set to borderlayout

            ImageIcon icon = new ImageIcon("codeCrate1.png");
            frame.setIconImage(icon.getImage());

            cardLayout = new CardLayout();
            mainPanel = new JPanel(cardLayout);

            // Create all panels
            WelcomePage welcomePage = new WelcomePage(cardLayout, mainPanel);
            LoginPage loginPage = new LoginPage(cardLayout, mainPanel);
            SignupPage signupPage = new SignupPage(cardLayout, mainPanel);
            MainDashboardPanel mainDashboard = new MainDashboardPanel(cardLayout, mainPanel);

            FetchingChapters fetchingChapters = new FetchingChapters(cardLayout, mainPanel);
            //FetchPracticeQuestion practiceQuestion = new FetchPracticeQuestion(cardLayout, mainPanel);
            //DisplayQuestion displayQuestion = new DisplayQuestion(cardLayout, mainPanel);
            //LeaderBoard leaderBoard = new LeaderBoard(cardLayout, mainPanel);

            LeetcodePanel leetcodePanel = new LeetcodePanel(cardLayout,mainPanel);
            CodeSnippetManagerPanel codeSnippetDashboard = new CodeSnippetManagerPanel(cardLayout, mainPanel);
            AddSnippetPanel addSnippetPanel = new AddSnippetPanel(cardLayout, mainPanel);
            EditSnippetPanel editSnippetPanel = new EditSnippetPanel(cardLayout, mainPanel);
            ViewSnippetPanel viewSnippetPanel = new ViewSnippetPanel(cardLayout, mainPanel);
            //TaskManagerPanel taskManagerPanel = new TaskManagerPanel(cardLayout, mainPanel);
            //TaskManager taskManager = new TaskManager(cardLayout,mainPanel);


            // Add all panels to mainPanel
            mainPanel.add(welcomePage.getPanel(), "welcome");
            mainPanel.add(loginPage.getPanel(), "login");
            mainPanel.add(signupPage.getPanel(), "signup");

            mainPanel.add(mainDashboard.getPanel(), "Dashboard_files");
            mainPanel.add(leetcodePanel.getPanel(), "leetcode");
            mainPanel.add(codeSnippetDashboard.getPanel(), "CodeSnippetDashboard");
            mainPanel.add(addSnippetPanel.getPanel(), "addSnippet");
            mainPanel.add(editSnippetPanel.getPanel(), "editSnippet");
            mainPanel.add(viewSnippetPanel.getPanel(), "viewSnippet");

            //mainPanel.add(byte_Battle.getPanel(),"byte_battle");
            mainPanel.add(fetchingChapters.getPanel(),"fetchingChapters");
            // mainPanel.add(practiceQuestion.getPanel(),"practiceQuestion");
            // mainPanel.add(displayQuestion.getPanel(),"displayQuestion");
           // mainPanel.add(leaderBoard .getPanel(),"leaderBoard");
            //mainPanel.add(taskManagerPanel.getPanel(), "TaskManager1");
            //mainPanel.add(taskManager.getPanel(), "TaskManager");


            cardLayout.show(mainPanel, "welcome");
            frame.add(mainPanel);
            frame.setVisible(true);
        });
    }
}



/*
SwingUtilities.invokeLater(() -> {
     Swing has its own Thread [ EDT -> Event Dispatch Thread ] which ensure bug fix enviroment for gui components ]
     main thread is different and EDT is different so for bug free gui interface we use this .
     invokeLater() tells run the below code as soon as possible .

ImageIcon
    .getImage() because setIconImage specifically needs Image not ImageIcon
     where as Jbutton and Jlabel accepts ImageIcon not Image
*/

// we have mainpanel[JPanel] which contains all other panels , we add every panels in MainPanel and then we add mainpanel in frame .

// When we extend any class by JPanel that class act as a JPanel .
// by default frames layout is set to BorderLayout