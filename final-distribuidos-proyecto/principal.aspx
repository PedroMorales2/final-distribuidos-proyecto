<%@ Page Title="Bienvenido" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="principal.aspx.vb" Inherits="final_distribuidos_proyecto.principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Bienvenido al Sistema de Cine
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <!-- Enlazar CSS de Bootstrap y fuentes si no están en la MasterPage -->
    <!-- Añadimos la fuente "Poppins" de Google Fonts para un aspecto más moderno -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <!-- Estilos personalizados -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .welcome-section {
            margin-top: 10px;
            text-align: center;
            color: black;
            background: url('images/cinema-bg.jpg') no-repeat center center;
            background-size: cover;
            padding: 100px 0;
            position: relative;
            overflow: hidden;
        }

        .welcome-section::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("https://static.vecteezy.com/system/resources/previews/008/418/487/non_2x/background-with-film-strip-frame-isolated-on-grey-background-design-template-cinema-with-space-for-your-text-movie-and-film-modern-poster-background-cinema-banner-flyer-brochure-leaflet-vector.jpg");
        }

        .welcome-section h1 {
            font-size: 3.5em;
            font-weight: 600;
            animation: fadeInDown 1s;
            z-index: 1;
            position: relative;
        }

        .welcome-section p {
            font-size: 1.5em;
            margin-bottom: 30px;
            animation: fadeInUp 1s;
            z-index: 1;
            position: relative;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .maintenance-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            border-radius: 10px;
            overflow: hidden;
        }

        .maintenance-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .card-body {
            padding: 40px 20px;
        }

        .card-title {
            font-size: 1.5em;
            font-weight: 600;
        }

        .card-text {
            font-size: 1em;
            color: #555;
            margin-bottom: 20px;
        }

        .card i {
            font-size: 4em;
            color: #007bff;
            margin-bottom: 20px;
            animation: zoomIn 0.5s;
        }

        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.5);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        

        /* Fondo degradado para la sección de tarjetas */
        .maintenance-section {
            background: linear-gradient(to bottom, #f8f9fa, #e9ecef);
/*            padding: 60px 0;*/
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Sección de bienvenida -->
    <div class="welcome-section">
        <h1>Bienvenido al Sistema de Cine</h1>
        <p>Gestiona tus formatos, películas, salas y más desde aquí.</p>
    </div>

    <!-- Sección de tarjetas de mantenimiento -->
    <div class="container maintenance-section">
        <div class="row">
             <!-- Tarjeta de Mantenimiento de Cine -->
             <div class="col-md-4 mb-4">
                 <div class="card maintenance-card h-100">
                     <div class="card-body text-center">
                         <i class="bi bi-file-earmark-text"></i>
                         <h5 class="card-title mt-2">Gestión de Cines</h5>
                         <p class="card-text">Administra los cines.</p>
                         <a href="cines.aspx" class="btn btn-primary">Ir a Cines</a>
                     </div>
                 </div>
             </div>
            <!-- Tarjeta de Mantenimiento de Formatos -->
            <div class="col-md-4 mb-4">
                <div class="card maintenance-card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-file-earmark-text"></i>
                        <h5 class="card-title mt-2">Gestión de Formatos</h5>
                        <p class="card-text">Administra los formatos de proyección disponibles.</p>
                        <a href="formatoPedro.aspx" class="btn btn-primary">Ir a Formatos</a>
                    </div>
                </div>
            </div>
            <!-- Tarjeta de Mantenimiento de Películas -->
            <div class="col-md-4 mb-4">
                <div class="card maintenance-card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-film"></i>
                        <h5 class="card-title mt-2">Gestión de Películas</h5>
                        <p class="card-text">Administra el catálogo de películas.</p>
                        <a href="peliculas.aspx" class="btn btn-primary">Ir a Películas</a>
                    </div>
                </div>
            </div>
            <!-- Tarjeta de Mantenimiento de Salas -->
            <div class="col-md-4 mb-4">
                <div class="card maintenance-card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-easel"></i>
                        <h5 class="card-title mt-2">Gestión de Salas</h5>
                        <p class="card-text">Administra las salas de cine disponibles.</p>
                        <a href="salas.aspx" class="btn btn-primary">Ir a Salas</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
