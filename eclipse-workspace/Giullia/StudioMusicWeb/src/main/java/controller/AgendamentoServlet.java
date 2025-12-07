package controller;

import dao.AgendamentoDAO;
import dao.SalaDAO;
import model.Agendamento;
import model.Sala;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Time;
import java.sql.Date;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

@WebServlet("/AgendamentoServlet")
public class AgendamentoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private double calcularValorTotal(double valorHora, Time horaInicio, Time horaFim) {
        try {
            LocalTime inicio = horaInicio.toLocalTime();
            LocalTime fim = horaFim.toLocalTime();
            Duration dur = Duration.between(inicio, fim);
            long minutos = dur.toMinutes();
            double horas = minutos / 60.0;

            if (horas <= 0) return 0.0;

            double total = valorHora * horas;
            BigDecimal bd = BigDecimal.valueOf(total).setScale(2, RoundingMode.HALF_UP);
            return bd.doubleValue();

        } catch (Exception e) {
            return 0.0;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");
        AgendamentoDAO dao = new AgendamentoDAO();
        SalaDAO salaDAO = new SalaDAO();


        if ("cadastrar".equals(acao)) {
            try {
                int id_cliente = Integer.parseInt(request.getParameter("id_cliente"));
                int id_sala = Integer.parseInt(request.getParameter("id_sala"));
                Date data = Date.valueOf(request.getParameter("data_agendamento"));
                Time hora_inicio = Time.valueOf(request.getParameter("hora_inicio"));
                Time hora_fim = Time.valueOf(request.getParameter("hora_fim"));
                String status = request.getParameter("status");

                Sala s = salaDAO.buscarSalaPorId(id_sala);
                double valorHora = (s != null) ? s.getValor_hora() : 0.0;

                double valor_total = calcularValorTotal(valorHora, hora_inicio, hora_fim);

                Agendamento a = new Agendamento(
                        0, id_cliente, id_sala, data, hora_inicio, hora_fim, status, valor_total
                );
                dao.cadastrarAgendamento(a);

            } catch (Exception e) {
                System.out.println("Erro ao cadastrar agendamento: " + e.getMessage());
            }

            response.sendRedirect("pages/admin/agendamentos.jsp");
            return;
        }

        /* ============================
                    E D I T A R
           ============================ */
        if ("editar".equals(acao)) {
            try {
                int id_agendamento = Integer.parseInt(request.getParameter("id_agendamento"));
                int id_cliente = Integer.parseInt(request.getParameter("id_cliente"));
                int id_sala = Integer.parseInt(request.getParameter("id_sala"));
                Date data = Date.valueOf(request.getParameter("data_agendamento"));
                Time hora_inicio = Time.valueOf(request.getParameter("hora_inicio"));
                Time hora_fim = Time.valueOf(request.getParameter("hora_fim"));
                String status = request.getParameter("status");

                Sala s = salaDAO.buscarSalaPorId(id_sala);
                double valorHora = (s != null) ? s.getValor_hora() : 0.0;

                double valor_total = calcularValorTotal(valorHora, hora_inicio, hora_fim);

                Agendamento a = new Agendamento(
                        id_agendamento, id_cliente, id_sala,
                        data, hora_inicio, hora_fim, status, valor_total
                );

                dao.editarAgendamento(a);

            } catch (Exception e) {
                System.out.println("Erro ao editar agendamento: " + e.getMessage());
            }

            response.sendRedirect("pages/admin/agendamentos.jsp");
            return;
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        AgendamentoDAO dao = new AgendamentoDAO();

        if ("excluir".equals(acao)) {
            try {
                int id = Integer.parseInt(request.getParameter("id_agendamento"));

                dao.atualizarStatusNoBanco(id, "Cancelado");

            } catch (NumberFormatException e) {
                System.out.println("Erro ao cancelar agendamento: " + e.getMessage());
            }
        }

        response.sendRedirect("pages/admin/agendamentos.jsp");
    }
}
