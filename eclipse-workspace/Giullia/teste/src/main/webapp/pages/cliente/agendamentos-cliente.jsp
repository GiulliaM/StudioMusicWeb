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
        // Em caso de erro ao carregar a lista
        lista = java.util.Collections.emptyList();
        // Considere logar o erro aqui: e.printStackTrace();
    }
    
    // Formatador de moeda
    DecimalFormat df = new DecimalFormat("#,##0.00");
%>

<header><title>Meus Agendamentos | StudioMusic</title></header>

<style>
    /* Estilos específicos da página de agendamentos */
    
    /* Variaveis Globais (Recomendado no header.jsp, mas repetidas aqui para contexto) */
    :root {
        --fundo-principal: #0A0A0A;
        --fundo-card: #181818;
        --destaque-ciano: #00FFFF;
        --texto-claro: #F0F0F0;
        --texto-secundario: #AAAAAA;
        --texto-link: #CCCCCC;
    }

    .conteudo {
        max-width: 1300px; /* Mais largo para a tabela */
        margin: 0 auto;
        padding: 30px;
    }

    .card {
        padding: 40px !important;
        background: var(--fundo-card) !important;
        border: 1px solid #333 !important;
    }
    
    .card h3 {
        /* Garante que o título seja grande e em cor clara */
        font-size: 2.2rem;
        margin-bottom: 20px !important;
        color: var(--texto-claro) !important;
    }

    /* Tabela Dark Mode */
    .table {
        background-color: var(--fundo-card);
        color: var(--texto-claro);
        border: 1px solid #333;
    }
    
    .table thead th {
        background-color: var(--fundo-principal) !important; 
        color: white !important;
        border-color: #333 !important;
        font-weight: 700;
        text-transform: uppercase;
        font-size: 0.9rem;
    }
    
    .table tbody tr {
        transition: background-color 0.3s;
    }

    .table tbody tr:hover {
        background-color: #252525; /* Destaque sutil na linha */
    }

    .table tbody td {
        border-color: #333;
        vertical-align: middle;
        font-size: 0.95rem;
    }
    
    /* Cores do Status */
    .status-badge {
        font-weight: 600;
        padding: 5px 10px;
        border-radius: 4px;
        font-size: 0.85rem;
        text-transform: uppercase;
    }
    /* Estilos Semelhantes ao Ciano/Tema */
    .status-CONFIRMADO { background: #3CB371; color: white; } /* Verde - Confirmado */
    .status-PENDENTE { background: #FFC107; color: #333; } /* Amarelo - Pendente */
    .status-CANCELADO { background: #FF6347; color: white; } /* Vermelho - Cancelado */

    /* Botões de Ação na Tabela */
    .btn-action-ciano {
        /* Estilo do botão primário (Editar) */
        background-color: var(--destaque-ciano);
        border-color: var(--destaque-ciano);
        color: black;
        font-weight: 700;
        transition: all 0.3s;
    }
    .btn-action-ciano:hover {
        background-color: transparent;
        color: var(--destaque-ciano);
    }

    .btn-action-danger {
        /* Estilo do botão de cancelamento */
        background-color: #FF6347; /* Vermelho forte para Cancelar */
        border-color: #FF6347;
        color: white;
        font-weight: 600;
    }
    .btn-action-danger:hover {
        background-color: #CC4C36;
        border-color: #CC4C36;
        color: white;
    }
    
    /* Valor Total em Destaque */
    .valor-total {
        font-weight: 700;
        color: var(--destaque-ciano);
    }
</style>

<div class="conteudo">

    <div class="card shadow-sm">
        <h3>Meus Agendamentos</h3>

        <% if (lista.isEmpty()) { %>
            <div class="p-4 text-center mt-3" style="border: 1px solid #333; border-radius: 8px; background: #252525;">
                <i class="bi bi-calendar-x-fill display-4" style="color: var(--texto-secundario);"></i>
                <p class="mt-3 fs-5" style="color: var(--texto-secundario);">Você não possui agendamentos ativos.</p>
                <a href="salas-cliente.jsp" class="btn-main-action mt-3">
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
                            <th><i class="bi bi-currency-dollar"></i> Valor Total</th>
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
                                <a href="editar-agendamento.jsp?id=<%= a.getId_agendamento() %>" class="btn btn-sm btn-action-ciano me-2">
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