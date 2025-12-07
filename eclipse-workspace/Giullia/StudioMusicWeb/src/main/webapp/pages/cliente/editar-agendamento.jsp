<%@ page import="model.Agendamento" %>
<%@ page import="dao.AgendamentoDAO" %>
<%@ page import="dao.SalaDAO" %>
<%@ page import="model.Sala" %>
<%@ include file="components/header.jsp" %>

<%
    // Lógica para carregar o agendamento e a sala
    int id = 0;
    Agendamento ag = null;
    Sala sala = null;
    try {
        id = Integer.parseInt(request.getParameter("id"));
        ag = new AgendamentoDAO().buscarPorId(id);
        if (ag != null) {
            sala = new SalaDAO().buscarSalaPorId(ag.getId_sala());
        } else {
            response.sendRedirect("agendamentos-cliente.jsp");
            return;
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("agendamentos-cliente.jsp");
        return;
    }
%>

<header><title>Editar Agendamento | StudioMusic</title></header>

<style>
    
    :root {
        --roxo-principal: #4B0082; /* Indigo Profundo */
        --roxo-secundario: #8A2BE2; /* Violeta */
        --fundo-claro: #F8F8F8;
        --texto-escuro: #333333;
    }

    body {
        background-color: var(--fundo-claro); 
        color: var(--texto-escuro);
    }

    .conteudo {
        max-width: 650px; /* Largura focada para formulário */
        margin: 0 auto;
        padding: 30px;
    }

    /* Card Principal do Formulário */
    .card-formulario {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        border: 1px solid #eee;
    }
    
    .card-formulario h3 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--roxo-principal);
        border-bottom: 3px solid var(--roxo-secundario);
        padding-bottom: 5px;
        display: inline-block;
        margin-bottom: 30px !important;
        font-size: 2rem;
    }
    
    /* Estilização dos Inputs e Labels */
    .form-control {
        border-radius: 6px;
        border: 1px solid #ddd;
        color: var(--texto-escuro);
    }
    .form-control:focus {
        border-color: var(--roxo-secundario);
        box-shadow: 0 0 0 0.25rem rgba(138, 43, 226, 0.25);
    }
    .form-control[disabled] {
        background-color: #f0f0f0;
        opacity: 0.7;
    }
    
    label {
        font-weight: 600;
        color: var(--texto-escuro);
        margin-bottom: 5px;
    }

    /* Botão Principal - Salvar (Roxo) */
    .btn-salvar {
        background: var(--roxo-principal);
        color: white;
        padding: 10px 25px;
        border-radius: 8px;
        font-weight: 700;
        transition: all 0.3s ease;
        border: 2px solid var(--roxo-principal);
    }
    .btn-salvar:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        transform: translateY(-2px);
    }

    /* Botão Secundário - Cancelar (Outline) */
    .btn-cancelar {
        background: transparent;
        color: var(--texto-escuro);
        padding: 10px 25px;
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
    
    /* Mensagem de Erro */
    .text-danger {
        color: #dc3545 !important;
        font-weight: 600;
        margin-top: 15px !important;
    }
</style>

<div class="conteudo">

    <div class="card-formulario shadow-sm">
        <h3>Editar Agendamento - <%= sala.getNome_tipo() %></h3>

        <form action="<%= request.getContextPath() %>/cliente/agendar-editar" method="post">

            <input type="hidden" name="id_agendamento" value="<%= ag.getId_agendamento() %>">
            
            <div class="mb-3">
                <label>Sala</label>
                <input type="text" class="form-control" value="<%= sala.getNome_tipo() %> (Capacidade: <%= sala.getCapacidade() %>)" disabled>
            </div>
            
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label>Data</label>
                    <input type="date" name="data" class="form-control" value="<%= ag.getData_agendamento() %>" required>
                </div>
                
                <div class="col-md-4 mb-3">
                    <label>Hora início</label>
                    <input type="time" name="hora_inicio" class="form-control" value="<%= ag.getHora_inicio() %>" required>
                </div>
                
                <div class="col-md-4 mb-3">
                    <label>Hora fim</label>
                    <input type="time" name="hora_fim" class="form-control" value="<%= ag.getHora_fim() %>" required>
                </div>
            </div>

            <div class="mt-4 pt-3 border-top">
                <button type="submit" class="btn-salvar">
                    <i class="bi bi-floppy-fill me-2"></i> Salvar Alterações
                </button>
                <a href="agendamentos-cliente.jsp" class="btn-cancelar ms-3">
                    <i class="bi bi-x-circle-fill me-2"></i> Cancelar
                </a>
            </div>

            <p class="text-danger mt-2"><%= request.getAttribute("erro") != null ? request.getAttribute("erro") : "" %></p>
        </form>
    </div>

</div>