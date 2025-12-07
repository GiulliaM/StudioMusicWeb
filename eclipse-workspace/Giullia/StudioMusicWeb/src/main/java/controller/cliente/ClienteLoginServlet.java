package controller.cliente;

import dao.ClienteDAO;
import model.Cliente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cliente/login")
public class ClienteLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        ClienteDAO dao = new ClienteDAO();
        Cliente cliente = dao.autenticar(email, senha);

        if (cliente == null) {
            request.setAttribute("erro", "E-mail ou senha inválidos!");
            request.getRequestDispatcher("/pages/cliente/login-cliente.jsp").forward(request, response);
            return;
        }

        if (!cliente.isAtivo()) {
            request.setAttribute("erro", "Confirme seu e-mail antes de fazer login.");
            request.getRequestDispatcher("/pages/cliente/login-cliente.jsp").forward(request, response);
            return;
        }

        HttpSession sessao = request.getSession();
        sessao.setAttribute("clienteLogado", cliente);

        response.sendRedirect(request.getContextPath() + "/pages/cliente/home-cliente.jsp");
    }
}
