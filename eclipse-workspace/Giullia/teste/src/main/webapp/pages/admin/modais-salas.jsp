<!-- Modal Cadastrar Sala -->
<div class="modal fade" id="modalCadastrar" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Cadastrar Nova Sala</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <form id="formCadastrar">

          <div class="row g-3">

            <div class="col-md-6">
              <label class="form-label">Tipo da Sala</label>
              <input type="text" class="form-control" id="cad_nomeTipo" name="nome_tipo" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Número da Sala</label>
              <input type="number" class="form-control" id="cad_numeroSala" name="numero_sala" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Capacidade</label>
              <input type="number" class="form-control" id="cad_capacidade" name="capacidade" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Valor por Hora (R$)</label>
              <input type="number" step="0.01" class="form-control" id="cad_valorHora" name="valor_hora" required>
            </div>

            <div class="col-12">
              <label class="form-label">Equipamentos</label>
              <textarea class="form-control" id="cad_equipamentos" name="equipamentos" rows="3"></textarea>
            </div>

          </div>

        </form>

      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button class="btn btn-primary" onclick="salvarCadastroSala()">Salvar</button>
      </div>

    </div>
  </div>
</div>


<!-- Modal Editar Sala -->
<div class="modal fade" id="modalEditar" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header bg-warning">
        <h5 class="modal-title">Editar Sala</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <form id="formEditar">

          <input type="hidden" id="edit_idSala" name="id_sala">

          <div class="row g-3">

            <div class="col-md-6">
              <label class="form-label">Tipo da Sala</label>
              <input type="text" class="form-control" id="edit_nomeTipo" name="nome_tipo" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Número da Sala</label>
              <input type="number" class="form-control" id="edit_numeroSala" name="numero_sala" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Capacidade</label>
              <input type="number" class="form-control" id="edit_capacidade" name="capacidade" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Valor por Hora (R$)</label>
              <input type="number" step="0.01" class="form-control" id="edit_valorHora" name="valor_hora" required>
            </div>

            <div class="col-12">
              <label class="form-label">Equipamentos</label>
              <textarea class="form-control" id="edit_equipamentos" name="equipamentos" rows="3"></textarea>
            </div>

          </div>

        </form>

      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button class="btn btn-warning" onclick="salvarEdicaoSala()">Salvar Alterações</button>
      </div>

    </div>
  </div>
</div>


<!-- Funções JS -->
<script>

    function editarSala(id, nome, numero, capacidade, equipamentos, valor) {
        document.getElementById("edit_idSala").value = id;
        document.getElementById("edit_nomeTipo").value = nome;
        document.getElementById("edit_numeroSala").value = numero;
        document.getElementById("edit_capacidade").value = capacidade;
        document.getElementById("edit_equipamentos").value = equipamentos;
        document.getElementById("edit_valorHora").value = valor;
    }

    function excluirSala(id) {
        if (confirm("Deseja realmente excluir esta sala?")) {
            window.location.href = "<%= request.getContextPath() %>/SalaServlet?acao=excluir&id_sala=" + id;
        }
    }

    function salvarCadastroSala() {
        var form = document.getElementById("formCadastrar");
        form.action = "<%= request.getContextPath() %>/SalaServlet?acao=cadastrar";
        form.method = "post";
        form.submit();
    }

    function salvarEdicaoSala() {
        var form = document.getElementById("formEditar");
        form.action = "<%= request.getContextPath() %>/SalaServlet?acao=editar";
        form.method = "post";
        form.submit();
    }

</script>
