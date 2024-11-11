<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Estrenos de Cine - Página de Presentación</title>

    <!-- Vincula el archivo CSS de Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* Estilos para el Carrusel */
        .carousel-item image_pelicula {
            width: 100%;
            height: 600px;
            object-fit: cover;
        }

        .carousel-caption {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        .carousel-caption h5 {
            font-size: 2.5rem;
            font-weight: bold;
        }

        .carousel-caption p {
            font-size: 1.2rem;
        }

        /* Estilos del footer */
        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: 50px;
        }

        .footer a {
            color: #f8f9fa;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Barra de Navegación -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">CineEstrenos</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Tickets</a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link" href="#">Dulcería</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#">Contacto</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Carrusel de Carteles -->
        <div id="movieCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <image_pelicula src="image_pelicula/peli1.jpg" class="d-block w-100" alt="Estreno 1">
                    <div class="carousel-caption">
                        <h5>El tiempo que tenemos</h5>
                        <p>película que aborda las relaciones humanas y el impacto del paso del tiempo</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <image_pelicula src="image_pelicula/peli2.jpg" class="d-block w-100" alt="Estreno 2">
                    <div class="carousel-caption">
                        <h5>Superman</h5>
                        <p>El regreso del hombre de acero.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <image_pelicula src="image_pelicula/plei3.jpg" class="d-block w-100" alt="Estreno 3">
                    <div class="carousel-caption">
                        <h5>La Niña y la Cabra</h5>
                        <p>Una tierna historia de amistad en el campo.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#movieCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#movieCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <!-- Carteles de Películas -->
        <div class="container my-5">
            <h2 class="text-center mb-4">Películas en Estreno</h2>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <div class="col">
                    <div class="movie-card">
                        <image_pelicula src="image_pelicula/card1.jpg" class="card-image_pelicula-top" alt="Película 1">
                        <div class="movie-card-body">
                            <h5 class="movie-title">El tiempo que tenemos</h5>
                            <p class="movie-description">
                                Es una película que aborda las relaciones humanas y el impacto del paso del tiempo en las decisiones y emociones de los personajes. A través de momentos de reflexión, explora cómo el tiempo influye en la vida y en las conexiones personales.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="movie-card">
                        <image_pelicula src="image_pelicula/card2.jpg" class="card-image_pelicula-top" alt="Película 2">
                        <div class="movie-card-body">
                            <h5 class="movie-title">Venom,El Último Baile</h5>
                            <p class="movie-description">
                                El Último Baile, Eddie Brock y su simbionte enfrentan una amenaza alienígena sin precedentes. Un ejército de criaturas xenófagas, lideradas por Knull, el dios de los simbiontes, amenaza con destruir todo lo que conocen. Venom y Eddie deben superar sus diferencias y enfrentarse a un enemigo más grande que cualquier cosa que hayan visto antes.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="movie-card">
                        <image_pelicula src="image_pelicula/card3.jpg" class="card-image_pelicula-top" alt="Película 3">
                        <div class="movie-card-body">
                            <h5 class="movie-title">Robot Salvaje</h5>
                            <p class="movie-description">
                                Es una película de acción y ciencia ficción de 2024 que sigue la historia de un androide diseñado para la guerra, quien tras una serie de eventos inesperados, comienza a cuestionar su propósito y naturaleza.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <p>&copy; 2024 CineEstrenos. Todos los derechos reservados.</p>
            <p>Desarrollado por <a href="https://www.tusitio.com" target="_blank" class="text-white">TuSitioWeb</a></p>
        </footer>
    </form>

    <!-- Script de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
