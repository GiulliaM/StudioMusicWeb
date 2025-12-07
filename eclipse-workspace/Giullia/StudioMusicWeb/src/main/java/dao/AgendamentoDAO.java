package dao;

import model.Agendamento;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AgendamentoDAO {



    private void atualizarStatusAutomatico(Agendamento a) {
        Timestamp agora = new Timestamp(System.currentTimeMillis());
        Timestamp fim = Timestamp.valueOf(a.getData_agendamento() + " " + a.getHora_fim());

        if (a.getStatus().equals("Pendente") && fim.before(agora)) {
            a.setStatus("Realizado");
            atualizarStatusNoBanco(a.getId_agendamento(), "Realizado");
        }
    }

    public void atualizarStatusNoBanco(int id, String novoStatus) {
        String sql = "UPDATE agendamentos SET status = ? WHERE id_agendamento = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, novoStatus);
            stmt.setInt(2, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar status: " + e.getMessage());
        }
    }

    /* ============================================================
                       LISTAR (ADMIN)
       ============================================================ */

    public List<Agendamento> listarAgendamentos() {
        List<Agendamento> lista = new ArrayList<>();
        String sql =
            "SELECT a.*, c.nome AS nome_cliente, s.nome_tipo AS nome_sala, s.valor_hora " +
            "FROM agendamentos a " +
            "LEFT JOIN clientes c ON a.id_cliente = c.id_cliente " +
            "LEFT JOIN salas s ON a.id_sala = s.id_sala " +
            "ORDER BY a.data_agendamento DESC, a.hora_inicio";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Agendamento a = preencherAgendamento(rs);
                atualizarStatusAutomatico(a);
                lista.add(a);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar agendamentos: " + e.getMessage());
        }

        return lista;
    }

    /* ============================================================
                       BUSCAR POR ID
       ============================================================ */

    public Agendamento buscarPorId(int id) {
        String sql =
            "SELECT a.*, s.valor_hora, s.nome_tipo AS nome_sala, c.nome AS nome_cliente " +
            "FROM agendamentos a " +
            "INNER JOIN salas s ON a.id_sala = s.id_sala " +
            "LEFT JOIN clientes c ON a.id_cliente = c.id_cliente " +
            "WHERE id_agendamento = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Agendamento a = preencherAgendamento(rs);
                    atualizarStatusAutomatico(a);
                    return a;
                }
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar agendamento: " + e.getMessage());
        }

        return null;
    }



    public List<Agendamento> listarPorCliente(int idCliente) {
        List<Agendamento> lista = new ArrayList<>();

        String sql =
            "SELECT a.*, s.nome_tipo AS nome_sala, s.valor_hora " +
            "FROM agendamentos a " +
            "INNER JOIN salas s ON a.id_sala = s.id_sala " +
            "WHERE a.id_cliente = ? " +
            "ORDER BY a.data_agendamento DESC, a.hora_inicio";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idCliente);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Agendamento a = preencherAgendamento(rs);
                    atualizarStatusAutomatico(a);
                    lista.add(a);
                }
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar agendamentos do cliente: " + e.getMessage());
        }

        return lista;
    }



    public boolean cadastrarAgendamento(Agendamento a) {
        String sql = "INSERT INTO agendamentos " +
                "(id_cliente, id_sala, data_agendamento, hora_inicio, hora_fim, status, valor_total) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, a.getId_cliente());
            stmt.setInt(2, a.getId_sala());
            stmt.setDate(3, a.getData_agendamento());
            stmt.setTime(4, a.getHora_inicio());
            stmt.setTime(5, a.getHora_fim());
            stmt.setString(6, a.getStatus());
            stmt.setDouble(7, a.getValor_total());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao cadastrar agendamento: " + e.getMessage());
        }

        return false;
    }



    public boolean editarAgendamento(Agendamento a) {

        // Recalcular valor total
        double valorHora = new SalaDAO().buscarValorHora(a.getId_sala());
        long diffMs = a.getHora_fim().getTime() - a.getHora_inicio().getTime();
        double horas = diffMs / (1000.0 * 60 * 60);
        a.setValor_total(horas * valorHora);

        String sql =
            "UPDATE agendamentos SET data_agendamento=?, hora_inicio=?, hora_fim=?, valor_total=? " +
            "WHERE id_agendamento=?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDate(1, a.getData_agendamento());
            stmt.setTime(2, a.getHora_inicio());
            stmt.setTime(3, a.getHora_fim());
            stmt.setDouble(4, a.getValor_total());
            stmt.setInt(5, a.getId_agendamento());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao editar agendamento: " + e.getMessage());
        }

        return false;
    }


    public boolean excluirAgendamento(int id) {
        String sql = "DELETE FROM agendamentos WHERE id_agendamento=?";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao excluir agendamento: " + e.getMessage());
        }
        return false;
    }


    public boolean salaDisponivel(int idSala, Date data, Time inicio, Time fim) {

        String sql =
            "SELECT COUNT(*) FROM agendamentos " +
            "WHERE id_sala = ? AND data_agendamento = ? " +
            "AND NOT (hora_fim <= ? OR hora_inicio >= ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idSala);
            stmt.setDate(2, data);
            stmt.setTime(3, inicio);
            stmt.setTime(4, fim);

            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1) == 0;

        } catch (SQLException e) {
            System.out.println("Erro ao verificar disponibilidade: " + e.getMessage());
        }
        return false;
    }

    public boolean salaDisponivelEditar(int idSala, Date data, Time inicio, Time fim, int ignorarId) {

        String sql =
            "SELECT COUNT(*) FROM agendamentos " +
            "WHERE id_sala = ? AND data_agendamento = ? AND id_agendamento != ? " +
            "AND NOT (hora_fim <= ? OR hora_inicio >= ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idSala);
            stmt.setDate(2, data);
            stmt.setInt(3, ignorarId);
            stmt.setTime(4, inicio);
            stmt.setTime(5, fim);

            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1) == 0;

        } catch (SQLException e) {
            System.out.println("Erro ao verificar disponibilidade (editar): " + e.getMessage());
        }
        return false;
    }



    private Agendamento preencherAgendamento(ResultSet rs) throws SQLException {
        Agendamento a = new Agendamento();

        a.setId_agendamento(rs.getInt("id_agendamento"));
        a.setId_cliente(rs.getInt("id_cliente"));
        a.setId_sala(rs.getInt("id_sala"));
        a.setData_agendamento(rs.getDate("data_agendamento"));
        a.setHora_inicio(rs.getTime("hora_inicio"));
        a.setHora_fim(rs.getTime("hora_fim"));
        a.setStatus(rs.getString("status"));
        a.setValor_total(rs.getDouble("valor_total"));

        // Campos do JOIN — protegidos contra ausência
        try { a.setNome_cliente(rs.getString("nome_cliente")); } catch (Exception ignore) {}
        try { a.setNome_sala(rs.getString("nome_sala")); } catch (Exception ignore) {}

        return a;
    }
}
