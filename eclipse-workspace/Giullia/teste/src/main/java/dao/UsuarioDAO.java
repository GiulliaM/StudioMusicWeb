package dao;

import model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    // ========================= INSERIR USUÁRIO =========================
    public boolean inserirUsuario(Usuario usuario) {

        String sql = "INSERT INTO usuarios (username, password, tipo_usuario, id_cliente_fk, email, email_verificado, token_verificacao) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // username
            stmt.setString(1, usuario.getUsername());

            // senha HASH
            String hash = BCrypt.hashpw(usuario.getPassword(), BCrypt.gensalt());
            stmt.setString(2, hash);

            // tipo_usuario
            stmt.setString(3, usuario.getTipoUsuario());

            // id_cliente_fk (NULL ou valor)
            if (usuario.getIdClienteFk() != null) {
                stmt.setInt(4, usuario.getIdClienteFk());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }

            // email
            stmt.setString(5, usuario.getEmail());

            // email_verificado (false no cadastro)
            stmt.setBoolean(6, usuario.isEmailVerificado());

            // token_verificacao
            stmt.setString(7, usuario.getTokenVerificacao());

            int linhas = stmt.executeUpdate();

            // Gerar id automaticamente
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


    // ========================= AUTENTICAR (LOGIN) =========================
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

                // Se a senha bateu, retorno o usuário
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


    // ========================= BUSCAR POR USERNAME =========================
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


    // ========================= BUSCAR POR TOKEN =========================
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
