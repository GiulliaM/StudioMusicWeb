package controller.cliente;

import dao.AgendamentoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cliente/agendar-excluir")
public class ClienteExcluirAgendamentoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        AgendamentoDAO dao = new AgendamentoDAO();
        dao.excluirAgendamento(id);

        response.sendRedirect(request.getContextPath() + "/pages/cliente/agendamentos-cliente.jsp");
    }
}
