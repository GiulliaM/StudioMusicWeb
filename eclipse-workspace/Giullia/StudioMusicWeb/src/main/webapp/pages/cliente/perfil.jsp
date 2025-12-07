<%@ include file="components/header.jsp" %>
<header><title>Meu Perfil | StudioMusic</title></header>

<style>
    
    :root {
        --roxo-principal: #4B0082; /* Indigo Profundo */
        --roxo-secundario: #8A2BE2; /* Violeta */
        --fundo-claro: #F8F8F8;
        --texto-escuro: #333333;
    }

    body {
        background-color: var(--fundo-claro); 
        color: var(--texto-escuro);
    }

    .conteudo {
        max-width: 700px; 
        margin: 0 auto;
        padding: 30px;
    }

    .card-perfil {
        background: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        border: 1px solid #eee;
    }
    
    .card-perfil h3 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        color: var(--roxo-principal);
        border-bottom: 3px solid var(--roxo-secundario);
        padding-bottom: 5px;
        display: inline-block;
        margin-bottom: 30px !important;
        font-size: 2rem;
    }
    
    .info-line {
        font-size: 1.1rem;
        margin-bottom: 15px;
        border-bottom: 1px dashed #eee;
        padding-bottom: 10px;
    }

    .info-line b {
        color: black; 
        font-weight: 700;
        margin-right: 10px;
        min-width: 120px; 
        display: inline-block;
    }

    .info-valor {
        color: var(--texto-escuro);
        font-weight: 500;
    }

    .btn-editar-perfil {
        background: var(--roxo-principal);
        color: white;
        padding: 10px 25px;
        border-radius: 8px;
        font-weight: 700;
        transition: all 0.3s ease;
        border: 2px solid var(--roxo-principal);
        text-decoration: none;
        display: inline-flex;
        align-items: center;
    }
    .btn-editar-perfil:hover {
        background: var(--roxo-secundario);
        border-color: var(--roxo-secundario);
        transform: translateY(-2px);
    }
</style>

<div class="conteudo">

    <div class="card-perfil shadow-sm">
        <h3>Meu Perfil</h3>

        <div class="info-line">
            <b>Nome:</b> <span class="info-valor"><%= cliente.getNome() %></span>
        </div>
        
        <div class="info-line">
            <b>E-mail:</b> <span class="info-valor"><%= cliente.getEmail() %></span>
        </div>
        
        <div class="info-line">
            <b>CPF/CNPJ:</b> <span class="info-valor"><%= cliente.getCpf_cnpj() %></span>
        </div>
        
        <div class="info-line">
            <b>Telefone:</b> <span class="info-valor"><%= cliente.getTelefone() %></span>
        </div>

        <div class="info-line">
            <b>Senha:</b> <span class="info-valor">********</span>
        </div>

        <a href="editar-perfil.jsp" class="btn-editar-perfil mt-4">
            <i class="bi bi-pencil-fill me-2"></i> Editar Perfil
        </a>
    </div>

</div>