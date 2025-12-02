package dao;

import model.Agendamento;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AgendamentoDAO {

    // Lista todos os agendamentos com JOIN para mostrar nomes de cliente e sala
    public List<Agendamento> listarAgendamentos() {
        List<Agendamento> lista = new ArrayList<>();
        String sql = "SELECT a.*, c.nome AS nome_cliente, s.nome_tipo AS nome_sala, s.valor_hora " +
                     "FROM agendamentos a " +
                     "LEFT JOIN clientes c ON a.id_cliente = c.id_cliente " +
                     "LEFT JOIN salas s ON a.id_sala = s.id_sala " +
                     "ORDER BY a.data_agendamento DESC, a.hora_inicio";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Agendamento a = new Agendamento();
                a.setId_agendamento(rs.getInt("id_agendamento"));
                a.setId_cliente(rs.getInt("id_cliente"));
                a.setId_sala(rs.getInt("id_sala"));
                a.setData_agendamento(rs.getDate("data_agendamento"));
                a.setHora_inicio(rs.getTime("hora_inicio"));
                a.setHora_fim(rs.getTime("hora_fim"));
                a.setStatus(rs.getString("status"));
                a.setValor_total(rs.getDouble("valor_total"));

                a.setNome_cliente(rs.getString("nome_cliente"));
                a.setNome_sala(rs.getString("nome_sala"));

                lista.add(a);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar agendamentos: " + e.getMessage());
        }

        return lista;
    }

    public boolean cadastrarAgendamento(Agendamento a) {
        String sql = "INSERT INTO agendamentos (id_cliente, id_sala, data_agendamento, hora_inicio, hora_fim, status, valor_total) " +
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
        String sql = "UPDATE agendamentos SET id_cliente=?, id_sala=?, data_agendamento=?, hora_inicio=?, hora_fim=?, status=?, valor_total=? " +
                     "WHERE id_agendamento=?";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, a.getId_cliente());
            stmt.setInt(2, a.getId_sala());
            stmt.setDate(3, a.getData_agendamento());
            stmt.setTime(4, a.getHora_inicio());
            stmt.setTime(5, a.getHora_fim());
            stmt.setString(6, a.getStatus());
            stmt.setDouble(7, a.getValor_total());
            stmt.setInt(8, a.getId_agendamento());

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

    // buscar por id (útil se quiser carregar via servlet)
    public Agendamento buscarPorId(int id) {
        String sql = "SELECT a.*, c.nome AS nome_cliente, s.nome_tipo AS nome_sala FROM agendamentos a " +
                     "LEFT JOIN clientes c ON a.id_cliente = c.id_cliente " +
                     "LEFT JOIN salas s ON a.id_sala = s.id_sala WHERE id_agendamento = ?";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Agendamento a = new Agendamento();
                    a.setId_agendamento(rs.getInt("id_agendamento"));
                    a.setId_cliente(rs.getInt("id_cliente"));
                    a.setId_sala(rs.getInt("id_sala"));
                    a.setData_agendamento(rs.getDate("data_agendamento"));
                    a.setHora_inicio(rs.getTime("hora_inicio"));
                    a.setHora_fim(rs.getTime("hora_fim"));
                    a.setStatus(rs.getString("status"));
                    a.setValor_total(rs.getDouble("valor_total"));
                    a.setNome_cliente(rs.getString("nome_cliente"));
                    a.setNome_sala(rs.getString("nome_sala"));
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

        String sql = "SELECT a.*, s.nome_tipo AS nome_sala " +
                     "FROM agendamentos a " +
                     "INNER JOIN salas s ON a.id_sala = s.id_sala " +
                     "WHERE a.id_cliente = ? " +
                     "ORDER BY a.data_agendamento DESC, a.hora_inicio";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idCliente);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Agendamento a = new Agendamento();
                    a.setId_agendamento(rs.getInt("id_agendamento"));
                    a.setId_cliente(rs.getInt("id_cliente"));
                    a.setId_sala(rs.getInt("id_sala"));
                    a.setData_agendamento(rs.getDate("data_agendamento"));
                    a.setHora_inicio(rs.getTime("hora_inicio"));
                    a.setHora_fim(rs.getTime("hora_fim"));
                    a.setStatus(rs.getString("status"));
                    a.setValor_total(rs.getDouble("valor_total"));
                    a.setNome_sala(rs.getString("nome_sala"));

                    lista.add(a);
                }
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar agendamentos do cliente: " + e.getMessage());
        }

        return lista;
    }
    
    public boolean salaDisponivel(int idSala, Date data, Time inicio, Time fim) {

        String sql = "SELECT COUNT(*) FROM agendamentos " +
                     "WHERE id_sala = ? AND data_agendamento = ? " +
                     "AND (hora_inicio < ? AND hora_fim > ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idSala);
            stmt.setDate(2, data);
            stmt.setTime(3, fim);
            stmt.setTime(4, inicio);

            ResultSet rs = stmt.executeQuery();
            rs.next();

            int count = rs.getInt(1);

            return count == 0; // SE 0: está livre, senão ocupada

        } catch (SQLException e) {
            System.out.println("Erro ao verificar disponibilidade: " + e.getMessage());
        }

        return false;
    }
    
    public boolean salaDisponivelEditar(int idSala, Date data, Time inicio, Time fim, int idAgendamentoIgnorar) {

        String sql = "SELECT COUNT(*) FROM agendamentos " +
                     "WHERE id_sala = ? AND data_agendamento = ? " +
                     "AND id_agendamento != ? " + // ignorar o próprio agendamento
                     "AND ( " +
                     "   (hora_inicio <= ? AND hora_fim > ?) OR " +
                     "   (hora_inicio < ? AND hora_fim >= ?) OR " +
                     "   (hora_inicio >= ? AND hora_fim <= ?) " +
                     ")";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idSala);
            stmt.setDate(2, data);
            stmt.setInt(3, idAgendamentoIgnorar);

            stmt.setTime(4, inicio);
            stmt.setTime(5, inicio);

            stmt.setTime(6, fim);
            stmt.setTime(7, fim);

            stmt.setTime(8, inicio);
            stmt.setTime(9, fim);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) == 0;
            }

        } catch (Exception e) {
            System.out.println("Erro ao verificar disponibilidade edição: " + e.getMessage());
        }

        return false;
    }



}
