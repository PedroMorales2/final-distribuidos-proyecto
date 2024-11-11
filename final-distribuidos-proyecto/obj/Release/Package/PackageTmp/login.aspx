<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="login.aspx.vb" Inherits="final_distribuidos_proyecto.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>Login - Cine USAT</title>
    <!-- Bootstrap CSS -->
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->

    <!-- Custom CSS -->
    <style>
        body {
            background: url('https://i.gifer.com/DUOz.gif') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.85);
            border: none;
            border-radius: 1rem;
            animation: zoomIn 0.6s ease;
            max-width: 400px;
            width: 100%;
        }

        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }

            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .nav-tabs .nav-link {
            border: none;
            border-bottom: 2px solid transparent;
            color: #6c757d;
            font-weight: 500;
        }

            .nav-tabs .nav-link.active {
                border-color: #0d6efd;
                color: #0d6efd;
            }

        .form-control:focus {
            box-shadow: none;
            border-color: #0d6efd;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
        }

            .btn-primary:hover {
                background-color: #0b5ed7;
            }

        .form-check-input:checked {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }

        .text-muted a {
            color: #0d6efd;
            text-decoration: none;
        }

            .text-muted a:hover {
                text-decoration: underline;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="card shadow-lg p-4">

                <!-- Contenido de las Pestañas -->
                <div class="tab-content" id="loginRegisterTabsContent">
                    <!-- Formulario de Iniciar Sesión -->
                    <div class="tab-pane fade show active" id="login-tab-pane" role="tabpanel" aria-labelledby="login-tab">
                        <h3 class="text-center mb-4">Bienvenido</h3>
                        


                        <p class="text-center text-muted mb-4">Inicia sesión con tu cuenta</p>
                        <div class="alert alert-danger" role="alert" runat="server" id="errorContainer" visible="false">
                            <asp:Label runat="server" Text="Label" ID="lbl_error" Visible="False"></asp:Label>
                        </div>

                        <div class="mb-3">
                            <label for="loginEmail" class="form-label">Correo electrónico</label>
                            <asp:TextBox ID="loginEmail" runat="server" CssClass="form-control" placeholder="correo@ejemplo.com" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="loginPassword" class="form-label">Contraseña</label>
                            <asp:TextBox ID="loginPassword" runat="server" CssClass="form-control" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <a href="#" class="text-decoration-none small">¿Olvidaste tu contraseña?</a>
                        </div>
                        <div class="d-grid">
                            <asp:Button ID="btnLogin" runat="server" Text="Iniciar sesión" CssClass="btn btn-outline-success" />
                            <br />
                            <a href="registro.aspx" class="btn btn-outline-info">Registrarse</a>
                        </div>
                    </div>



                    <!-- Pie de la tarjeta -->
                    <div class="text-center text-muted mt-4">
                        <p>&copy; 2024 Cine USAT</p>
                    </div>
                </div>
            </div>
            </div>

            <!-- Bootstrap JavaScript -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
