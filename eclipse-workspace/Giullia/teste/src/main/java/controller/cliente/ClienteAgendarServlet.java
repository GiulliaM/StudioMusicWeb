package controller.cliente;

import dao.AgendamentoDAO;
import dao.SalaDAO;
import model.Agendamento;
import model.Cliente;
import model.Sala;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/cliente/agendar")
public class ClienteAgendarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cliente cliente = (Cliente) request.getSession().getAttribute("clienteLogado");

        if (cliente == null) {
            response.sendRedirect(request.getContextPath() + "/pages/cliente/login-cliente.jsp");
            return;
        }

        int idSala = Integer.parseInt(request.getParameter("id_sala"));
        Date data = Date.valueOf(request.getParameter("data"));
        Time inicio = Time.valueOf(request.getParameter("hora_inicio") + ":00");
        Time fim = Time.valueOf(request.getParameter("hora_fim") + ":00");

        AgendamentoDAO dao = new AgendamentoDAO();

        // validar conflito
        boolean livre = dao.salaDisponivel(idSala, data, inicio, fim);

        if (!livre) {
            request.setAttribute("erro", "Este horário já está reservado!");
            request.getRequestDispatcher("/pages/cliente/agendar.jsp?id=" + idSala).forward(request, response);
            return;
        }

        // Buscar sala para calcular valor
        Sala salaInfo = new SalaDAO().buscarSalaPorId(idSala);

        long diffMs = fim.getTime() - inicio.getTime();
        double horas = diffMs / (1000.0 * 60 * 60);
        double valorTotal = horas * salaInfo.getValor_hora();

        Agendamento ag = new Agendamento();
        ag.setId_cliente(cliente.getId_cliente());
        ag.setId_sala(idSala);
        ag.setData_agendamento(data);
        ag.setHora_inicio(inicio);
        ag.setHora_fim(fim);
        ag.setStatus("Pendente");
        ag.setValor_total(valorTotal);

        dao.cadastrarAgendamento(ag);

        response.sendRedirect(request.getContextPath() + "/pages/cliente/agendamentos-cliente.jsp");
    }
}
