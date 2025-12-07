package controller.cliente;

import dao.ClienteDAO;
import model.Cliente;
import util.EmailService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/cliente/cadastrar")
public class ClienteCadastroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        String senha = request.getParameter("senha");

        String token = UUID.randomUUID().toString();

        Cliente cliente = new Cliente();
        cliente.setNome(nome);
        cliente.setEmail(email);
        cliente.setCpf_cnpj(cpf);
        cliente.setTelefone(telefone);
        cliente.setSenha(senha); 
        cliente.setToken_verificacao(token);
        cliente.setAtivo(false);

        ClienteDAO dao = new ClienteDAO();
        int id = dao.cadastrarClienteComToken(cliente);

        if (id > 0) {
        	new EmailService().enviarEmailVerificacaoCliente(email, token);
            response.sendRedirect(request.getContextPath() + "/pages/cliente/verifique-email.jsp");
        } else {
            request.setAttribute("erro", "Erro ao cadastrar cliente");
            request.getRequestDispatcher("/pages/cliente/cadastro-cliente.jsp").forward(request, response);
        }

    }
}
