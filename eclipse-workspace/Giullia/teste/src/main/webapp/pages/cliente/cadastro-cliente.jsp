<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Cliente - StudioMusic</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* Cores da Landing Page */
        :root {
            --roxo-principal: #4B0082; /* Indigo Profundo */
            --roxo-secundario: #8A2BE2; /* Violeta */
            --fundo-claro: #F8F8F8;
            --texto-escuro: #333333;
        }

        body {
            /* Fundo claro com gradiente sutil */
            background: linear-gradient(135deg, var(--fundo-claro) 90%, rgba(75, 0, 130, 0.1));
            display: flex;
            justify-content: center;
            align-items: center;
            /* Usamos min-height para garantir que a página toda seja visível se o formulário for longo */
            min-height: 100vh; 
            font-family: 'Inter', sans-serif;
            color: var(--texto-escuro);
            padding: 20px 0; /* Padding para o conteúdo não tocar nas bordas */
        }

        .register-card {
            width: 480px; /* Pouco mais largo para acomodar o formulário completo */
            padding: 40px;
            border-radius: 15px;
            background: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .register-card h3 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            color: var(--roxo-principal);
            margin-top: 15px;
            margin-bottom: 30px !important;
        }

        /* Logo */
        .logo-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .logo-container img {
            max-width: 150px; 
            height: auto;
        }

        /* Estilização dos inputs */
        .form-control:focus {
            border-color: var(--roxo-secundario);
            box-shadow: 0 0 0 0.25rem rgba(138, 43, 226, 0.25);
        }

        /* Botão principal (Substituindo btn-success pelo tema roxo) */
        .btn-primary {
            background: var(--roxo-principal);
            border-color: var(--roxo-principal);
            padding: 12px;
            font-weight: 700;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background: var(--roxo-secundario);
            border-color: var(--roxo-secundario);
        }

        /* Links */
        .register-card a {
            color: var(--roxo-principal);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        .register-card a:hover {
            color: var(--roxo-secundario);
            text-decoration: underline;
        }

        /* Mensagem de erro */
        .text-danger {
            font-weight: 600;
            color: #d9534f !important; /* Cor de erro padrão */
        }
    </style>
</head>

<body>

<div class="register-card shadow">
    
    <div class="logo-container">
        <img src="../../assets/logo.png" alt="StudioMusic Logo"> 
    </div>

    <h3 class="text-center">Crie sua Conta StudioMusic</h3>

    <form action="<%=request.getContextPath()%>/cliente/cadastrar" method="post">

        <div class="mb-3">
            <label class="form-label">Nome completo</label>
            <input type="text" name="nome" class="form-control" placeholder="Nome completo" required>
        </div>

        <div class="mb-3">
            <label class="form-label">CPF/CNPJ</label>
            <input type="text" name="cpf" class="form-control" placeholder="Apenas números" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Telefone</label>
            <input type="text" name="telefone" class="form-control" placeholder="(00) 00000-0000" required>
        </div>

        <div class="mb-3">
            <label class="form-label">E-mail</label>
            <input type="email" name="email" class="form-control" placeholder="E-mail" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Senha</label>
            <input type="password" name="senha" class="form-control" placeholder="Senha" required>
        </div>

        <button class="btn btn-primary w-100 mt-2">
            <i class="bi bi-person-fill-add me-2"></i> Cadastrar
        </button>

        <p class="text-danger mt-3 text-center">${erro}</p>

        <div class="mt-3 text-center border-top pt-3">
            <a href="login-cliente.jsp">Já possui conta? Entrar</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>