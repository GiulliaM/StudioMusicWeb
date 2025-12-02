package model;

public class Cliente {

    private int id_cliente;
    private String nome;
    private String cpf_cnpj;
    private String telefone;
    private String email;

    private String senha;              
    private boolean ativo;             
    private String token_verificacao;   
    private String token_redefinir;     

    public Cliente() {}

    public Cliente(int id_cliente, String nome, String cpf_cnpj, String telefone, String email, boolean ativo) {
        this.id_cliente = id_cliente;
        this.nome = nome;
        this.cpf_cnpj = cpf_cnpj;
        this.telefone = telefone;
        this.email = email;
        this.ativo = ativo;
    }

    // GETTERS E SETTERS

    public int getId_cliente() { return id_cliente; }
    public void setId_cliente(int id_cliente) { this.id_cliente = id_cliente; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCpf_cnpj() { return cpf_cnpj; }
    public void setCpf_cnpj(String cpf_cnpj) { this.cpf_cnpj = cpf_cnpj; }

    public String getTelefone() { return telefone; }
    public void setTelefone(String telefone) { this.telefone = telefone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }

    public boolean isAtivo() { return ativo; }
    public void setAtivo(boolean ativo) { this.ativo = ativo; }

    public String getToken_verificacao() { return token_verificacao; }
    public void setToken_verificacao(String token_verificacao) { this.token_verificacao = token_verificacao; }

    public String getToken_redefinir() { return token_redefinir; }
    public void setToken_redefinir(String token_redefinir) { this.token_redefinir = token_redefinir; }
}
