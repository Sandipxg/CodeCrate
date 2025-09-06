package MailSenders;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.File;
import java.io.IOException;
import java.util.Properties;

public class SendAttachment {
    public static void sendSnippetWithAttachment(String toEmail, String username, File snippetFile)
            throws MessagingException, IOException {

        final String fromEmail = "MailGatewaySolution@gmail.com";
        final String password = " ";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("📦 Your exported snippet from CodeCrate");

        // Body part (text/HTML)
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        String body = "<h3>Hello " + username + ",</h3><p>Here is your exported code snippet.</p>";
        messageBodyPart.setContent(body, "text/html");

        // Attachment part
        MimeBodyPart attachmentPart = new MimeBodyPart();
        attachmentPart.attachFile(snippetFile);

        // Combine both parts
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        multipart.addBodyPart(attachmentPart);

        message.setContent(multipart);

        Transport.send(message);
        System.out.println("✅ Snippet sent successfully to " + toEmail);
    }

}

