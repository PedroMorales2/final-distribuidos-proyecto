<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="registro.aspx.vb" Inherits="final_distribuidos_proyecto.registro" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <title>Registro - Cine USAT</title>
    <!-- Bootstrap CSS -->
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            background: url('https://i.gifer.com/DUOz.gif') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.85);
            border-radius: 1rem;
            padding: 2rem;
            max-width: 800px;
            width: 100%;
            animation: zoomIn 0.6s ease;
        }
        @keyframes zoomIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <div class="card shadow-lg">
                <h3 class="text-center mb-4">Registro de Usuario</h3>
                <div class="alert alert-primary" role="alert" runat="server" style="display: none;" id="alertContainer">
                    <asp:Label ID="lblAlert" runat="server" Visible="False"></asp:Label>
                </div>

                <!-- Contenedor de dos columnas -->
                <div class="row">
                    <!-- Primera columna -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="numeroDoc" class="form-label"><i class="bi bi-person-badge"></i> Número de Documento</label>
                            <asp:TextBox ID="numeroDoc" runat="server" CssClass="form-control" placeholder="Número de documento"></asp:TextBox>
                        </div>
                        
                        <div class="mb-3">
                            <label for="nombre" class="form-label"><i class="bi bi-person"></i> Nombre</label>
                            <asp:TextBox ID="nombre" runat="server" CssClass="form-control" placeholder="Nombre"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="apellidos" class="form-label"><i class="bi bi-person-lines-fill"></i> Apellidos</label>
                            <asp:TextBox ID="apellidos" runat="server" CssClass="form-control" placeholder="Apellidos"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="correo" class="form-label"><i class="bi bi-envelope"></i> Correo Electrónico</label>
                            <asp:TextBox ID="correo" runat="server" CssClass="form-control" TextMode="Email" placeholder="correo@ejemplo.com"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="genero" class="form-label"><i class="bi bi-gender-ambiguous"></i> Género</label>
                            <asp:DropDownList ID="genero" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Seleccionar" Value="" />
                                <asp:ListItem Text="Masculino" Value="M" />
                                <asp:ListItem Text="Femenino" Value="F" />
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Segunda columna -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="contrasena" class="form-label"><i class="bi bi-key"></i> Contraseña</label>
                            <asp:TextBox ID="contrasena" runat="server" CssClass="form-control" TextMode="Password" placeholder="Contraseña"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="telefono" class="form-label"><i class="bi bi-telephone"></i> Teléfono</label>
                            <asp:TextBox ID="telefono" runat="server" CssClass="form-control" placeholder="Teléfono"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="fechaNacimiento" class="form-label"><i class="bi bi-calendar-date"></i> Fecha de Nacimiento</label>
                            <asp:TextBox ID="fechaNacimiento" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <!-- Dropdown para Tipo de Socio -->
                        <div class="mb-3">
                            <label for="idTipoSocio" class="form-label"><i class="bi bi-people"></i> Tipo de Socio</label>
                            <asp:DropDownList ID="idTipoSocio" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Seleccionar Tipo de Socio" Value="" />
                                
                            </asp:DropDownList>
                        </div>

                        <!-- Dropdown para Ubigeo -->
                        <div class="mb-3">
                            <label for="idUbigeo" class="form-label"><i class="bi bi-geo-alt"></i> Ubigeo</label>
                            <asp:DropDownList ID="idUbigeo" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Seleccionar Ubigeo" Value="" />
                                
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

                <!-- Botón de Registro -->
                <div class="d-grid">
                    <asp:Button ID="btnRegistrar" runat="server" CssClass="btn btn-outline-success" Text="Registrar" OnClick="btnRegistrar_Click" />
                </div>

                <!-- Enlace para volver al inicio de sesión -->
                <div class="text-center mt-3">
                    <a href="login.aspx" class="text-muted">¿Ya tienes una cuenta? Inicia sesión</a>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
