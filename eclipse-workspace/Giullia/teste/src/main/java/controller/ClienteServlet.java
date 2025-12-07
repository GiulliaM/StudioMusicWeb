package controller;

import dao.ClienteDAO;
import model.Cliente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ClienteServlet")
public class ClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");
        ClienteDAO dao = new ClienteDAO();

        if ("cadastrar".equals(acao)) {

            Cliente c = new Cliente();
            c.setNome(request.getParameter("nome"));
            c.setCpf_cnpj(request.getParameter("cpf_cnpj"));
            c.setTelefone(request.getParameter("telefone"));
            c.setEmail(request.getParameter("email"));
            c.setAtivo(true); // admin cadastra cliente já ativo
            // senha/token não usados pelo admin

            dao.cadastrarCliente(c);

            response.sendRedirect("pages/admin/clientes.jsp");
            return;
        }

        if ("editar".equals(acao)) {

            Cliente c = new Cliente();
            c.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));
            c.setNome(request.getParameter("nome"));
            c.setCpf_cnpj(request.getParameter("cpf_cnpj"));
            c.setTelefone(request.getParameter("telefone"));
            c.setEmail(request.getParameter("email"));
            c.setAtivo(Boolean.parseBoolean(request.getParameter("ativo")));

            dao.editarCliente(c);

            response.sendRedirect("pages/admin/clientes.jsp");
            return;
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        ClienteDAO dao = new ClienteDAO();

        if ("excluir".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id_cliente"));
            dao.excluirCliente(id);
        }

        response.sendRedirect("pages/admin/clientes.jsp");
    }
}
