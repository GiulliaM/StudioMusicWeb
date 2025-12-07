<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Sala" %>
<%@ page import="dao.SalaDAO" %>

<%
    // Sessão já é verificada no header.jsp
    SalaDAO dao = new SalaDAO();
    List<Sala> salas = dao.listarSalas();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Salas - Admin</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Ícones -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

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

<!-- Menu lateral -->
<%@ include file="includes/menu.jsp" %>

<div class="conteudo-admin">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Gerenciar Salas</h2>

        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCadastrar">
            <i class="bi bi-plus-circle"></i> Nova Sala
        </button>
    </div>

    <!-- TABELA -->
    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-striped table-hover align-middle">
                <thead class="table-primary">
                    <tr>
                        <th>ID</th>
                        <th>Tipo</th>
                        <th>Número</th>
                        <th>Capacidade</th>
                        <th>Equipamentos</th>
                        <th>Valor/Hora</th>
                        <th style="width: 140px;">Ações</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    for (Sala s : salas) {
                %>
                    <tr>
                        <td><%= s.getId_sala() %></td>
                        <td><%= s.getNome_tipo() %></td>
                        <td><%= s.getNumero_sala() %></td>
                        <td><%= s.getCapacidade() %> pessoas</td>
                        <td><%= s.getEquipamentos() %></td>
                        <td>R$ <%= s.getValor_hora() %></td>

                        <td>
                           <button class="btn btn-sm btn-warning"
						    onclick="editarSala(
						        '<%= s.getId_sala() %>',
						        '<%= s.getNome_tipo() %>',
						        '<%= s.getNumero_sala() %>',
						        '<%= s.getCapacidade() %>',
						        '<%= s.getEquipamentos() %>',
						        '<%= s.getValor_hora() %>'
						    )"
						    data-bs-toggle="modal" data-bs-target="#modalEditar">
						    <i class="bi bi-pencil"></i>
						</button>


                            <button class="btn btn-sm btn-danger"
                                    onclick="excluirSala(<%= s.getId_sala() %>)">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>

        </div>
    </div>

</div>

<%@ include file="modais-salas.jsp" %>

<script>
	function editarSala(id, nome, numero, capacidade, equipamentos, valor) {
	
	    document.getElementById("edit_idSala").value = id;
	    document.getElementById("edit_nomeTipo").value = nome;
	    document.getElementById("edit_numeroSala").value = numero;
	    document.getElementById("edit_capacidade").value = capacidade;
	    document.getElementById("edit_equipamentos").value = equipamentos;
	    document.getElementById("edit_valorHora").value = valor;
	
	    console.log("Dados carregados no modal:", id, nome, numero, capacidade, equipamentos, valor);
	}

    function excluirSala(id) {
        if (confirm("Deseja realmente excluir esta sala?")) {
            window.location.href = "../../SalaServlet?acao=excluir&id_sala=" + id;
        }
    }
</script>

</body>
</html>
