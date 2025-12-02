<%@ page import="model.Agendamento" %>
<%@ page import="dao.AgendamentoDAO" %>
<%@ page import="dao.SalaDAO" %>
<%@ page import="model.Sala" %>
<%@ include file="components/header.jsp" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Agendamento ag = new AgendamentoDAO().buscarPorId(id);
    Sala sala = new SalaDAO().buscarSalaPorId(ag.getId_sala());
%>

<div class="conteudo">

    <div class="card shadow-sm p-4">
        <h3>Editar Agendamento - <%= sala.getNome_tipo() %></h3>

        <form action="<%= request.getContextPath() %>/cliente/agendar-editar" method="post">

            <input type="hidden" name="id_agendamento" value="<%= ag.getId_agendamento() %>">

            <div class="mb-3">
                <label>Sala</label>
                <input type="text" class="form-control" value="<%= sala.getNome_tipo() %>" disabled>
            </div>

            <div class="mb-3">
                <label>Data</label>
                <input type="date" name="data" class="form-control" value="<%= ag.getData_agendamento() %>" required>
            </div>

            <div class="mb-3">
                <label>Hora início</label>
                <input type="time" name="hora_inicio" class="form-control" value="<%= ag.getHora_inicio() %>" required>
            </div>

            <div class="mb-3">
                <label>Hora fim</label>
                <input type="time" name="hora_fim" class="form-control" value="<%= ag.getHora_fim() %>" required>
            </div>

            <button class="btn btn-dark">Salvar Alterações</button>
            <a href="agendamentos-cliente.jsp" class="btn btn-outline-dark ms-2">Cancelar</a>

            <p class="text-danger mt-2"><%= request.getAttribute("erro") != null ? request.getAttribute("erro") : "" %></p>
        </form>
    </div>

</div>
