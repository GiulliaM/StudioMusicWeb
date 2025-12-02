<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Usuários</title>

    <style>
        body { font-family: Arial; background: #f3f3f3; margin:0; }
        .container { padding: 20px; }
        .card {
            background: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 6px;
        }
        a { color: #1976D2; font-weight: bold; }
    </style>
</head>

<body>

<%@ include file="includes/header.jsp" %>
<%@ include file="includes/menu.jsp" %>

<div class="container">
    
    <div class="card">
        <h2>Gerenciar Usuários</h2>
        <p>Aqui você poderá listar, editar e excluir usuários (admins e comuns).</p>
    </div>

    <div class="card">
        <h3>📌 Em breve</h3>
        <p>Listagem de usuários cadastrados.</p>
    </div>

</div>

</body>
</html>
