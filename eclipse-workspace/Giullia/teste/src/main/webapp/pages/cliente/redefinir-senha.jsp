<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Redefinir Senha</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            width: 380px;
            padding: 30px;
            border-radius: 12px;
        }
    </style>
</head>

<body>

<div class="card shadow">
    <h4 class="text-center mb-3">Redefinir Senha</h4>

    <form action="redefinir" method="post">

        <input type="hidden" name="token" value="${param.token}">

        <div class="mb-3">
            <label class="form-label">Nova senha</label>
            <input type="password" name="senha" class="form-control" required>
        </div>

        <button class="btn btn-success w-100">Salvar nova senha</button>

        <p class="text-success mt-2">${msg}</p>
        <p class="text-danger mt-2">${erro}</p>

    </form>

    <div class="mt-3 text-center">
        <a href="login-cliente.jsp">Voltar ao login</a>
    </div>
</div>

</body>
</html>
