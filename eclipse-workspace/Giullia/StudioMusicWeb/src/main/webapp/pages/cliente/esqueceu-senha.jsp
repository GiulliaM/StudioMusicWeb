<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Senha - StudioMusic</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Montserrat:wght@700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --roxo-principal: #4B0082; 
            --roxo-secundario: #8A2BE2; 
            --fundo-claro: #F8F8F8;
            --texto-escuro: #333333;
        }

        body {
            background: linear-gradient(135deg, var(--fundo-claro) 90%, rgba(75, 0, 130, 0.1));
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            color: var(--texto-escuro);
        }

        .recovery-card {
            width: 400px;
            padding: 40px;
            border-radius: 15px;
            background: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .recovery-card h4 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            color: var(--roxo-principal);
            margin-top: 15px;
            margin-bottom: 30px !important;
        }

        .logo-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .logo-container img {
            max-width: 150px;
            height: auto;
        }

        .form-control:focus {
            border-color: var(--roxo-secundario);
            box-shadow: 0 0 0 0.25rem rgba(138, 43, 226, 0.25);
        }

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

        .recovery-card a {
            color: var(--roxo-principal);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        .recovery-card a:hover {
            color: var(--roxo-secundario);
            text-decoration: underline;
        }

        .text-success {
            font-weight: 600;
            color: #28a745 !important;
        }
        .text-danger {
            font-weight: 600;
            color: #d9534f !important;
        }
    </style>
</head>

<body>

<div class="recovery-card shadow">
    
    <div class="logo-container">
        <img src="../../assets/logo.png" alt="StudioMusic Logo"> 
    </div>

    <h4 class="text-center">Recuperar Senha</h4>

    <form action="esqueceu-senha" method="post">
        
        <p class="text-center mb-4">
            Digite seu e-mail abaixo para receber as instruções de redefinição de senha.
        </p>

        <div class="mb-3">
            <label class="form-label visually-hidden">E-mail</label>
            <input type="email" name="email" class="form-control form-control-lg" placeholder="Seu e-mail cadastrado" required>
        </div>

        <button class="btn btn-primary w-100 mb-3">
            <i class="bi bi-send-fill me-2"></i> Enviar instruções
        </button>

        <p class="text-success mt-2 text-center">${msg}</p>
        <p class="text-danger mt-2 text-center">${erro}</p>

        <div class="mt-3 text-center border-top pt-3">
            <a href="login-cliente.jsp">
                <i class="bi bi-arrow-left me-2"></i> Voltar ao login
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>