<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SalaDAO" %>
<%@ page import="model.Sala" %>
<%@ page import="model.Cliente" %>

<%@ include file="components/header.jsp" %>

<%
    int idSala = Integer.parseInt(request.getParameter("id"));
    Sala sala = new SalaDAO().buscarSalaPorId(idSala);
%>
<header><title>Agendar Sala</title></header>

<div class="conteudo">

    <div class="card shadow-sm p-4">
        <h3>Agendar Sala: <%= sala.getNome_tipo() %></h3>

        <form action="<%= request.getContextPath() %>/cliente/agendar" method="post">

            <input type="hidden" name="id_sala" value="<%= sala.getId_sala() %>">

            <div class="mb-3">
                <label>Data</label>
                <input type="date" name="data" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Hora início</label>
                <input type="time" name="hora_inicio" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Hora fim</label>
                <input type="time" name="hora_fim" class="form-control" required>
            </div>

            <button class="btn btn-dark">Confirmar Agendamento</button>
            <a href="salas-cliente.jsp" class="btn btn-outline-dark ms-2">Cancelar</a>
        </form>
    </div>

</div>
