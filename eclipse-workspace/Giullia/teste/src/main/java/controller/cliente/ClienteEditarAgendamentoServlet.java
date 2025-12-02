package controller.cliente;

import dao.AgendamentoDAO;
import model.Agendamento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/cliente/agendar-editar")
public class ClienteEditarAgendamentoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idAgendamento = Integer.parseInt(request.getParameter("id_agendamento"));
        Date data = Date.valueOf(request.getParameter("data"));

        String hInicio = request.getParameter("hora_inicio");
        String hFim = request.getParameter("hora_fim");

        // Corrigir formato sem segundos
        if (hInicio.length() == 5) hInicio += ":00";
        if (hFim.length() == 5) hFim += ":00";

        Time inicio = Time.valueOf(hInicio);
        Time fim = Time.valueOf(hFim);

        AgendamentoDAO dao = new AgendamentoDAO();
        Agendamento antigo = dao.buscarPorId(idAgendamento);

        if (antigo == null) {
            request.setAttribute("erro", "Agendamento não encontrado.");
            request.getRequestDispatcher("/pages/cliente/agendamentos-cliente.jsp").forward(request, response);
            return;
        }

        boolean livre = dao.salaDisponivelEditar(
                antigo.getId_sala(),
                data,
                inicio,
                fim,
                idAgendamento
        );


        if (!livre) {
            request.setAttribute("erro", "Este horário já está reservado!");
            request.getRequestDispatcher("/pages/cliente/editar-agendamento.jsp?id=" + idAgendamento)
                   .forward(request, response);
            return;
        }

        antigo.setData_agendamento(data);
        antigo.setHora_inicio(inicio);
        antigo.setHora_fim(fim);

        dao.editarAgendamento(antigo);

        response.sendRedirect(request.getContextPath() + "/pages/cliente/agendamentos-cliente.jsp");
    }
}
