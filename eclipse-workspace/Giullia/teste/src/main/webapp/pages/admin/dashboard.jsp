<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dao.DashboardDAO" %>
<%@ page import="java.util.*" %>

<%
    DashboardDAO dash = new DashboardDAO();

    int totalSalas = dash.totalSalas();
    int totalClientes = dash.totalClientes();
    int agendamentosHoje = dash.agendamentosHoje();

    List<Map<String,Object>> ultimos = dash.ultimosAgendamentos();
    int[] dadosGrafico = dash.agendamentosPorMes();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Admin</title>

    <!-- Bootstrap -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <!-- Ícones -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .conteudo-admin {
            margin-left: 250px;
            padding: 25px;
        }
        @media(max-width:800px){
            .conteudo-admin { margin-left: 0; }
        }

        .card-minimal {
            border-left: 4px solid #1976D2;
            background: white;
            padding: 18px;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        .card-title{
            font-size: 14px;
            color: #777;
        }
        .card-value{
            font-size: 26px;
            font-weight: bold;
            color:#333;
        }
    </style>
</head>

<body>

<!-- Header -->
<%@ include file="includes/header.jsp" %>

<!-- Sidebar -->
<%@ include file="includes/menu.jsp" %>

<div class="conteudo-admin">

    <h2 class="fw-bold mb-4">Dashboard</h2>

    <!-- CARDS -->
    <div class="row g-4 mb-4">

        <div class="col-md-4">
            <div class="card-minimal">
                <div class="card-title">Salas cadastradas</div>
                <div class="card-value"><%= totalSalas %></div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-minimal">
                <div class="card-title">Clientes ativos</div>
                <div class="card-value"><%= totalClientes %></div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-minimal">
                <div class="card-title">Agendamentos hoje</div>
                <div class="card-value"><%= agendamentosHoje %></div>
            </div>
        </div>

    </div>

    <!-- GRÁFICO -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="mb-3">Agendamentos por mês</h5>
            <canvas id="graficoMeses"></canvas>
        </div>
    </div>

    <!-- ÚLTIMOS AGENDAMENTOS -->
    <div class="card shadow-sm">
        <div class="card-body">
            <h5 class="mb-3">Últimos agendamentos</h5>

            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Sala</th>
                        <th>Data</th>
                        <th>Hora</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Map<String,Object> m : ultimos) { %>
                    <tr>
                        <td><%= m.get("id") %></td>
                        <td><%= m.get("cliente") %></td>
                        <td><%= m.get("sala") %></td>
                        <td><%= m.get("data") %></td>
                        <td><%= m.get("hora") %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script>
    // Gráfico Chart.js
    const ctx = document.getElementById('graficoMeses').getContext('2d');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                'Jan','Fev','Mar','Abr','Mai','Jun',
                'Jul','Ago','Set','Out','Nov','Dez'
            ],
            datasets: [{
                label: 'Agendamentos',
                data: <%= Arrays.toString(dadosGrafico) %>,
                backgroundColor: '#1976D2'
            }]
        },
        options: {
            responsive: true,
            scales: { y: { beginAtZero: true } }
        }
    });
</script>

</body>
</html>
