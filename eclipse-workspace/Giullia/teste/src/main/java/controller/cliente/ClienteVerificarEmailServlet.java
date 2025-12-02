package controller.cliente;

import dao.ClienteDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cliente/verificar")
public class ClienteVerificarEmailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pages/cliente/erro-verificacao.jsp");
            return;
        }

        ClienteDAO dao = new ClienteDAO();
        boolean ativado = dao.ativarEmail(token);

        if (ativado) {
            response.sendRedirect(request.getContextPath() + "/pages/cliente/email-confirmado.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/pages/cliente/erro-verificacao.jsp");
        }
    }
}
