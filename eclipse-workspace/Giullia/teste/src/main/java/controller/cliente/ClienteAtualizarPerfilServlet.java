package controller.cliente;

import dao.ClienteDAO;
import model.Cliente;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cliente/atualizar-perfil")
public class ClienteAtualizarPerfilServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id_cliente"));
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        String novaSenha = request.getParameter("senha");

        ClienteDAO dao = new ClienteDAO();
        Cliente cliente = dao.buscarPorId(id);

        if (cliente == null) {
            request.setAttribute("erro", "Cliente não encontrado!");
            request.getRequestDispatcher("/pages/cliente/perfil.jsp").forward(request, response);
            return;
        }

        cliente.setNome(nome);
        cliente.setEmail(email);
        cliente.setCpf_cnpj(cpf);
        cliente.setTelefone(telefone);

        // Se o campo senha NÃO estiver vazio, atualizar
        if (novaSenha != null && !novaSenha.trim().isEmpty()) {
            String hash = BCrypt.hashpw(novaSenha, BCrypt.gensalt());
            cliente.setSenha(hash);
        }

        boolean ok = dao.atualizarPerfil(cliente);

        if (ok) {
            HttpSession sessao = request.getSession();
            sessao.setAttribute("clienteLogado", cliente);

            request.setAttribute("msg", "Perfil atualizado com sucesso!");
        } else {
            request.setAttribute("erro", "Erro ao atualizar perfil!");
        }

        request.getRequestDispatcher("/pages/cliente/perfil.jsp").forward(request, response);
    }
}
