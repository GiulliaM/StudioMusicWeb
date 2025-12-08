<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.SalaDAO" %>
<%@ page import="model.Sala" %>

<%@ include file="components/header.jsp" %>


<%
    SalaDAO salaDAO = new SalaDAO();
    List<Sala> salas = null;
    try {
        salas = salaDAO.listarSalas(); 
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<header><title>Salas Disponíveis | StudioMusic</title></header>

<style>
    :root {
        --roxo-principal: #4B0082; 
        --roxo-secundario: #8A2BE2; 
        --fundo-claro: #F8F8F8;
        --texto-escuro: #333333;
    }


    .conteudo {
        max-width: 1200px;
        margin: 0 auto;
        padding: 30px; 
    }

    .card-listagem {
        background: white;
        padding: 40px; 
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    }
    
    .card-listagem h3 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--roxo-principal);
        border-bottom: 3px solid var(--roxo-secundario);
        padding-bottom: 5px;
        display: inline-block;
        margin-bottom: 10px !important;
    }
    
    .card-listagem p.text-muted {
        font-size: 1.1rem;
        margin-bottom: 30px;
        color: var(--texto-escuro) !important;
    }

    .sala-item {
        background: var(--fundo-claro); 
        border: 1px solid #ddd;
        padding: 25px;
        margin-bottom: 20px;
        border-radius: 10px;
        transition: transform 0.3s, box-shadow 0.3s;
    }
    .sala-item:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 20px rgba(75, 0, 130, 0.1);
        border-color: var(--roxo-secundario);
    }
    
    .sala-item h5 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 700;
        color: black;
        font-size: 1.5rem;
        margin-bottom: 10px;
    }

    .sala-item p {
        margin-bottom: 8px;
        color: var(--texto-escuro);
    }
    
    .sala-item b {
        color: #000;
        font-size: 1.2rem;
    }
    
    .sala-item .valor {
        color: black;
        font-weight: 700;
        font-size: 1.4rem;
        display: block;
        margin-top: 10px;
    }

    .btn-roxo {
        background: var(--roxo-principal);
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        border: 2px solid var(--roxo-principal);
    }
    .btn-roxo:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        color: white;
    }

    .text-danger {
        color: #dc3545 !important;
        font-size: 1.1rem;
        font-weight: 600;
    }
</style>

<div class="conteudo">

    <div class="card-listagem shadow-sm">
        <h3>Salas Disponíveis</h3>
        <p class="text-muted">Escolha uma sala para visualizar detalhes e agendar.</p>

        <div class="mt-4">

            <% if (salas == null || salas.isEmpty()) { %>
                <p class="text-danger"><i class="bi bi-exclamation-triangle-fill me-2"></i> Nenhuma sala cadastrada ou erro ao carregar.</p>
            <% } else { %>
                
                <div class="row g-4"> <% for (Sala s : salas) { %>
                        <div class="col-lg-4 col-md-6">
                            <div class="sala-item shadow-sm">
                                <h5><%= s.getNome_tipo() %></h5>
                                
                                <p class="text-muted mb-3">
                                    <i class="bi bi-person-fill me-1"></i> Capacidade: <%= s.getCapacidade() %> pessoas <br>
                                </p>
                                
                                <p class="mb-3" style="font-size: 0.95rem;">
                                    <i class="bi bi-gear-fill me-1"></i> Equipamentos: <%= s.getEquipamentos().substring(0, Math.min(s.getEquipamentos().length(), 60)) %>...
                                </p>
                                
                                <span class="valor">R$ <%= String.format("%.2f", s.getValor_hora()) %>/hora</span>

                                <div class="mt-3">
                                    <a href="detalhes-sala.jsp?id=<%= s.getId_sala() %>" class="btn-roxo">
                                        <i class="bi bi-info-circle-fill me-1"></i> Ver detalhes
                                    </a>
                                </div>
                            </div>
                        </div>
                    <% } %>
                
                </div> <% } %>

        </div>
    </div>
</div>