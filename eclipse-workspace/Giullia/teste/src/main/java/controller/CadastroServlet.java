package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dao.UsuarioDAO;
import model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/CadastroServlet")
public class CadastroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // Ler JSON do fetch()
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String linha;
        while ((linha = reader.readLine()) != null) {
            sb.append(linha);
        }

        JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();

        String username = json.get("username").getAsString();
        String senha = json.get("password").getAsString();
        String tipo = json.get("tipo_usuario").getAsString(); // admin, funcionario...

        JsonObject resposta = new JsonObject();

        Usuario usuario = new Usuario(
                username,
                senha,
                tipo,
                null,      // sem email
                null,      // sem id_cliente
                null       // sem token
        );

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean inserido = usuarioDAO.inserirUsuario(usuario);

        if (!inserido) {
            resposta.addProperty("status", "erro");
            resposta.addProperty("message", "Erro ao criar usuário admin.");
            response.getWriter().write(resposta.toString());
            return;
        }

        resposta.addProperty("status", "ok");
        resposta.addProperty("message", "Usuário admin criado com sucesso!");
        response.getWriter().write(resposta.toString());
    }
}
