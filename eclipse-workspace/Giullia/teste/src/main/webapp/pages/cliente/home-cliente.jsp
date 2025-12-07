<%@ include file="components/header.jsp" %>

<header><title>Home | StudioMusic</title></header>

<style>
    :root {
        --roxo-principal: #4B0082; 
        --roxo-secundario: #8A2BE2; 
        --fundo-claro: #F8F8F8;
        --texto-escuro: #333333;
    }

    body {
        font-family: 'Inter', sans-serif;
        background-color: var(--fundo-claro); 
        color: var(--texto-escuro);
        min-height: 100vh;
        padding-top: 50px; 
    }
    
    .conteudo {
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
    }

    .card-home {
        background: white !important;
        padding: 40px !important; 
        border-radius: 12px !important;
        border: 1px solid #eee !important;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05) !important;
    }

    .card-home h4 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--roxo-principal); 
        border-bottom: 3px solid var(--roxo-secundario);
        padding-bottom: 5px;
        display: inline-block;
        margin-bottom: 20px !important;
    }
    
    .card-home p {
        font-size: 1.1rem;
        color: var(--texto-escuro);
        opacity: 0.9;
    }
    
    .btn-main-action {
        background: var(--roxo-principal); 
        color: white;
        padding: 10px 20px;
        border-radius: 8px; 
        font-weight: 600;
        transition: all 0.3s ease;
        border: 2px solid var(--roxo-principal);
        text-decoration: none;
    }
    .btn-main-action:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        transform: translateY(-2px);
    }
    
    .btn-outline-secondary-action {
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        color: var(--roxo-principal);
        border: 2px solid var(--roxo-principal);
        text-decoration: none;
        transition: all 0.3s ease;
    }
    .btn-outline-secondary-action:hover {
        background-color: var(--roxo-principal);
        color: white;
    }
</style>

<div class="conteudo">

    <div class="card-home shadow-sm">
        <h4>Bem-vindo(a), <%= cliente.getNome() %>!</h4> 
        
        <p class="mt-2">
            Aqui você pode visualizar salas, realizar agendamentos,
            consultar horários e gerenciar suas informações pessoais.
        </p>

        <div class="mt-4 pt-3 border-top">
            <a href="salas-cliente.jsp" class="btn-main-action">
                <i class="bi bi-mic-fill me-1"></i> Ver Salas
            </a>
            <a href="agendamentos-cliente.jsp" class="btn-outline-secondary-action ms-3">
                <i class="bi bi-calendar-check me-1"></i> Meus Agendamentos
            </a>
            <a href="perfil.jsp" class="btn-outline-secondary-action ms-3">
                <i class="bi bi-person-fill me-1"></i> Meu Perfil
            </a>
        </div>
    </div>

</div>