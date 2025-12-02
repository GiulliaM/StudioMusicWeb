<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Cliente" %>

<%
    Cliente cliente = (Cliente) session.getAttribute("clienteLogado");
    if (cliente == null) {
        response.sendRedirect("login-cliente.jsp");
        return;
    }
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    :root {
        --roxo-principal: #4B0082; 
        --roxo-secundario: #8A2BE2; 
        --fundo-escuro: #111111; 
        --texto-claro: #F0F0F0;
        --cinza-claro: #CCCCCC;
    }

    body {
        padding-top: 70px; 
    }
    
    .topo {
        background: var(--fundo-escuro); 
        padding: 15px 30px;
        color: var(--texto-claro);
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed; 
        width: 100%;
        top: 0;
        z-index: 1030;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        font-family: 'Inter', sans-serif;
    }
    
    .topo h3 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--texto-claro); 
        margin: 0;
    }


    .nav-links a {
        color: var(--cinza-claro);
        text-decoration: none;
        margin-right: 25px;
        font-weight: 500;
        transition: color 0.3s;
        padding: 5px 0;
        border-bottom: 2px solid transparent;
    }
    .nav-links a:hover {
        color: white; 
        border-bottom: 2px solid white; 
    }

    .user-info {
        display: flex;
        align-items: center;
    }
    .user-info span {
         color: var(--cinza-claro);
    }
    .user-info b {
        color: white; 
        font-weight: 700;
        margin-right: 15px;
    }
    
    .btn-logout {
        background: var(--roxo-principal);
        color: white;
        padding: 6px 15px;
        border-radius: 6px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        border: 1px solid var(--roxo-principal);
        margin-left: 15px;
    }
    .btn-logout:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        color: white;
    }

    .conteudo {
        padding: 0; 
    }
</style>

<div class="topo">
    <h3>StudioMusic</h3>

    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/pages/cliente/home-cliente.jsp"><i class="bi bi-house-door-fill me-1"></i> Home</a>
        <a href="<%= request.getContextPath() %>/pages/cliente/salas-cliente.jsp"><i class="bi bi-mic-fill me-1"></i> Salas</a>
        <a href="<%= request.getContextPath() %>/pages/cliente/agendamentos-cliente.jsp"><i class="bi bi-calendar-check me-1"></i> Meus Agendamentos</a>
        <a href="<%= request.getContextPath() %>/pages/cliente/perfil.jsp"><i class="bi bi-person-fill me-1"></i> Meu Perfil</a>
    </div>

    <div class="user-info">
        <span class="me-2">Logado como</span> <b><%= cliente.getNome() %></b>
        <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn-logout" title="Sair da Conta">
             <i class="bi bi-box-arrow-right"></i> Sair
        </a>
    </div>
</div>