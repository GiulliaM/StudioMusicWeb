<!-- Modal Cadastrar Cliente -->
<div class="modal fade" id="modalCadastrar" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Cadastrar Cliente</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form id="formCadastrar">

      <div class="modal-body">

        <div class="row g-3">

          <div class="col-md-6">
            <label class="form-label">Nome</label>
            <input type="text" class="form-control" name="nome" required>
          </div>

          <div class="col-md-6">
            <label class="form-label">CPF/CNPJ</label>
            <input type="text" class="form-control" name="cpf_cnpj" required>
          </div>

          <div class="col-md-6">
            <label class="form-label">Telefone</label>
            <input type="text" class="form-control" name="telefone" required>
          </div>

          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" required>
          </div>

        </div>

      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button class="btn btn-primary" onclick="salvarCadastro()">Salvar</button>
      </div>

      </form>

    </div>
  </div>
</div>


<!-- Modal Editar Cliente -->
<div class="modal fade" id="modalEditar" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header bg-warning">
        <h5 class="modal-title">Editar Cliente</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form id="formEditar">

      <div class="modal-body">

        <input type="hidden" name="id_cliente" id="edit_id">

        <div class="row g-3">

          <div class="col-md-6">
            <label class="form-label">Nome</label>
            <input type="text" class="form-control" id="edit_nome" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label">CPF/CNPJ</label>
            <input type="text" class="form-control" id="edit_cpf" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label">Telefone</label>
            <input type="text" class="form-control" name="telefone" id="edit_telefone" required>
          </div>

          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" id="edit_email" readonly>
          </div>

          <div class="col-md-6">
            <label class="form-label">Status</label>
            <select class="form-control" name="ativo" id="edit_ativo">
              <option value="1">Ativo</option>
              <option value="0">Desativado</option>
            </select>
          </div>

        </div>

      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button class="btn btn-warning" onclick="salvarEdicao()">Salvar Alterações</button>
      </div>

      </form>

    </div>
  </div>
</div>


<script>
  function salvarCadastro() {
      document.getElementById("formCadastrar").action =
          "<%= request.getContextPath() %>/ClienteServlet?acao=cadastrar";
      document.getElementById("formCadastrar").method = "post";
      document.getElementById("formCadastrar").submit();
  }

  function salvarEdicao() {
      document.getElementById("formEditar").action =
          "<%= request.getContextPath() %>/ClienteServlet?acao=editar";
      document.getElementById("formEditar").method = "post";
      document.getElementById("formEditar").submit();
  }
</script>
