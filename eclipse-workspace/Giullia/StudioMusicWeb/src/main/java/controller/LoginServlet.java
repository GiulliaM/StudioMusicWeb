package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dao.UsuarioDAO;
import model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // Ler JSON vindo do fetch()
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String linha;
        while ((linha = reader.readLine()) != null) {
            sb.append(linha);
        }

        JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
        String username = json.get("username").getAsString();
        String senha = json.get("password").getAsString();

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.autenticar(username, senha);

        JsonObject resposta = new JsonObject();

        if (usuario == null) {
            resposta.addProperty("status", "error");
            resposta.addProperty("message", "Usuário ou senha incorretos.");
            response.getWriter().write(resposta.toString());
            return;
        }

        resposta.addProperty("status", "success");
        resposta.addProperty("tipo", usuario.getTipoUsuario()); // admin ou cliente

        HttpSession sessao = request.getSession();
        sessao.setAttribute("username", usuario.getUsername());
        sessao.setAttribute("usuarioLogado", usuario);
        sessao.setAttribute("tipo", usuario.getTipoUsuario());

        response.getWriter().write(resposta.toString());
    }
}
