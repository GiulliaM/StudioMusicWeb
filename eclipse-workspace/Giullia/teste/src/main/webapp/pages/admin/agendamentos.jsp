<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Agendamento" %>
<%@ page import="dao.AgendamentoDAO" %>

<%
    AgendamentoDAO dao = new AgendamentoDAO();
    List<Agendamento> agendamentos = dao.listarAgendamentos();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Agendamentos - Admin</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        .conteudo-admin { margin-left: 250px; padding: 25px; }
        @media(max-width:800px){ .conteudo-admin{ margin-left:0 } }
    </style>
</head>
<body>

<%@ include file="includes/header.jsp" %>
<%@ include file="includes/menu.jsp" %>

<div class="conteudo-admin">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Agendamentos</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCadastrar">
            <i class="bi bi-plus-circle"></i> Novo Agendamento
        </button>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-striped table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Sala</th>
                        <th>Data</th>
                        <th>Início</th>
                        <th>Fim</th>
                        <th>Status</th>
                        <th>Valor</th>
                        <th style="width:140px">Ações</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Agendamento a : agendamentos) { %>
                    <tr>
                        <td><%= a.getId_agendamento() %></td>
                        <td><%= (a.getNome_cliente()!=null? a.getNome_cliente() : a.getId_cliente()) %></td>
                        <td><%= (a.getNome_sala()!=null? a.getNome_sala() : a.getId_sala()) %></td>
                        <td><%= a.getData_agendamento() %></td>
                        <td><%= a.getHora_inicio() %></td>
                        <td><%= a.getHora_fim() %></td>
                        <td><%= a.getStatus() %></td>
                        <td>R$ <%= String.format("%.2f", a.getValor_total()) %></td>
                        <td>
                            <button class="btn btn-sm btn-warning"
                                onclick="editarAgendamento(
                                    '<%= a.getId_agendamento() %>',
                                    '<%= a.getId_cliente() %>',
                                    '<%= a.getId_sala() %>',
                                    '<%= a.getData_agendamento() %>',
                                    '<%= a.getHora_inicio() %>',
                                    '<%= a.getHora_fim() %>',
                                    '<%= a.getStatus() %>'
                                )"
                                data-bs-toggle="modal" data-bs-target="#modalEditar">
                                <i class="bi bi-pencil"></i>
                            </button>

                            <button class="btn btn-sm btn-danger"
                                onclick="excluirAgendamento(<%= a.getId_agendamento() %>)">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<%@ include file="modais-agendamentos.jsp" %>

<script>
    function editarAgendamento(id, id_cliente, id_sala, data, inicio, fim, status) {
        document.getElementById("edit_id_agendamento").value = id;
        document.getElementById("edit_id_cliente").value = id_cliente;
        document.getElementById("edit_id_sala").value = id_sala;
        document.getElementById("edit_data_agendamento").value = data;
        document.getElementById("edit_hora_inicio").value = inicio;
        document.getElementById("edit_hora_fim").value = fim;
        document.getElementById("edit_status").value = status;
    }

    function excluirAgendamento(id) {
        if (confirm("Deseja realmente excluir este agendamento?")) {
            window.location.href = "<%= request.getContextPath() %>/AgendamentoServlet?acao=excluir&id_agendamento=" + id;
        }
    }
</script>

</body>
</html>
