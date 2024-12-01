<%@ Page Title="Gestión de Salas y Butacas" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="Salas_y_Butacas.aspx.vb" Inherits="final_distribuidos_proyecto.Salas_y_Butacas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Gestión de Salas y Butacas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            margin: 20px auto;
            padding: 20px;
            max-width: 1400px;
        }
        .sectionS {
            width: 70%;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            margin-right: 20px
        }
        .sectionB {
            width: 70%;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            margin-left:20px
        }
        .section h2 {
            text-align: center;
            color: #333;
            margin-bottom: 15px;
        }
        .form-group {
            margin-bottom: 12px;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group input[type="text"], .form-group select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        .button-group .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            margin-right:10px;
            margin-top:5px;
            margin-bottom:25px;
        }
        .btn-primary { background-color: #007bff; color: #fff; }
        .btn-secondary { background-color: #6c757d; color: #fff; }
        .btn-danger { background-color: #dc3545; color: #fff; }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        .table th {
            background-color: #007bff;
            color: #fff;
        }
        .table-container {
            height: 200px;
            overflow-y: auto;
            margin-top:20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="container">

            <!-- Sección de Salas -->
            <div class="sectionS">
                <h2>Gestionar Salas</h2>

                <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addSalaModal">
                    Agregar nueva sala
                </button>

                <!-- Tabla de Salas -->
                <h2>Lista de Salas</h2>
                <div class="table-container">
                    <asp:GridView ID="gvSalas" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" AutoPostBack="True" OnSelectedIndexChanged="gvSalas_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="id_sala" HeaderText="ID Sala" />
                            <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                            <asp:BoundField DataField="num_asientos" HeaderText="Número de asientos" />
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- modal agregar sala-->
                <div class="modal fade" id="addSalaModal" tabindex="-1" aria-labelledby="addSalaModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-md">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addSalaModalLabel">Agregar nueva sala</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="mb-3">
                                            <label for="txtNombreSala" class="form-label">Nombre</label>
                                            <asp:TextBox ID="txtNombreSala" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="mb-3">
                                            <label for="txtNumeroAsientos" class="form-label">Número de asientos</label>
                                            <asp:TextBox ID="txtNumeroAsientos" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnAgregarSala" runat="server" Text="Agregar" CssClass="btn btn-primary" OnClick="btnAgregarSala_Click" />
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtIdSala">ID:</label>
                    <asp:TextBox ID="txtIdSalaV" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label for="txtNombreSala">Nombre:</label>
                    <asp:TextBox ID="txtNombreSalaV" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label for="txtNumeroAsientos">Número de asientos:</label>
                    <asp:TextBox ID="txtNumeroAsientosV" runat="server" CssClass="form-control" Enabled="false" />
                </div>

                <div class="button-group">
                    <asp:Button ID="btnModificarSala" runat="server" Text="Modificar" CssClass="btn btn-secondary" OnClick="btnModificarSala_Click" />
                    <asp:Button ID="btnEliminarSala" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminarSala_Click" />
                    <asp:Button ID="btnLimpiarSala" runat="server" Text="Limpiar" CssClass="btn btn-secondary" OnClick="btnLimpiarSala_Click" />
                </div>

            </div>

            <!-- Sección de Butacas -->
            <div class="sectionB">
                <h2>Gestionar Butacas</h2>

                <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addButacaModal">
                    Agregar Butacas
                </button>

                <!-- Tabla de Butacas -->
                <h2>Lista de Butacas</h2>
                <div class="table-container">
                    <asp:GridView ID="gvButacas" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" AutoPostBack="True" OnSelectedIndexChanged="gvButacas_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="id_butaca" HeaderText="ID Butaca" />
                            <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                            <asp:BoundField DataField="id_sala" HeaderText="Sala" />
                        </Columns>
                    </asp:GridView>
                </div>

                <!-- modal agregar butaca-->
                <div class="modal fade" id="addButacaModal" tabindex="-1" aria-labelledby="addButacaModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-md">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addButacaModalLabel">Agregar Butacas</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-9">
                                        <div class="mb-3">
                                            <label for="ddlSala">Sala:</label>
                                            <asp:DropDownList ID="ddlSala" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlSala_SelectedIndexChanged" />
                                        </div>
                                        <div class="mb-3">
                                            <label for="txtNumeroAsientos" class="form-label">Número de asientos</label>
                                            <asp:TextBox ID="txtNumeroAsientosb" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                                        </div>
                                        <div class="mb-3">
                                            <label for="txtNombreButacaA" class="form-label">A</label>
                                            <asp:TextBox ID="txtNombreButacaA" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                        <div class="mb-3">
                                            <label for="txtNombreButacaB" class="form-label">B</label>
                                            <asp:TextBox ID="txtNombreButacaB" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                        <div class="mb-3">
                                            <label for="txtNombreButacaC" class="form-label">C</label>
                                            <asp:TextBox ID="txtNombreButacaC" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                        <div class="mb-3">
                                            <label for="txtNombreButacaD" class="form-label">D</label>
                                            <asp:TextBox ID="txtNombreButacaD" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnAgregarButaca" runat="server" Text="Agregar" CssClass="btn btn-primary" OnClick="btnAgregarButaca_Click" />
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtIdButaca">ID:</label>
                    <asp:TextBox ID="txtIdButacaV" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label for="ddlSala">Sala:</label>
                    <asp:DropDownList ID="ddlSalaV" runat="server" CssClass="form-control" Enabled="false"/>
                </div>
                <div class="form-group">
                    <label for="txtNombreButaca">Nombre:</label>
                    <asp:TextBox ID="txtNombreButacaV" runat="server" CssClass="form-control" Enabled="false" />
                </div>

                <div class="button-group">

                    <asp:Button ID="btnModificarButaca" runat="server" Text="Modificar" CssClass="btn btn-secondary" OnClick="btnModificarButaca_Click" />
                    <asp:Button ID="btnEliminarButaca" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminarButaca_Click" />
                    <asp:Button ID="btnLimpiarButaca" runat="server" Text="Limpiar" CssClass="btn btn-secondary" OnClick="btnLimpiarButaca_Click" />
                </div>

            </div>
        </div>
    </form>

    <script type="text/javascript">
        // Evento que se dispara cuando se cambia la selección de la Sala
        function actualizarNumeroAsientos() {
            var salaId = document.getElementById('<%= ddlSala.ClientID %>').value;
        if (salaId !== "0") {
            // Realiza una llamada al servidor para obtener el número de asientos
            // Asegúrate de que esta función maneje la actualización sin recargar la página
            __doPostBack('<%= ddlSala.ClientID %>', '');
        } else {
            document.getElementById('<%= txtNumeroAsientosb.ClientID %>').value = '';
        }
    }

    // Asocia el evento al cambio de selección en el DropDownList
    document.getElementById('<%= ddlSala.ClientID %>').onchange = actualizarNumeroAsientos;
    </script>


</asp:Content>
