<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Erro na Verificação</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { background: #f6f6f6; font-family: Arial; }
        .card {
            max-width: 450px;
            margin: 80px auto;
            padding: 35px;
            border-radius: 12px;
            border: 1px solid #e5e5e5;
            background: white;
            text-align: center;
        }
        .icon { font-size: 55px; color: red; margin-bottom: 15px; }
    </style>
</head>

<body>

<div class="card shadow-sm">
    <div class="icon">❌</div>
    <h2>Link inválido ou expirado</h2>
    <p>Solicite um novo cadastro.</p>

    <a href="cadastro.jsp" class="btn btn-dark mt-3">Voltar ao Cadastro</a>
</div>

</body>
</html>
