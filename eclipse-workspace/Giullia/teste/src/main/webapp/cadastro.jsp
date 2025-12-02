<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>StudioMusic - Cadastro de Cliente</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border-radius: 12px;
            width: 450px;
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
    <h5 class="text-center mb-4">Criar Conta - Cliente</h5>

    <!-- Nome -->
    <div class="mb-3">
        <label class="form-label">Nome Completo</label>
        <input type="text" id="nome" class="form-control" placeholder="Digite seu nome completo">
    </div>

    <!-- CPF ou CNPJ -->
    <div class="mb-3">
        <label class="form-label">CPF/CNPJ</label>
        <input type="text" id="cpf_cnpj" class="form-control" placeholder="Digite seu cpf ou cfnp">
    </div>

    <!-- Telefone -->
    <div class="mb-3">
        <label class="form-label">Telefone</label>
        <input type="text" id="telefone" class="form-control" placeholder="Digite seu telefone">
    </div>

    <!-- Email -->
    <div class="mb-3">
        <label class="form-label">E-mail</label>
        <input type="email" id="email" class="form-control" placeholder="Digite seu e-mail">
    </div>

    <!-- username -->
    <div class="mb-3">
        <label class="form-label">Nome de Usuário (login)</label>
        <input type="text" id="username" class="form-control" placeholder="Digite seu nome de usuário">
    </div>

    <!-- Senha -->
    <div class="mb-3">
        <label class="form-label">Senha</label>
        <input type="password" id="password" class="form-control" placeholder="Digite sua senha">
    </div>

    <button class="btn btn-success w-100" onclick="cadastrar()">Criar Conta</button>

    <p id="erro" class="text-danger mt-3 text-center"></p>
    <p id="sucesso" class="text-success mt-3 text-center"></p>

    <p class="mt-3 text-center">
        Já tem conta?
        <a href="login.jsp">Entrar</a>
    </p>

</div>


<script>
function cadastrar() {

    let json = {
        nome: document.getElementById("nome").value,
        cpf_cnpj: document.getElementById("cpf_cnpj").value,
        telefone: document.getElementById("telefone").value,
        email: document.getElementById("email").value,
        username: document.getElementById("username").value,
        password: document.getElementById("password").value,
        tipo: "cliente"
    };

    fetch("<%= request.getContextPath() %>/CadastroServlet", {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(json)
    })
    .then(r => r.json())
    .then(d => {

        if (d.status === "ok") {
            document.getElementById("sucesso").innerText = "Conta criada com sucesso!";
            document.getElementById("erro").innerText = "";
        } else {
            document.getElementById("erro").innerText = d.message;
            document.getElementById("sucesso").innerText = "";
        }
    });
}

</script>

</body>
</html>
