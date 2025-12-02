package controller.cliente;

import dao.ClienteDAO;
import util.EmailService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/cliente/esqueceu-senha")
public class ClienteEsqueceuSenhaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        String token = UUID.randomUUID().toString();

        ClienteDAO dao = new ClienteDAO();
        boolean ok = dao.salvarTokenRedefinir(email, token);

        if (!ok) {
            request.setAttribute("erro", "E-mail não encontrado.");
            request.getRequestDispatcher("/pages/cliente/esqueceu-senha.jsp")
                   .forward(request, response);
            return;
        }

        // Criar link usando o EmailService
        String link = "http://localhost:8080/teste/cliente/redefinir?token=" + token;

        new EmailService().enviarEmail(
                email,
                "Redefinição de Senha – StudioMusic",
                "<p>Clique no link abaixo para redefinir sua senha:</p>"
                        + "<a href='" + link + "'>Redefinir Senha</a>"
        );

        request.setAttribute("msg", "Enviamos um e-mail com as instruções!");
        request.getRequestDispatcher("/pages/cliente/esqueceu-senha.jsp")
               .forward(request, response);
    }
}
