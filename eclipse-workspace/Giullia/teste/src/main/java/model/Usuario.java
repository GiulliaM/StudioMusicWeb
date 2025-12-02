package model;

import java.io.Serializable;

public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String username;
    private String password;
    private String tipoUsuario;
    private String email;
    private Integer idClienteFk;
    private boolean emailVerificado;
    private String tokenVerificacao;

    public Usuario() {}

    public Usuario(int id, String username, String password, String tipoUsuario,
                   String email, Integer idClienteFk,
                   boolean emailVerificado, String tokenVerificacao) {

        this.id = id;
        this.username = username;
        this.password = password;
        this.tipoUsuario = tipoUsuario;
        this.email = email;
        this.idClienteFk = idClienteFk;
        this.emailVerificado = emailVerificado;
        this.tokenVerificacao = tokenVerificacao;
    }

    // ✔ Construtor com token (usado futuramente quando tiver verificação)
    public Usuario(String username, String password, String tipoUsuario,
                   String email, Integer idClienteFk, String tokenVerificacao) {

        this.username = username;
        this.password = password;
        this.tipoUsuario = tipoUsuario;
        this.email = email;
        this.idClienteFk = idClienteFk;
        this.emailVerificado = false;
        this.tokenVerificacao = tokenVerificacao;
    }

    // ✔ Construtor que seu CadastroServlet precisa (5 parâmetros)
    public Usuario(String username, String password, String tipoUsuario,
                   Integer idClienteFk, String email) {

        this.username = username;
        this.password = password;
        this.tipoUsuario = tipoUsuario;
        this.idClienteFk = idClienteFk;
        this.email = email;
        this.emailVerificado = false;
        this.tokenVerificacao = null;
    }

    // ================= GETTERS & SETTERS =================
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getTipoUsuario() { return tipoUsuario; }
    public void setTipoUsuario(String tipoUsuario) { this.tipoUsuario = tipoUsuario; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Integer getIdClienteFk() { return idClienteFk; }
    public void setIdClienteFk(Integer idClienteFk) { this.idClienteFk = idClienteFk; }

    public boolean isEmailVerificado() { return emailVerificado; }
    public void setEmailVerificado(boolean emailVerificado) { this.emailVerificado = emailVerificado; }

    public String getTokenVerificacao() { return tokenVerificacao; }
    public void setTokenVerificacao(String tokenVerificacao) { this.tokenVerificacao = tokenVerificacao; }

    public static long getSerialversionuid() { return serialVersionUID; }

}
