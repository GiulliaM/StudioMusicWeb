<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Cliente" %>

<%@ include file="components/header.jsp" %>

<header><title>Editar Perfil | StudioMusic</title></header>

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
        padding: 30px;
    }

    /* Card Principal do Formulário */
    .card-formulario {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        border: 1px solid #eee;
        max-width: 550px; /* Largura ajustada para o formulário */
        margin: auto; /* Centraliza o card */
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
    
    label {
        font-weight: 600;
        color: var(--texto-escuro);
        margin-bottom: 5px;
    }

    /* Botão Principal - Salvar (Roxo) */
    .btn-salvar {
        background: var(--roxo-principal);
        color: white;
        padding: 12px 25px;
        border-radius: 8px;
        font-weight: 700;
        transition: all 0.3s ease;
        border: 2px solid var(--roxo-principal);
        margin-top: 15px;
    }
    .btn-salvar:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        transform: translateY(-2px);
    }
</style>

<div class="conteudo">

    <div class="card-formulario shadow-sm">
        <h3>Editar Perfil</h3>

        <form action="<%= request.getContextPath() %>/cliente/atualizar-perfil" method="post">

            <input type="hidden" name="id_cliente" value="<%= cliente.getId_cliente() %>">

            <div class="mb-3">
                <label>Nome</label>
                <input type="text" name="nome" class="form-control" value="<%= cliente.getNome() %>" required>
            </div>

            <div class="mb-3">
                <label>E-mail</label>
                <input type="email" name="email" class="form-control" value="<%= cliente.getEmail() %>" required>
            </div>

            <div class="mb-3">
                <label>CPF/CNPJ</label>
                <input type="text" name="cpf" class="form-control" value="<%= cliente.getCpf_cnpj() %>" required>
            </div>

            <div class="mb-3">
                <label>Telefone</label>
                <input type="text" name="telefone" class="form-control" value="<%= cliente.getTelefone() %>" required>
            </div>

            <div class="mb-3">
                <label>Senha nova (opcional)</label>
                <input type="password" name="senha" class="form-control" placeholder="Deixe em branco para manter a senha atual">
            </div>

            <button type="submit" class="btn-salvar w-100">
                <i class="bi bi-save-fill me-2"></i> Salvar Alterações
            </button>
            
            <a href="perfil.jsp" class="btn btn-outline-secondary w-100 mt-2" style="color: var(--texto-escuro); border-color: #ddd;">
                <i class="bi bi-x-circle-fill me-2"></i> Cancelar
            </a>
        </form>
    </div>

</div>