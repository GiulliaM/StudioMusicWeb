<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Cliente" %>
<%@ page import="dao.ClienteDAO" %>

<%
    ClienteDAO dao = new ClienteDAO();
    List<Cliente> clientes = dao.listarClientes();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Clientes - Admin</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>
        body { background: #f3f3f3; }

        .conteudo-admin {
            margin-left: 250px;
            padding: 25px;
        }

        @media(max-width: 800px) {
            .conteudo-admin {
                margin-left: 0;
            }
        }
    </style>
</head>

<body>

<!-- Header -->
<%@ include file="includes/header.jsp" %>

<!-- Menu -->
<%@ include file="includes/menu.jsp" %>

<div class="conteudo-admin">

    <div class="d-flex justify-content-between mb-4">
        <h2 class="fw-bold">Gerenciar Clientes</h2>

        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCadastrar">
            + Novo Cliente
        </button>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-striped table-hover align-middle">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>CPF/CNPJ</th>
                        <th>Telefone</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th style="width: 150px;">Ações</th>
                    </tr>
                </thead>

                <tbody>
                <% for (Cliente c : clientes) { %>
                    <tr>
                        <td><%= c.getId_cliente() %></td>
                        <td><%= c.getNome() %></td>
                        <td><%= c.getCpf_cnpj() %></td>
                        <td><%= c.getTelefone() %></td>
                        <td><%= c.getEmail() %></td>

                        <td>
                            <% if (c.isAtivo()) { %>
                                <span class="badge bg-success">Ativo</span>
                            <% } else { %>
                                <span class="badge bg-danger">Inativo</span>
                            <% } %>
                        </td>

                        <td>
                            <button class="btn btn-sm btn-warning"
                                    onclick="editarCliente(
                                        '<%= c.getId_cliente() %>',
                                        '<%= c.getNome() %>',
                                        '<%= c.getCpf_cnpj() %>',
                                        '<%= c.getTelefone() %>',
                                        '<%= c.getEmail() %>',
                                        '<%= c.isAtivo() %>'
                                    )"
                                    data-bs-toggle="modal" data-bs-target="#modalEditar">
                                Editar
                            </button>

                            <button class="btn btn-sm btn-danger"
                                    onclick="excluirCliente(<%= c.getId_cliente() %>)">
                                Excluir
                            </button>
                        </td>
                    </tr>
                <% } %>
                </tbody>

            </table>

        </div>
    </div>

</div>

<%@ include file="modais-clientes.jsp" %>

<script>
    function editarCliente(id, nome, cpf, tel, email, ativo) {
        document.getElementById("edit_id").value = id;
        document.getElementById("edit_nome").value = nome;
        document.getElementById("edit_cpf").value = cpf;
        document.getElementById("edit_telefone").value = tel;
        document.getElementById("edit_email").value = email;
        document.getElementById("edit_ativo").value = ativo === 'true' ? '1' : '0';
    }

    function excluirCliente(id) {
        if (confirm("Deseja realmente excluir este cliente?")) {
            window.location.href = "<%= request.getContextPath() %>/ClienteServlet?acao=excluir&id_cliente=" + id;
        }
    }
</script>

</body>
</html>
