<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Cliente" %>

<%@ include file="components/header.jsp" %>

<div class="conteudo">

    <div class="card shadow-sm p-4" style="max-width: 500px; margin: auto">
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
                <input type="password" name="senha" class="form-control">
            </div>

            <button class="btn btn-dark w-100">Salvar Alterações</button>

        </form>

    </div>

</div>
