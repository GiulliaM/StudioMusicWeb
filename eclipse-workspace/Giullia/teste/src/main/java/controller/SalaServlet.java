package controller;

import dao.SalaDAO;
import model.Sala;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/SalaServlet")
public class SalaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String acao = request.getParameter("acao");

        SalaDAO dao = new SalaDAO();

        if ("cadastrar".equals(acao)) {

            Sala sala = new Sala(
                    0,
                    request.getParameter("nome_tipo"),
                    Integer.parseInt(request.getParameter("numero_sala")),
                    Integer.parseInt(request.getParameter("capacidade")),
                    request.getParameter("equipamentos"),
                    Double.parseDouble(request.getParameter("valor_hora"))
            );

            dao.cadastrarSala(sala);
            response.sendRedirect("pages/admin/salas.jsp");
            return;
        }

        if ("editar".equals(acao)) {

            Sala sala = new Sala(
                    Integer.parseInt(request.getParameter("id_sala")),
                    request.getParameter("nome_tipo"),
                    Integer.parseInt(request.getParameter("numero_sala")),
                    Integer.parseInt(request.getParameter("capacidade")),
                    request.getParameter("equipamentos"),
                    Double.parseDouble(request.getParameter("valor_hora"))
            );

            dao.editarSala(sala);
            response.sendRedirect("pages/admin/salas.jsp");
            return;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        SalaDAO dao = new SalaDAO();

        if ("excluir".equals(acao)) {
            int idSala = Integer.parseInt(request.getParameter("id_sala"));
            dao.excluirSala(idSala);
            response.sendRedirect("pages/admin/salas.jsp");
            return;
        }

        response.sendRedirect("pages/admin/salas.jsp");
    }
}
