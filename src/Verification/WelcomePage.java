package Verification;

import javax.swing.*;
import java.awt.*;

public class WelcomePage extends JPanel {
    public WelcomePage(CardLayout cardLayout, JPanel mainPanel) {
        setLayout(new BorderLayout(20, 20));

        //  Cream background
        setBackground(new Color(245, 239, 230));

        //  Welcome Label
        JLabel welcomeLabel = new JLabel(" Welcome to CodeCrate", SwingConstants.CENTER);
        welcomeLabel.setFont(new Font("Segoe UI Black", Font.BOLD, 42));
        welcomeLabel.setForeground(new Color(92, 64, 51)); // coffee brown
        welcomeLabel.setBorder(BorderFactory.createEmptyBorder(60, 0, 40, 0));
        add(welcomeLabel, BorderLayout.CENTER);

        //  Buttons
        JButton loginButton = new JButton("Login");
        JButton signupButton = new JButton("Register");

        Dimension btnSize = new Dimension(250, 70);
        Font btnFont = new Font("Segoe UI Semibold", Font.BOLD, 28);

        //  Brown + Cream button colors
        Color btnNormal = new Color(150, 75, 0);   // chocolate brown
        Color btnHover = new Color(120, 60, 0);    // darker brown
        Color btnText = Color.WHITE;

        for (JButton btn : new JButton[]{loginButton, signupButton}) {
            btn.setPreferredSize(btnSize);
            btn.setFont(btnFont);
            btn.setBackground(btnNormal);
            btn.setForeground(btnText);
            btn.setFocusPainted(false);

            btn.setBorder(BorderFactory.createCompoundBorder(
                    BorderFactory.createLineBorder(new Color(160, 130, 100), 2, true),
                    BorderFactory.createEmptyBorder(10, 20, 10, 20)
            ));
        }

        //  Button Panel
        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 40, 30));
        buttonPanel.setOpaque(false);
        buttonPanel.add(loginButton);
        buttonPanel.add(signupButton);
        add(buttonPanel, BorderLayout.SOUTH);

        //  Actions (unchanged logic)
        loginButton.addActionListener(e -> cardLayout.show(mainPanel, "login"));
        signupButton.addActionListener(e -> cardLayout.show(mainPanel, "signup"));
    }

    public JPanel getPanel() {
        return this;
    }
}
