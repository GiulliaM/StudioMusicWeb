<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StudioMusic | Gravação, Mixagem e Masterização Profissional</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Montserrat:wght@700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        :root {
            --roxo-principal: #4B0082; 
            --roxo-secundario: #8A2BE2; 
            --fundo-escuro: #1E1E1E;
            --fundo-claro: #F8F8F8;
            --texto-claro: #F0F0F0;
            --texto-escuro: #333333;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--fundo-claro); 
            color: var(--texto-escuro);
            line-height: 1.6;
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
        }
        
        .btn-main {
            background: var(--roxo-principal); 
            color: white;
            padding: 14px 35px;
            border-radius: 8px; 
            font-size: 1.1rem;
            font-weight: 700;
            transition: all 0.3s ease;
            text-decoration: none;
            border: 2px solid var(--roxo-principal);
        }
        .btn-main:hover {
            background: var(--roxo-secundario);
            border-color: var(--roxo-secundario);
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(75, 0, 130, 0.4);
            color: white;
        }

        .btn-outline-custom {
            padding: 14px 35px;
            font-size: 1.1rem;
            font-weight: 700;
            border-radius: 8px;
            border: 2px solid var(--texto-claro);
            color: var(--texto-claro);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background-color: var(--roxo-principal);
            color: white;
            border-color: var(--roxo-principal);
        }

        .hero {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 70vh; 
            padding: 120px 0 80px;
            background-color: var(--fundo-escuro); 
            color: var(--texto-claro);
            text-align: center; 
        }
        
        .hero h1, .hero p {
            color: var(--texto-claro);
        }
        
        .hero-left {
            display: none; 
        }
        .hero-left img {
            display: none;
        }

        .hero-content-centered {
            max-width: 800px;
            margin: 0 auto; 
        }

        .hero-content-centered h1 {
            font-size: 5rem; 
            font-weight: 900;
            line-height: 1.1;
            margin-bottom: 15px;
            border-bottom: 5px solid var(--roxo-secundario);
            display: inline-block;
            padding-bottom: 5px;
        }
        
        .hero-content-centered h1 span {
            color: var(--roxo-secundario); 
        }

        .hero-content-centered p {
            font-size: 1.25rem;
            opacity: 0.9;
            margin-bottom: 40px;
        }
        
        @media (max-width: 992px) {
             .hero-content-centered h1 {font-size: 3.5rem;}
        }

        
        @media (max-width: 992px) {
             .hero-right h1 {font-size: 3.5rem;}
        }

        .salas-section {
            padding: 120px 0;
            background: var(--fundo-claro); 
            color: var(--texto-escuro);
        }

        .section-title {
            font-size: 3rem;
            font-weight: 900;
            margin-bottom: 15px;
            color: var(--roxo-principal); 
        }
        
        .section-subtitle {
             font-size: 1.1rem;
             opacity: 0.7;
             margin-bottom: 70px;
             color: var(--texto-escuro);
        }
        .sala-card-carousel {
            background: white;
            border-radius: 12px;
            border: 1px solid #E0E0E0;
            min-height: 500px; 
        }
        
        .sala-card-carousel h3 {
            color: var(--roxo-principal); 
            font-weight: 800;
            margin-bottom: 15px;
        }

        .sala-card-carousel p.lead {
            font-size: 1.1rem;
            opacity: 0.8;
            color: var(--texto-escuro);
        }
        
        .sala-card-carousel p strong {
            color: var(--roxo-secundario); 
            font-weight: 700;
        }

        .sala-card-carousel img {
            max-height: 400px;
            object-fit: cover;
        }

        .carousel-control-prev-icon, .carousel-control-next-icon {
            background-color: var(--roxo-principal);
            border-radius: 50%;
            padding: 20px;
            opacity: 0.8;
        }
        .carousel-indicators [data-bs-target] {
            background-color: var(--roxo-principal);
            opacity: 0.5;
            height: 5px;
        }
        .carousel-indicators .active {
            opacity: 1;
        }

        @media (max-width: 992px) {
            .sala-card-carousel {
                min-height: auto;
                text-align: center;
            }
            .sala-card-carousel .row > * {
                padding-top: 20px;
            }
        }


        .cta-cliente {
            background: var(--fundo-escuro);
            padding: 100px 60px;
            text-align: center;
            color: var(--texto-claro);
            border-top: 5px solid var(--roxo-principal); 
        }

        .cta-cliente h2 {
            font-size: 3rem;
            font-weight: 800;
            color: white;
        }
        .cta-cliente p {
            font-size: 1.15rem;
            margin-bottom: 40px;
            opacity: 0.9;
        }
        

        footer {
            background: #111111;
            color: #666;
            text-align: center;
            padding: 30px;
            font-size: 0.9rem;
            border-top: 1px solid #333333;
        }

        footer a {
            color: var(--roxo-secundario);
            text-decoration: none;
            transition: color 0.3s;
        }
        footer a:hover {
            color: var(--roxo-principal);
        }
    </style>
</head>

<body>

<section class="hero">
    <div class="container">
        <div class="row justify-content-center"> <div class="col-lg-8 text-center hero-content-centered"> <h1 class="mx-auto">Studio<span>Music</span></h1> <p class="mx-auto">
                    Qualidade de estúdio de elite para gravação, mixagem e masterização. 
                    Realize sua visão sonora com a melhor infraestrutura do mercado.
                </p>

                <div class="mt-4">
                    <a href="pages/cliente/cadastro-cliente.jsp" class="btn-main me-3">
                        <i class="bi bi-person-fill-add me-2"></i> Criar Conta
                    </a>
                    <a href="pages/cliente/login-cliente.jsp" class="btn btn-outline-custom">
                        <i class="bi bi-box-arrow-in-right me-2"></i> Entrar
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="salas-section">
    <div class="container">
        <h2 class="text-center section-title">Conheça o Nosso Setup 🎧</h2>
        <p class="text-center section-subtitle">Nossos espaços são projetados com a melhor acústica e equipados com hardware e software de última geração.</p>

        <div id="salasCarousel" class="carousel slide" data-bs-ride="carousel">
            
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Sala 1"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="1" aria-label="Sala 2"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="2" aria-label="Sala 3"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="3" aria-label="Sala 4"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="4" aria-label="Sala 5"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="5" aria-label="Sala 6"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="6" aria-label="Sala 7"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="7" aria-label="Sala 8"></button>
                <button type="button" data-bs-target="#salasCarousel" data-bs-slide-to="8" aria-label="Sala 9"></button>
            </div>

            <div class="carousel-inner">
                
                <div class="carousel-item active">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaVoz.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Voz">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Voz <span class="badge bg-secondary ms-2">#1</span></h3>
                                <p class="lead">Ideal para gravação de vocais, dublagem e narração.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 1 Pessoa</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> Microfone condensador Neumann, Isolamento acústico...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaPodcast.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Podcast">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Podcast <span class="badge bg-secondary ms-2">#2</span></h3>
                                <p class="lead">Estrutura completa para podcasts e entrevistas com qualidade de estúdio.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 4 Pessoas</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> 4 Microfones Shure SM7B, Mesa Behringer, Tratamento...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaBanda.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Banda">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Banda <span class="badge bg-secondary ms-2">#3</span></h3>
                                <p class="lead">Espaço amplo e tratamento acústico para ensaios de bandas completos.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 6 Pessoas</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> Bateria acústica, Amplificador Marshall, Baixo Fender...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaProducao.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Produção">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Produção <span class="badge bg-secondary ms-2">#4</span></h3>
                                <p class="lead">Perfeita para produção musical, beatmakers e DJs.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 4 Pessoas</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> 2 Monitores Yamaha HS8, Teclado controlador Akai, Interface...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaPremium.jpg" class="img-fluid rounded-3 w-100" alt="Sala Premium Mix/Master">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala Premium Mix/Master <span class="badge bg-secondary ms-2">#5</span></h3>
                                <p class="lead">Ambiente de escuta crítica para mixagem final e masterização de alta precisão.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 1 Pessoa</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> Monitores Adam A7X, Tratamento acústico premium, Universal Audio...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaAcustico.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Ensaio Acústico">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Ensaio Acústico <span class="badge bg-secondary ms-2">#6</span></h3>
                                <p class="lead">Perfeita para prática e ensaios semi-acústicos com conforto e qualidade.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 4 Pessoas</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> Bateria eletrônica, Amplificadores, 3 microfones...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaAula.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Aulas Musicais">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Aulas Musicais <span class="badge bg-secondary ms-2">#7</span></h3>
                                <p class="lead">Ambiente equipado para aulas de música, teoria e prática.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 3 Pessoas</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> Teclado Yamaha, Quadro branco, Microfone headset...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaSolo.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Instrumental Solo">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Instrumental Solo <span class="badge bg-secondary ms-2">#8</span></h3>
                                <p class="lead">Para gravação de instrumentos individuais ou estudo concentrado.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 1 Pessoa</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> Violão aço, Violão nylon, Microfone condensador Røde...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="sala-card-carousel p-5 shadow-lg">
                        <div class="row align-items-center">
                            <div class="col-lg-5">
                                <img src="assets/salaVideo.jpg" class="img-fluid rounded-3 w-100" alt="Sala de Conteúdo / VideoStudio">
                            </div>
                            <div class="col-lg-7">
                                <h3>Sala de Conteúdo / VideoStudio <span class="badge bg-secondary ms-2">#9</span></h3>
                                <p class="lead">Equipada para gravação de videoclipes, lives e conteúdo para redes sociais.</p>
                                <div class="mt-4">
                                    <p><strong><i class="bi bi-mic-fill me-2"></i> Capacidade:</strong> 2 Pessoas</p>
                                    <p><strong><i class="bi bi-gear-fill me-2"></i> Equipamentos:</strong> Iluminação softbox, Microfone lapela, Câmera Sony...</p>
                                </div>
                                <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-3">Reservar Agora</a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#salasCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#salasCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Próximo</span>
            </button>
        </div>
        </div>
</section>

<section class="cta-cliente">
    <div class="container">
        <h2>Pronto para gravar e mixar seu projeto?</h2>
        <p class="mt-3">Transforme sua ideia em realidade. Agende sua sessão e comece a produzir com a gente.</p>

        <a href="pages/cliente/login-cliente.jsp" class="btn-main mt-4">
            <i class="bi bi-calendar-check-fill me-2"></i> Reservar Sessão
        </a>
    </div>
</section>

<footer>
    <div class="container">
        <p class="mb-1">StudioMusic © 2025 — Transformando visões em som.</p>
        <a href="login.jsp">Acesso Administrativo</a>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>