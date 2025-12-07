<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Cliente" %>
<%@ page import="dao.AgendamentoDAO" %>
<%@ page import="model.Agendamento" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>

<%@ include file="components/header.jsp" %>

<%
    // Lógica para listar agendamentos
    List<Agendamento> lista = null;
    try {
        lista = new AgendamentoDAO().listarPorCliente(cliente.getId_cliente());
    } catch (Exception e) {
        lista = java.util.Collections.emptyList();
    }
    
    // Formatador de moeda
    DecimalFormat df = new DecimalFormat("#,##0.00");
%>

<header><title>Meus Agendamentos | StudioMusic</title></header>

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
        max-width: 1300px;
        margin: 0 auto;
        padding: 30px;
    }

    .card-agendamentos {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        border: 1px solid #eee;
    }
    
    .card-agendamentos h3 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--roxo-principal);
        border-bottom: 3px solid var(--roxo-secundario);
        padding-bottom: 5px;
        display: inline-block;
        margin-bottom: 25px !important;
        font-size: 2.2rem;
    }

    .table {
        background-color: white;
        color: var(--texto-escuro);
        border: 1px solid #ddd;
    }
    
    .table thead th {
        background-color: var(--roxo-principal) !important; 
        color: white !important; 
        border-color: #6a0dad !important; 
        font-weight: 700;
        text-transform: uppercase;
        font-size: 0.9rem;
    }
    
    .table tbody tr:hover {
        background-color: #f0f0f0; 
    }

    .table tbody td {
        border-color: #ddd;
        vertical-align: middle;
        font-size: 0.95rem;
    }
    
    .valor-total {
        font-weight: 700;
        color: var(--roxo-secundario); 
    }
    
    .status-badge {
        font-weight: 600;
        padding: 5px 10px;
        border-radius: 4px;
        font-size: 0.85rem;
        text-transform: uppercase;
    }
    .status-REALIZADO { background: #28a745; color: white; } 
    .status-PENDENTE { background: #ffc107; color: #333; } 
    .status-CANCELADO { background: #dc3545; color: white; } 

    .btn-action-roxo {
        background-color: var(--roxo-principal);
        border-color: var(--roxo-principal);
        color: white;
        font-weight: 600;
        transition: all 0.3s;
        padding: 6px 12px;
        border-radius: 6px;
    }
    .btn-action-roxo:hover {
        background-color: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
    }

    .btn-action-danger {
        background-color: #dc3545; 
        border-color: #dc3545;
        color: white;
        font-weight: 600;
        padding: 6px 12px;
        border-radius: 6px;
    }
    .btn-action-danger:hover {
        background-color: #c82333;
        border-color: #c82333;
    }
    
    .empty-message {
        border: 1px dashed #ccc;
        border-radius: 8px;
        padding: 30px;
        margin-top: 20px;
        text-align: center;
        background-color: white;
    }
    .empty-message a {
        background: var(--roxo-principal);
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        text-decoration: none;
    }
    .empty-message a:hover {
        background: var(--roxo-secundario);
    }
</style>

<div class="conteudo">

    <div class="card-agendamentos shadow-sm">
        <h3>Meus Agendamentos</h3>

        <% if (lista.isEmpty()) { %>
            <div class="empty-message">
                <i class="bi bi-calendar-x-fill display-4" style="color: var(--roxo-secundario);"></i>
                <p class="mt-3 fs-5" style="color: var(--texto-escuro);">Você não possui agendamentos ativos.</p>
                <a href="salas-cliente.jsp" class="mt-3">
                    <i class="bi bi-mic-fill me-2"></i> Agendar uma Sala Agora
                </a>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-bordered table-hover mt-3">
                    <thead class="table-dark">
                        <tr>
                            <th><i class="bi bi-mic-fill"></i> Sala</th>
                            <th><i class="bi bi-calendar-date"></i> Data</th>
                            <th><i class="bi bi-clock"></i> Início</th>
                            <th><i class="bi bi-clock"></i> Fim</th>
                            <th><i class="bi bi-check2-circle"></i> Status</th>
                            <th>Valor Total</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
        
                    <tbody>
                    <% for (Agendamento a : lista) { %>
                        <tr>
                            <td><%= a.getNome_sala() %></td>
                            <td><%= a.getData_agendamento() %></td>
                            <td><%= a.getHora_inicio() %></td>
                            <td><%= a.getHora_fim() %></td>
                            <td>
                                <span class="status-badge status-<%= a.getStatus().toUpperCase() %>">
                                    <%= a.getStatus() %>
                                </span>
                            </td>
                            <td class="valor-total">R$ <%= df.format(a.getValor_total()) %></td>
                            <td>
                                <a href="editar-agendamento.jsp?id=<%= a.getId_agendamento() %>" class="btn btn-sm btn-action-roxo me-2">
                                    <i class="bi bi-pencil-fill"></i> Editar
                                </a>
                            
                                <a href="<%= request.getContextPath() %>/cliente/agendar-excluir?id=<%= a.getId_agendamento() %>"
                                   class="btn btn-sm btn-action-danger"
                                   onclick="return confirm('Tem certeza que deseja cancelar este agendamento?');">
                                    <i class="bi bi-x-circle-fill"></i> Cancelar
                                </a>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>

    </div>

</div>