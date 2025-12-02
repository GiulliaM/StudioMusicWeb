package controller.cliente;

import dao.ClienteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cliente/redefinir")
public class ClienteRedefinirSenhaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String senhaNova = request.getParameter("senha");

        // Verificando token vazio
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("erro", "Token inválido!");
            request.getRequestDispatcher("/pages/cliente/redefinir-senha.jsp")
                   .forward(request, response);
            return;
        }

        ClienteDAO dao = new ClienteDAO();
        boolean ok = dao.redefinirSenha(token, senhaNova);

        if (ok) {
            request.setAttribute("msg", "Senha redefinida com sucesso!");
            request.getRequestDispatcher("/pages/cliente/login-cliente.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("erro", "Token inválido ou expirado!");
            request.getRequestDispatcher("/pages/cliente/redefinir-senha.jsp")
                   .forward(request, response);
        }
    }
}
