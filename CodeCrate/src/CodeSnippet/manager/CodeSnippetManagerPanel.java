package CodeSnippet.manager;

import Verification.LoginPage;
import Dashboard_files.CodeSnippetDashboardPanel;
import Dashboard_files.MainDashboardPanel;
import Verification.SignupPage;

import javax.swing.*;
import java.awt.*;

public class CodeSnippetManagerPanel extends JPanel {

    public CardLayout cardLayout;
    public JPanel mainPanel;
    public LoginPage loginPage;
    public SignupPage signupPage;
    public MainDashboardPanel mainDashboardPanel;
    public CodeSnippetDashboardPanel codeSnippetDashboardPanel;

    public CodeSnippetManagerPanel(CardLayout cardLayout, JPanel mainPanel) {
        this.cardLayout = cardLayout;
        this.mainPanel = mainPanel;

        setLayout(new BorderLayout());

        // Initialize panels
        loginPage = new LoginPage(cardLayout, mainPanel);
        signupPage = new SignupPage(cardLayout, mainPanel);
        mainDashboardPanel = new MainDashboardPanel(cardLayout, mainPanel);
        codeSnippetDashboardPanel = new CodeSnippetDashboardPanel(cardLayout, mainPanel);

        // Add to main panel
        mainPanel.add(loginPage.getPanel(), "login");
        mainPanel.add(signupPage.getPanel(), "signup");
        mainPanel.add(mainDashboardPanel.getPanel(), "Dashboard_files");
        mainPanel.add(codeSnippetDashboardPanel.getPanel(), "CodeSnippetdashboard");
    }

    public JPanel getPanel() {
        return this;
    }
}
