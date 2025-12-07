package controller.cliente;

import dao.AgendamentoDAO;
import dao.SalaDAO;
import model.Agendamento;
import model.Sala;

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

        // Adicionar segundos corretamente
        if (hInicio.length() == 5) hInicio += ":00";
        if (hFim.length() == 5) hFim += ":00";

        Time inicio = Time.valueOf(hInicio);
        Time fim = Time.valueOf(hFim);

        AgendamentoDAO dao = new AgendamentoDAO();
        Agendamento antigo = dao.buscarPorId(idAgendamento);

        if (antigo == null) {
            request.setAttribute("erro", "Agendamento não encontrado.");
            request.getRequestDispatcher("/pages/cliente/agendamentos-cliente.jsp")
                   .forward(request, response);
            return;
        }

        // Verificar conflito ignorando o próprio agendamento
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

        // Buscar sala para recalcular valor
        Sala salaInfo = new SalaDAO().buscarSalaPorId(antigo.getId_sala());

        long diffMs = fim.getTime() - inicio.getTime();
        double horas = diffMs / (1000.0 * 60 * 60);

        double valorTotal = horas * salaInfo.getValor_hora();

        // Atualizar o objeto
        antigo.setData_agendamento(data);
        antigo.setHora_inicio(inicio);
        antigo.setHora_fim(fim);
        antigo.setValor_total(valorTotal);

        // Atualizar banco
        dao.editarAgendamento(antigo);

        response.sendRedirect(request.getContextPath() + "/pages/cliente/agendamentos-cliente.jsp");
    }
}
