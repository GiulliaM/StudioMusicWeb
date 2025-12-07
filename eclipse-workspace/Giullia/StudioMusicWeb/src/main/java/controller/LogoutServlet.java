package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sessao = request.getSession(false);

        String destino;

        if (sessao != null) {

            // Se existir cliente logado
            if (sessao.getAttribute("clienteLogado") != null) {
                destino = "/pages/cliente/login-cliente.jsp";

            // Se existir admin logado
            } else if ("admin".equals(sessao.getAttribute("tipo"))) {
                destino = "/login.jsp";

            } else {
                destino = "/login.jsp"; // fallback
            }

            sessao.invalidate();
        } else {
            destino = "/login.jsp";
        }

        response.sendRedirect(request.getContextPath() + destino);
    }
}
