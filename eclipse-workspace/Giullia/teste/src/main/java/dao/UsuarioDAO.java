package dao;

import model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public boolean inserirUsuario(Usuario usuario) {

        String sql = "INSERT INTO usuarios (username, password, tipo_usuario, id_cliente_fk, email, email_verificado, token_verificacao) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, usuario.getUsername());

            String hash = BCrypt.hashpw(usuario.getPassword(), BCrypt.gensalt());
            stmt.setString(2, hash);

            stmt.setString(3, usuario.getTipoUsuario());

            if (usuario.getIdClienteFk() != null) {
                stmt.setInt(4, usuario.getIdClienteFk());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }

            stmt.setString(5, usuario.getEmail());

            stmt.setBoolean(6, usuario.isEmailVerificado());

            stmt.setString(7, usuario.getTokenVerificacao());

            int linhas = stmt.executeUpdate();

            if (linhas > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) usuario.setId(rs.getInt(1));
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Erro ao inserir usuário: " + e.getMessage());
        }
        return false;
    }


    public Usuario autenticar(String username, String senhaDigitada) {

        String sql = "SELECT * FROM usuarios WHERE username = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hash = rs.getString("password");

                // Verifica hash
                if (!BCrypt.checkpw(senhaDigitada, hash)) {
                    return null;
                }

                return new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("tipo_usuario"),
                        rs.getString("email"),
                        (Integer) rs.getObject("id_cliente_fk"),
                        rs.getBoolean("email_verificado"),
                        rs.getString("token_verificacao")
                );
            }

        } catch (Exception e) {
            System.out.println("Erro ao autenticar usuário: " + e.getMessage());
        }
        return null;
    }


    public Usuario buscarPorUsername(String username) {

        String sql = "SELECT * FROM usuarios WHERE username = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("tipo_usuario"),
                        rs.getString("email"),
                        (Integer) rs.getObject("id_cliente_fk"),
                        rs.getBoolean("email_verificado"),
                        rs.getString("token_verificacao")
                );
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar usuário por username: " + e.getMessage());
        }
        return null;
    }


    public Usuario buscarPorToken(String token) {

        String sql = "SELECT * FROM usuarios WHERE token_verificacao = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("tipo_usuario"),
                        rs.getString("email"),
                        (Integer) rs.getObject("id_cliente_fk"),
                        rs.getBoolean("email_verificado"),
                        rs.getString("token_verificacao")
                );
            }

        } catch (SQLException e) {
            System.err.println("Erro ao buscar usuário por token: " + e.getMessage());
        }
        return null;
    }
    
    public boolean ativarEmail(String token) {
        String sql = "UPDATE usuarios SET email_verificado = 1, token_verificacao = NULL WHERE token_verificacao = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, token);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao ativar email: " + e.getMessage());
            return false;
        }
    }


}
