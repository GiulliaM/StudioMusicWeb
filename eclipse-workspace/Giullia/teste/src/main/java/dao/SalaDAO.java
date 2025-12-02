package dao;

import model.Sala;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalaDAO {

    public List<Sala> listarSalas() {
        List<Sala> lista = new ArrayList<>();

        String sql = "SELECT * FROM salas";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {

                Sala sala = new Sala(
                    rs.getInt("id_sala"),
                    rs.getString("nome_tipo"),
                    rs.getInt("numero_sala"),
                    rs.getInt("capacidade"),
                    rs.getString("equipamentos"),
                    rs.getDouble("valor_hora")
                );

                lista.add(sala);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar salas: " + e.getMessage());
        }

        return lista;
    }

    public boolean cadastrarSala(Sala sala) {

        String sql = "INSERT INTO salas (nome_tipo, numero_sala, capacidade, equipamentos, valor_hora) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, sala.getNome_tipo());
            stmt.setInt(2, sala.getNumero_sala());
            stmt.setInt(3, sala.getCapacidade());
            stmt.setString(4, sala.getEquipamentos());
            stmt.setDouble(5, sala.getValor_hora());

            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Erro ao cadastrar sala: " + e.getMessage());
        }

        return false;
    }

    public boolean editarSala(Sala sala) {

        String sql = "UPDATE salas SET nome_tipo = ?, numero_sala = ?, capacidade = ?, equipamentos = ?, valor_hora = ? "
                   + "WHERE id_sala = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, sala.getNome_tipo());
            stmt.setInt(2, sala.getNumero_sala());
            stmt.setInt(3, sala.getCapacidade());
            stmt.setString(4, sala.getEquipamentos());
            stmt.setDouble(5, sala.getValor_hora());
            stmt.setInt(6, sala.getId_sala());

            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Erro ao editar sala: " + e.getMessage());
        }

        return false;
    }

    public boolean excluirSala(int id_sala) {

        String sql = "DELETE FROM salas WHERE id_sala = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id_sala);
            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Erro ao excluir sala: " + e.getMessage());
        }

        return false;
    }
    
    public Sala buscarSalaPorId(int idSala) {
        String sql = "SELECT * FROM salas WHERE id_sala = ?";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idSala);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Sala s = new Sala();
                    s.setId_sala(rs.getInt("id_sala"));
                    s.setNome_tipo(rs.getString("nome_tipo"));
                    s.setNumero_sala(rs.getInt("numero_sala"));
                    s.setCapacidade(rs.getInt("capacidade"));
                    s.setEquipamentos(rs.getString("equipamentos"));
                    s.setValor_hora(rs.getDouble("valor_hora"));
                    return s;
                }
            }
        } catch (SQLException e) {
            System.out.println("Erro ao buscar sala por id: " + e.getMessage());
        }
        return null;
    }


}
