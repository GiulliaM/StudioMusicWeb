<%@ include file="components/header.jsp" %>
<header><title>Perfil</title></header>

<div class="conteudo">

    <div class="card shadow-sm p-4">
        <h3>Meu Perfil</h3>

        <p><b>Nome:</b> <%= cliente.getNome() %></p>
        <p><b>E-mail:</b> <%= cliente.getEmail() %></p>
        <p><b>CPF/CNPJ:</b> <%= cliente.getCpf_cnpj() %></p>
        <p><b>Telefone:</b> <%= cliente.getTelefone() %></p>

        <p><b>Senha:</b> ********</p>

        <a href="editar-perfil.jsp" class="btn btn-dark mt-3">Editar Perfil</a>
    </div>

</div>
