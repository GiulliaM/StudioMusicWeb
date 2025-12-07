package model;

public class Sala {

    private int id_sala;
    private String nome_tipo;
    private int numero_sala;
    private int capacidade;
    private String equipamentos;
    private double valor_hora;

    public Sala() {}

    public Sala(int id_sala, String nome_tipo, int numero_sala, int capacidade,
                String equipamentos, double valor_hora) {

        this.id_sala = id_sala;
        this.nome_tipo = nome_tipo;
        this.numero_sala = numero_sala;
        this.capacidade = capacidade;
        this.equipamentos = equipamentos;
        this.valor_hora = valor_hora;
    }

    public int getId_sala() {
        return id_sala;
    }

    public void setId_sala(int id_sala) {
        this.id_sala = id_sala;
    }

    public String getNome_tipo() {
        return nome_tipo;
    }

    public void setNome_tipo(String nome_tipo) {
        this.nome_tipo = nome_tipo;
    }

    public int getNumero_sala() {
        return numero_sala;
    }

    public void setNumero_sala(int numero_sala) {
        this.numero_sala = numero_sala;
    }

    public int getCapacidade() {
        return capacidade;
    }

    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }

    public String getEquipamentos() {
        return equipamentos;
    }

    public void setEquipamentos(String equipamentos) {
        this.equipamentos = equipamentos;
    }

    public double getValor_hora() {
        return valor_hora;
    }

    public void setValor_hora(double valor_hora) {
        this.valor_hora = valor_hora;
    }
}
