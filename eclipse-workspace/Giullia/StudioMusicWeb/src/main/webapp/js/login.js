function fazerLogin() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    fetch("LoginServlet", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password })
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "error") {
            document.getElementById("erro").innerText = data.message;
            return;
        }

        if (data.tipo === "admin") {
            window.location.href = "pages/admin/dashboard.jsp";
        } else {
            window.location.href = "pages/cliente/home.jsp";
        }
    })
    .catch(err => {
        console.error("Erro:", err);
        document.getElementById("erro").innerText = "Erro ao conectar.";
    });
}
