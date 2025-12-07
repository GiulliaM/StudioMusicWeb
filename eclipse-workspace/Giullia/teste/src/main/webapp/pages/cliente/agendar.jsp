<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SalaDAO" %>
<%@ page import="model.Sala" %>
<%@ page import="model.Cliente" %>
<%@ page import="java.text.DecimalFormat" %>

<%@ include file="components/header.jsp" %>

<%
    // Lógica para carregar a sala
    int idSala = 0;
    Sala sala = null;
    try {
        idSala = Integer.parseInt(request.getParameter("id"));
        sala = new SalaDAO().buscarSalaPorId(idSala);
        
        if (sala == null) {
            response.sendRedirect("salas-cliente.jsp");
            return;
        }
    } catch (NumberFormatException | NullPointerException e) {
        response.sendRedirect("salas-cliente.jsp");
        return;
    }
    
    // Formatação para valor monetário
    DecimalFormat df = new DecimalFormat("#,##0.00");
%>

<header><title>Agendar Sala: <%= sala.getNome_tipo() %></title></header>

<style>
    
    :root {
        --roxo-principal: #4B0082; 
        --roxo-secundario: #8A2BE2; 
        --fundo-claro: #F8F8F8;
        --texto-escuro: #333333;
    }

    body {
        background-color: var(--fundo-claro); 
        color: var(--texto-escuro);
    }

    .conteudo {
        max-width: 650px; 
        margin: 0 auto;
        padding: 30px;
    }

    .card-agendamento-form {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        border: 1px solid #eee;
    }
    
    .card-agendamento-form h3 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--roxo-principal);
        border-bottom: 3px solid var(--roxo-secundario);
        padding-bottom: 5px;
        display: inline-block;
        margin-bottom: 30px !important;
        font-size: 2rem;
    }
    
    .sala-info-agendar {
        background-color: #f7f7f7;
        padding: 15px;
        margin-bottom: 25px;
        border-radius: 6px;
        border-left: 5px solid var(--roxo-secundario);
    }
    .sala-info-agendar p {
        margin: 0;
        font-size: 1.1rem;
        color: var(--texto-escuro);
    }
    .sala-info-agendar p b {
        color: var(--roxo-principal);
    }
    
    .form-control {
        border-radius: 6px;
        border: 1px solid #ddd;
        color: var(--texto-escuro);
    }
    .form-control:focus {
        border-color: var(--roxo-secundario);
        box-shadow: 0 0 0 0.25rem rgba(138, 43, 226, 0.25);
    }
    
    label {
        font-weight: 600;
        color: var(--texto-escuro);
        margin-bottom: 5px;
    }

    .btn-confirmar {
        background: var(--roxo-principal);
        color: white;
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 700;
        transition: all 0.3s ease;
        border: 2px solid var(--roxo-principal);
        margin-top: 15px;
    }
    .btn-confirmar:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        transform: translateY(-2px);
    }

    .btn-cancelar {
        background: transparent;
        color: var(--texto-escuro);
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 600;
        border: 2px solid var(--texto-escuro);
        transition: all 0.3s ease;
        text-decoration: none;
    }
    .btn-cancelar:hover {
        background: var(--texto-escuro);
        color: white;
    }
</style>

<div class="conteudo">

    <div class="card-agendamento-form shadow-sm">
        <h3>Agendar Sala: <%= sala.getNome_tipo() %></h3>
        
        <div class="sala-info-agendar">
            <p>
                <i class="bi bi-person-fill me-2" style="color: var(--roxo-secundario);"></i> 
                Capacidade: <b><%= sala.getCapacidade() %> pessoas</b>
            </p>
            <p class="mt-1">
                <i class="bi bi-currency-dollar me-2" style="color: var(--roxo-secundario);"></i> 
                Preço: <b>R$ <%= df.format(sala.getValor_hora()) %>/hora</b>
            </p>
        </div>

        <form action="<%= request.getContextPath() %>/cliente/agendar" method="post">

            <input type="hidden" name="id_sala" value="<%= sala.getId_sala() %>">

            <div class="mb-3">
                <label>Data</label>
                <input type="date" name="data" class="form-control" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label>Hora início</label>
                    <input type="time" name="hora_inicio" class="form-control" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Hora fim</label>
                    <input type="time" name="hora_fim" class="form-control" required>
                </div>
            </div>

            <div class="mt-4 pt-3 border-top" style="border-color: #eee !important;">
                <button type="submit" class="btn-confirmar">
                    <i class="bi bi-calendar-check-fill me-2"></i> Confirmar Agendamento
                </button>
                <a href="salas-cliente.jsp" class="btn-cancelar ms-3">
                    <i class="bi bi-x-circle-fill me-2"></i> Cancelar
                </a>
            </div>
        </form>
    </div>

</div>