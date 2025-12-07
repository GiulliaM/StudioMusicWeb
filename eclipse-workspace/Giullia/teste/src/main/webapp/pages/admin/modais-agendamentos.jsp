<%@ page import="dao.ClienteDAO" %>
<%@ page import="dao.SalaDAO" %>
<%
    ClienteDAO clienteDAO = new ClienteDAO();
    SalaDAO salaDAO = new SalaDAO();
    java.util.List clientes = clienteDAO.listarClientes();
    java.util.List salas = salaDAO.listarSalas();
%>

<div class="modal fade" id="modalCadastrar" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Novo Agendamento</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form id="formCadastrar">
      <div class="modal-body">
        <div class="row g-3">

          <div class="col-md-6">
            <label class="form-label">Cliente</label>
            <select name="id_cliente" class="form-control" required>
              <option value="">-- selecione --</option>
              <% for (Object o : clientes) {
                    model.Cliente c = (model.Cliente) o; %>
                    <option value="<%= c.getId_cliente() %>"><%= c.getNome() %> - <%= c.getCpf_cnpj() %></option>
              <% } %>
            </select>
          </div>

          <div class="col-md-6">
            <label class="form-label">Sala</label>
            <select name="id_sala" class="form-control" required>
              <option value="">-- selecione --</option>
              <% for (Object o : salas) {
                    model.Sala s = (model.Sala) o; %>
                    <option value="<%= s.getId_sala() %>"><%= s.getNome_tipo() %> - Nº <%= s.getNumero_sala() %> (R$ <%= s.getValor_hora() %>)</option>
              <% } %>
            </select>
          </div>

          <div class="col-md-4">
            <label class="form-label">Data</label>
            <input type="date" name="data_agendamento" class="form-control" required>
          </div>

          <div class="col-md-4">
            <label class="form-label">Hora Início</label>
            <input type="time" name="hora_inicio" class="form-control" required>
          </div>

          <div class="col-md-4">
            <label class="form-label">Hora Fim</label>
            <input type="time" name="hora_fim" class="form-control" required>
          </div>

          <div class="col-md-6">
            <label class="form-label">Status</label>
            <select name="status" class="form-control">
              <option value="Agendado">Agendado</option>
              <option value="Em andamento">Em andamento</option>
              <option value="Concluído">Concluído</option>
              <option value="Cancelado">Cancelado</option>
            </select>
          </div>

        </div>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button class="btn btn-primary" onclick="salvarCadastroAgendamento()">Salvar</button>
      </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal Editar -->
<div class="modal fade" id="modalEditar" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title">Editar Agendamento</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <form id="formEditar">
      <div class="modal-body">
        <input type="hidden" id="edit_id_agendamento" name="id_agendamento">

        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Cliente</label>
            <select id="edit_id_cliente" name="id_cliente" class="form-control" required>
              <% for (Object o : clientes) {
                    model.Cliente c = (model.Cliente) o; %>
                    <option value="<%= c.getId_cliente() %>"><%= c.getNome() %> - <%= c.getCpf_cnpj() %></option>
              <% } %>
            </select>
          </div>

          <div class="col-md-6">
            <label class="form-label">Sala</label>
            <select id="edit_id_sala" name="id_sala" class="form-control" required>
              <% for (Object o : salas) {
                    model.Sala s = (model.Sala) o; %>
                    <option value="<%= s.getId_sala() %>"><%= s.getNome_tipo() %> - Nº <%= s.getNumero_sala() %> (R$ <%= s.getValor_hora() %>)</option>
              <% } %>
            </select>
          </div>

          <div class="col-md-4">
            <label class="form-label">Data</label>
            <input type="date" id="edit_data_agendamento" name="data_agendamento" class="form-control" required>
          </div>

          <div class="col-md-4">
            <label class="form-label">Hora Início</label>
            <input type="time" id="edit_hora_inicio" name="hora_inicio" class="form-control" required>
          </div>

          <div class="col-md-4">
            <label class="form-label">Hora Fim</label>
            <input type="time" id="edit_hora_fim" name="hora_fim" class="form-control" required>
          </div>

          <div class="col-md-6">
            <label class="form-label">Status</label>
            <select id="edit_status" name="status" class="form-control">
              <option value="Agendado">Agendado</option>
              <option value="Em andamento">Em andamento</option>
              <option value="Concluído">Concluído</option>
              <option value="Cancelado">Cancelado</option>
            </select>
          </div>

        </div>
      </div>

      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button class="btn btn-warning" onclick="salvarEdicaoAgendamento()">Salvar Alterações</button>
      </div>
      </form>
    </div>
  </div>
</div>

<script>
  function salvarCadastroAgendamento() {
      var f = document.getElementById("formCadastrar");
      f.action = "<%= request.getContextPath() %>/AgendamentoServlet?acao=cadastrar";
      f.method = "post";
      f.submit();
  }

  function salvarEdicaoAgendamento() {
      var f = document.getElementById("formEditar");
      f.action = "<%= request.getContextPath() %>/AgendamentoServlet?acao=editar";
      f.method = "post";
      f.submit();
  }
</script>
