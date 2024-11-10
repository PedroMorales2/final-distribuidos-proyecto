<%@ Page Title="Gestión de Cines" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="cines.aspx.vb" Inherits="final_distribuidos_proyecto.cines" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Gestión de Cines
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            margin: 20px auto;
            padding: 20px;
            width: 100%;
            max-width: 1400px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-section, .table-section {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 5px;
            width: 45%;
        }
        .form-section h2, .table-section h2 {
            color: #333;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input[type="text"], .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        .button-group .btn {
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
        .btn-primary { background-color: #333; color: #fff; }
        .btn-secondary { background-color: #6c757d; color: #fff; }
        .btn-danger { background-color: #dc3545; color: #fff; }
        .table-section {
            width: 100%;
            overflow-x: hidden;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        .table th {
            background-color: #333;
            color: #fff;
        }
        .table tbody tr:hover {
            background-color: #e0e0e0;
            cursor: pointer;
        }
        .table tbody tr.selected {
            background-color: #b3d4fc;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="container mt-4">
            <div class="form-section">
                <h2>Gestionar Cine</h2>
                <div class="form-group">
                    <label for="txtNombre">Nombre:</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                    <asp:Button ID="btnBuscar" runat="server" CssClass="btn btn-primary" Text="Buscar" OnClick="btnBuscar_Click" />
                </div>
                <div class="form-group">
                    <label for="txtCantidadSalas">Cantidad de salas:</label>
                    <asp:TextBox ID="txtCantidadSalas" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="txtDireccion">Dirección:</label>
                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <asp:FileUpload ID="fuImagen" runat="server" OnChange="PreviewImage()" />
                    <asp:Label ID="lblImagenError" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                </div>
                <div class="form-group">
                    <asp:Image ID="imgPreview" runat="server" Width="200px" Height="200px" AlternateText="Vista previa de la imagen" Visible="False" />
                </div>
                <div class="form-group">
                    <label for="ddlDepartamento">Departamento:</label>
                    <asp:DropDownList ID="ddlDepartamento" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" />
                </div>
                <div class="form-group">
                    <label for="ddlProvincia">Provincia:</label>
                    <asp:DropDownList ID="ddlProvincia" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged" />
                </div>
                <div class="form-group">
                    <label for="ddlDistrito">Distrito:</label>
                    <asp:DropDownList ID="ddlDistrito" runat="server" CssClass="form-control" />
                </div>
                <div class="button-group">
                    <asp:Button ID="btnNuevo" runat="server" CssClass="btn btn-primary" Text="Nuevo" OnClick="btnNuevo_Click" />
                    <asp:Button ID="btnModificar" runat="server" CssClass="btn btn-secondary" Text="Modificar" OnClick="btnModificar_Click" />
                    <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger" Text="Eliminar" OnClick="btnEliminar_Click" />
                    <asp:Button ID="btnLimpiar" runat="server" CssClass="btn btn-secondary" Text="Limpiar" OnClick="btnLimpiar_Click" />
                </div>
                <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" CssClass="form-group"></asp:Label>
            </div>

            <div class="table-section">
                <h2>Lista de Cines</h2>
                <asp:GridView ID="gvCines" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" DataKeyNames="id_cine" 
                    OnRowEditing="gvCines_RowEditing" OnRowUpdating="gvCines_RowUpdating" OnRowCancelingEdit="gvCines_RowCancelingEdit" OnRowCommand="gvCines_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="id_cine" HeaderText="ID Cine" />
                        <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="cant_salas" HeaderText="Cantidad de Salas" />
                        <asp:BoundField DataField="direccion" HeaderText="Dirección" />
                        <asp:BoundField DataField="enlace_imagen" HeaderText="Enlace Imagen" />
                        <asp:BoundField DataField="id_ubigeo" HeaderText="ID Ubigeo" />
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-warning btn-sm">
                                    <i class="bi bi-pencil-square"></i> Editar
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_cine") %>' CssClass="btn btn-danger btn-sm" 
                                    OnClientClick="return confirmDelete();">
                                    <i class="bi bi-trash"></i> Eliminar
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function confirmDelete() {
            return swal({
                title: "¿Estás seguro?",
                text: "Esta acción eliminará el cine de forma permanente.",
                icon: "warning",
                buttons: ["Cancelar", "Eliminar"],
                dangerMode: true,
            }).then((willDelete) => {
                return willDelete;
            });
        }
    </script>
</asp:Content>
