package dao;

import model.Cliente;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    // LISTAR CLIENTES (ADMIN)
    public List<Cliente> listarClientes() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes ORDER BY nome";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNome(rs.getString("nome"));
                c.setCpf_cnpj(rs.getString("cpf_cnpj"));
                c.setTelefone(rs.getString("telefone"));
                c.setEmail(rs.getString("email"));
                c.setSenha(rs.getString("senha"));
                c.setAtivo(rs.getBoolean("ativo"));
                c.setToken_verificacao(rs.getString("token_verificacao"));
                c.setToken_redefinir(rs.getString("token_redefinir"));
                lista.add(c);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao listar clientes: " + e.getMessage());
        }
        return lista;
    }
    
 // CADASTRAR CLIENTE (ADMIN) 
    public boolean cadastrarCliente(Cliente cliente) {
        String sql = "INSERT INTO clientes (nome, cpf_cnpj, telefone, email, ativo) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getCpf_cnpj());
            stmt.setString(3, cliente.getTelefone());
            stmt.setString(4, cliente.getEmail());
            stmt.setBoolean(5, cliente.isAtivo());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao cadastrar cliente (admin): " + e.getMessage());
        }
        return false;
    }

    // EDITAR CLIENTE (ADMIN) 
    public boolean editarCliente(Cliente cliente) {
        String sql = "UPDATE clientes SET nome=?, cpf_cnpj=?, telefone=?, email=?, ativo=? WHERE id_cliente=?";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getCpf_cnpj());
            stmt.setString(3, cliente.getTelefone());
            stmt.setString(4, cliente.getEmail());
            stmt.setBoolean(5, cliente.isAtivo());
            stmt.setInt(6, cliente.getId_cliente());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao editar cliente (admin): " + e.getMessage());
        }
        return false;
    }

    // EXCLUIR CLIENTE (ADMIN) 
    public boolean excluirCliente(int id) {
        String sql = "DELETE FROM clientes WHERE id_cliente=?";
        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao excluir cliente (admin): " + e.getMessage());
        }
        return false;
    }



    // CADASTRAR CLIENTE COM SENHA + TOKEN
    public int cadastrarClienteComToken(Cliente cliente) {

        String sql = "INSERT INTO clientes (nome, cpf_cnpj, telefone, email, senha, ativo, token_verificacao) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getCpf_cnpj());
            stmt.setString(3, cliente.getTelefone());
            stmt.setString(4, cliente.getEmail());

            String hash = BCrypt.hashpw(cliente.getSenha(), BCrypt.gensalt());
            stmt.setString(5, hash);

            stmt.setBoolean(6, false); // ainda NÃO verificado
            stmt.setString(7, cliente.getToken_verificacao());

            int linhas = stmt.executeUpdate();

            if (linhas > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao cadastrar cliente: " + e.getMessage());
        }
        return -1;
    }


    // ATIVAR E-MAIL (CONFIRMAR TOKEN)
    public boolean ativarEmail(String token) {

        String sql = "UPDATE clientes SET ativo = 1, token_verificacao = NULL "
                   + "WHERE token_verificacao = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, token);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao ativar email do cliente: " + e.getMessage());
        }
        return false;
    }


    // AUTENTICAR (LOGIN DO CLIENTE)
    public Cliente autenticar(String email, String senhaDigitada) {

        String sql = "SELECT * FROM clientes WHERE email = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                String hash = rs.getString("senha");

                if (!BCrypt.checkpw(senhaDigitada, hash)) {
                    return null; // senha errada
                }

                Cliente c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNome(rs.getString("nome"));
                c.setCpf_cnpj(rs.getString("cpf_cnpj"));
                c.setTelefone(rs.getString("telefone"));
                c.setEmail(rs.getString("email"));
                c.setSenha(rs.getString("senha"));
                c.setAtivo(rs.getBoolean("ativo"));
                c.setToken_verificacao(rs.getString("token_verificacao"));
                c.setToken_redefinir(rs.getString("token_redefinir"));

                return c;
            }

        } catch (SQLException e) {
            System.out.println("Erro ao autenticar cliente: " + e.getMessage());
        }
        return null;
    }


    // GERAR TOKEN DE REDEFINIÇÃO DE SENHA
    public boolean salvarTokenRedefinir(String email, String token) {

        String sql = "UPDATE clientes SET token_redefinir = ? WHERE email = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, token);
            stmt.setString(2, email);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao salvar token de redefinição: " + e.getMessage());
        }
        return false;
    }


    // REDEFINIR SENHA
    public boolean redefinirSenha(String token, String novaSenha) {

        String sql = "UPDATE clientes SET senha = ?, token_redefinir = NULL "
                   + "WHERE token_redefinir = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String hash = BCrypt.hashpw(novaSenha, BCrypt.gensalt());
            stmt.setString(1, hash);
            stmt.setString(2, token);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao redefinir senha: " + e.getMessage());
        }
        return false;
    }
    
    public boolean atualizarPerfil(Cliente c) {
        String sql = "UPDATE clientes SET nome=?, cpf_cnpj=?, telefone=?, email=?, senha=? WHERE id_cliente=?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, c.getNome());
            stmt.setString(2, c.getCpf_cnpj());
            stmt.setString(3, c.getTelefone());
            stmt.setString(4, c.getEmail());
            stmt.setString(5, c.getSenha());
            stmt.setInt(6, c.getId_cliente());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar perfil: " + e.getMessage());
        }
        return false;
    }

    public Cliente buscarPorId(int id) {
        String sql = "SELECT * FROM clientes WHERE id_cliente = ?";

        try (Connection conn = ConexaoDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Cliente c = new Cliente();
                c.setId_cliente(rs.getInt("id_cliente"));
                c.setNome(rs.getString("nome"));
                c.setCpf_cnpj(rs.getString("cpf_cnpj"));
                c.setTelefone(rs.getString("telefone"));
                c.setEmail(rs.getString("email"));
                c.setSenha(rs.getString("senha"));
                c.setAtivo(rs.getBoolean("ativo"));
                return c;
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar cliente: " + e.getMessage());
        }
        return null;
    }

}
