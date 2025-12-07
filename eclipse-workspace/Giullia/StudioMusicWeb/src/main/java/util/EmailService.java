package util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailService {

    private static final String BASE_URL = "http://localhost:8080/StudioMusicWeb";

    private final String HOST = "sandbox.smtp.mailtrap.io";
    private final int PORT = 587;
    private final String USER = "2b2e61b59a83fd";
    private final String PASS = "cb6ff7847cf79b";

    private Session criarSessao() {

        Properties props = new Properties();
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", String.valueOf(PORT));
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USER, PASS);
            }
        });
    }

    public void enviarEmail(String destino, String assunto, String conteudoHtml) {

        try {
            Session sessao = criarSessao();

            Message msg = new MimeMessage(sessao);
            msg.setFrom(new InternetAddress("no-reply@studiomusic.com"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destino));
            msg.setSubject(assunto);
            msg.setContent(conteudoHtml, "text/html; charset=UTF-8");

            Transport.send(msg);

            System.out.println("Email enviado com sucesso!");
        } catch (MessagingException e) {
            System.out.println("Erro ao enviar email: " + e.getMessage());
        }
    }

    /**
     * Envia o e-mail de verificação para CLIENTE
     */    
    public void enviarEmailVerificacaoCliente(String emailDestino, String token) {

        // URL correta para clientes
        String link = BASE_URL + "/cliente/verificar?token=" + token;

        String assunto = "Confirmação de Cadastro – StudioMusic";
        String corpo = "<h3>Bem-vindo ao StudioMusic!</h3>"
                + "<p>Clique no botão abaixo para ativar sua conta:</p>"
                + "<a href='" + link + "' "
                + "style='padding:10px 20px;background:#1976D2;color:white;border-radius:6px;text-decoration:none;'>"
                + "Ativar Conta</a>";

        enviarEmail(emailDestino, assunto, corpo);
    }
}
