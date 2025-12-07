<style>
    .menu-lateral {
        width: 230px;
        height: 100vh;
        position: fixed;
        top: 70px; 
        left: 0;
        background: white;
        border-right: 1px solid #ddd;
        padding: 20px 15px;
        overflow-y: auto;
    }

    .menu-lateral a {
        display: block;
        text-decoration: none;
        padding: 10px 12px;
        margin-bottom: 8px;
        border-radius: 6px;
        color: #333;
        font-weight: 500;
        transition: .2s;
    }

    .menu-lateral a:hover {
        background: #1976D2;
        color: white;
    }

    .conteudo-admin {
        margin-left: 250px; 
        padding: 25px;
    }

    /* Mobile */
    @media (max-width: 800px) {
        .menu-lateral {
            display: none;
        }
        .conteudo-admin {
            margin-left: 0;
        }
    }
</style>

<div class="menu-lateral shadow-sm">

    <a href="dashboard.jsp">Dashboard</a>

    <a href="salas.jsp">Salas</a>

    <a href="clientes.jsp">Clientes</a>

    <a href="agendamentos.jsp">Agendamentos</a>

</div>
