package model;

import java.io.Serializable;

public class Agendamento implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id_agendamento;
    private int id_cliente;
    private int id_sala;
    private java.sql.Date data_agendamento;
    private java.sql.Time hora_inicio;
    private java.sql.Time hora_fim;
    private String status;
    private double valor_total;

    // Campos auxiliares (não persistidos diretamente na tabela)
    private String nome_cliente;
    private String nome_sala;

    public Agendamento() {}

    public Agendamento(int id_agendamento, int id_cliente, int id_sala,
                       java.sql.Date data_agendamento, java.sql.Time hora_inicio,
                       java.sql.Time hora_fim, String status, double valor_total) {
        this.id_agendamento = id_agendamento;
        this.id_cliente = id_cliente;
        this.id_sala = id_sala;
        this.data_agendamento = data_agendamento;
        this.hora_inicio = hora_inicio;
        this.hora_fim = hora_fim;
        this.status = status;
        this.valor_total = valor_total;
    }

    // Getters e setters (snake_case)
    public int getId_agendamento() { return id_agendamento; }
    public void setId_agendamento(int id_agendamento) { this.id_agendamento = id_agendamento; }

    public int getId_cliente() { return id_cliente; }
    public void setId_cliente(int id_cliente) { this.id_cliente = id_cliente; }

    public int getId_sala() { return id_sala; }
    public void setId_sala(int id_sala) { this.id_sala = id_sala; }

    public java.sql.Date getData_agendamento() { return data_agendamento; }
    public void setData_agendamento(java.sql.Date data_agendamento) { this.data_agendamento = data_agendamento; }

    public java.sql.Time getHora_inicio() { return hora_inicio; }
    public void setHora_inicio(java.sql.Time hora_inicio) { this.hora_inicio = hora_inicio; }

    public java.sql.Time getHora_fim() { return hora_fim; }
    public void setHora_fim(java.sql.Time hora_fim) { this.hora_fim = hora_fim; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getValor_total() { return valor_total; }
    public void setValor_total(double valor_total) { this.valor_total = valor_total; }

    // auxiliares
    public String getNome_cliente() { return nome_cliente; }
    public void setNome_cliente(String nome_cliente) { this.nome_cliente = nome_cliente; }

    public String getNome_sala() { return nome_sala; }
    public void setNome_sala(String nome_sala) { this.nome_sala = nome_sala; }
}
