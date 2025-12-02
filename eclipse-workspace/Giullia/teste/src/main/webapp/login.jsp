<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>StudioMusic - Login (Admin)</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f0f2f5;
        }
        .card {
            border-radius: 12px;
            width: 360px;
        }
        .logo {
            font-size: 32px;
            font-weight: bold;
            color: #1976D2;
        }
    </style>
</head>

<body>

<div class="card shadow p-4">

    <h3 class="text-center mb-3 logo">StudioMusic</h3>
    <h5 class="text-center mb-4">Login Admin</h5>

    <div class="mb-3">
        <label class="form-label">Usuário</label>
        <input type="text" id="username" class="form-control">
    </div>

    <div class="mb-3">
        <label class="form-label">Senha</label>
        <input type="password" id="password" class="form-control">
    </div>

    <button class="btn btn-primary w-100" onclick="fazerLogin()">Entrar</button>

    <p id="erro" class="text-danger mt-3 text-center"></p>

</div>

<script>
function fazerLogin() {

    const user = document.getElementById("username").value;
    const pass = document.getElementById("password").value;

    fetch("LoginServlet", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: user, password: pass })
    })
    .then(res => res.json())
    .then(data => {

        if (data.status === "error") {
            document.getElementById("erro").innerText = data.message;
            return;
        }

        if (data.tipo === "admin") {
            window.location.href = "pages/admin/dashboard.jsp";
        } else {
            document.getElementById("erro").innerText = "Acesso permitido somente para administradores.";
        }
    })
    .catch(err => console.log(err));
}
</script>

</body>
</html>
