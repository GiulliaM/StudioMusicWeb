<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SalaDAO" %>
<%@ page import="model.Sala" %>
<%@ page import="java.text.DecimalFormat" %>

<%@ include file="components/header.jsp" %>

<%
    // Lógica para carregar a sala
    int id = 0;
    Sala sala = null;
    try {
        id = Integer.parseInt(request.getParameter("id"));
        sala = new SalaDAO().buscarSalaPorId(id);
    } catch (NumberFormatException | NullPointerException e) {
        // Tratar erro: redirecionar ou mostrar mensagem
        response.sendRedirect("salas-cliente.jsp");
        return;
    }
    
    // Formatação para valor monetário
    DecimalFormat df = new DecimalFormat("#,##0.00");
%>
<header><title>Detalhes da Sala | <%= sala != null ? sala.getNome_tipo() : "Erro" %></title></header>

<style>
    :root {
        --roxo-principal: #4B0082; 
        --roxo-secundario: #8A2BE2; 
        --fundo-claro: #F8F8F8;
        --texto-escuro: #333333;
    }

    .conteudo {
        max-width: 900px;
        margin: 0 auto;
        padding: 30px;
    }
    
    .card-detalhes {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    }

    .card-detalhes h3 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--roxo-principal);
        border-bottom: 3px solid var(--roxo-secundario);
        padding-bottom: 5px;
        display: inline-block;
        margin-bottom: 30px !important;
        font-size: 2.5rem;
    }
    
    .card-detalhes p {
        font-size: 1.1rem;
        margin-bottom: 15px;
        color: var(--texto-escuro);
    }
    
    .card-detalhes p b {
        color: black;
        font-weight: 700;
        margin-right: 5px;
    }
    
    .equipamentos-lista {
        white-space: pre-wrap; 
        padding: 15px;
        border: 1px solid #eee;
        border-left: 5px solid var(--roxo-secundario);
        background-color: #fcfcfc;
        border-radius: 6px;
        margin-top: 10px;
    }

    .preco-destaque {
        font-size: 1.8rem;
        font-weight: 800;
        color: black;
        margin-top: 20px;
        display: block;
    }

    .btn-agendar {
        background: var(--roxo-principal);
        color: white;
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 700;
        transition: all 0.3s ease;
        border: 2px solid var(--roxo-principal);
        text-decoration: none;
    }
    .btn-agendar:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        transform: translateY(-2px);
    }

    /* Botão Secundário - Outline Preto (Ação: Voltar) */
    .btn-voltar {
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 600;
        color: var(--texto-escuro);
        border: 2px solid var(--texto-escuro);
        text-decoration: none;
        transition: all 0.3s ease;
    }
    .btn-voltar:hover {
        background-color: var(--texto-escuro);
        color: white;
    }
</style>

<div class="conteudo">
    <div class="card-detalhes shadow-sm">

        <h3><%= sala != null ? sala.getNome_tipo() : "Sala Não Encontrada" %></h3>
        
        <% if (sala != null) { %>

            <div class="mb-4 pt-3 border-top">
                
                <p>
                    <i class="bi bi-person-fill me-2"></i> 
                    <b>Capacidade:</b> <%= sala.getCapacidade() %> pessoas
                </p>
                
                <p>
                    <i class="bi bi-tag-fill me-2"></i> 
                    <b>Preço por hora:</b> 
                    <span class="preco-destaque">R$ <%= df.format(sala.getValor_hora()) %></span>
                </p>
                
                <p class="mt-4">
                    <i class="bi bi-gear-fill me-2"></i> 
                    <b>Equipamentos Incluídos:</b>
                </p>
                <div class="equipamentos-lista">
                    <%= sala.getEquipamentos() %>
                </div>
            </div>

            <div class="mt-4 pt-4 border-top">
                <a href="agendar.jsp?id=<%= sala.getId_sala() %>" class="btn-agendar">
                    <i class="bi bi-calendar-plus-fill me-2"></i> Agendar Esta Sala
                </a>

                <a href="salas-cliente.jsp" class="btn-voltar ms-3">
                    <i class="bi bi-arrow-left me-2"></i> Voltar
                </a>
            </div>
            
        <% } else { %>
            <p class="text-danger">A sala solicitada não foi encontrada ou houve um erro.</p>
            <a href="salas-cliente.jsp" class="btn-voltar ms-2">Voltar</a>
        <% } %>
    </div>
</div>