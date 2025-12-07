package dao;

import java.sql.*;
import java.util.*;

public class DashboardDAO {

    public int totalSalas() {
        String sql = "SELECT COUNT(*) FROM salas";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Erro totalSalas: " + e.getMessage());
        }
        return 0;
    }

    public int totalClientes() {
        String sql = "SELECT COUNT(*) FROM clientes WHERE ativo = 1";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Erro totalClientes: " + e.getMessage());
        }
        return 0;
    }

    public int agendamentosHoje() {
        String sql = "SELECT COUNT(*) FROM agendamentos WHERE data_agendamento = CURDATE()";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Erro agendamentosHoje: " + e.getMessage());
        }
        return 0;
    }

    public List<Map<String, Object>> ultimosAgendamentos() {
        List<Map<String, Object>> lista = new ArrayList<>();

        String sql = """
                SELECT a.id_agendamento, c.nome AS cliente, s.nome_tipo AS sala,
                       a.data_agendamento, a.hora_inicio
                FROM agendamentos a
                LEFT JOIN clientes c ON a.id_cliente = c.id_cliente
                LEFT JOIN salas s ON a.id_sala = s.id_sala
                ORDER BY a.data_agendamento DESC, a.hora_inicio DESC
                LIMIT 5
                """;

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", rs.getInt("id_agendamento"));
                m.put("cliente", rs.getString("cliente"));
                m.put("sala", rs.getString("sala"));
                m.put("data", rs.getDate("data_agendamento"));
                m.put("hora", rs.getTime("hora_inicio"));
                lista.add(m);
            }

        } catch (SQLException e) {
            System.out.println("Erro ultimosAgendamentos: " + e.getMessage());
        }
        return lista;
    }


    public int[] agendamentosPorMes() {
        int[] meses = new int[12];
        String sql = """
                SELECT MONTH(data_agendamento) AS mes, COUNT(*) AS total
                FROM agendamentos
                GROUP BY MONTH(data_agendamento)
                """;

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int mes = rs.getInt("mes");
                meses[mes - 1] = rs.getInt("total");
            }

        } catch (SQLException e) {
            System.out.println("Erro agendamentosPorMes: " + e.getMessage());
        }
        return meses;
    }
}
