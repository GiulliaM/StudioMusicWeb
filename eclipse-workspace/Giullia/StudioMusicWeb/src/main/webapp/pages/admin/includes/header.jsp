<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessao = request.getSession(false);

    if (sessao == null || sessao.getAttribute("tipo") == null ||
        !sessao.getAttribute("tipo").equals("admin")) {

        response.sendRedirect("../../login.jsp");
        return;
    }

    String usuario = (String) sessao.getAttribute("username");
%>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
    .topo {
        background: #1976D2;
        color: white;
        padding: 15px 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 18px;
        box-shadow: 0px 2px 4px rgba(0,0,0,.2);
    }
    .topo a {
        color: white;
        text-decoration: none;
        font-weight: bold;
    }
    .topo a:hover {
        text-decoration: underline;
    }
</style>

<div class="topo">
    <div class="fw-bold">Painel do Admin</div>

    <div>
        Logado como <b><%= usuario %></b> |
        <a href="<%= request.getContextPath() %>/LogoutServlet">Sair</a>
    </div>
</div>
