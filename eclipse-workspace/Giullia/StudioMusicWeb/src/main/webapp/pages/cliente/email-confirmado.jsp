<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>E-mail Confirmado</title>

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
        h2 { font-weight: bold; }
        .icon { font-size: 55px; color: green; margin-bottom: 15px; }
    </style>
</head>

<body>

<div class="card shadow-sm">
    <div class="icon">✔️</div>
    <h2>E-mail Confirmado!</h2>
    <p>Agora você já pode acessar sua conta no StudioMusic.</p>

    <a href="login-cliente.jsp" class="btn btn-dark mt-3">Ir para Login</a>
</div>

</body>
</html>
