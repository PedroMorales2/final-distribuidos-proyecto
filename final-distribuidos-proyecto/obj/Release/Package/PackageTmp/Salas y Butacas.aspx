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
                <div class="form-group">
                    <label for="txtIdSala">ID:</label>
                    <asp:TextBox ID="txtIdSala" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label for="txtNombreSala">Nombre:</label>
                    <asp:TextBox ID="txtNombreSala" runat="server" CssClass="form-control" />
                </div>
                <div class="button-group">
                    <asp:Button ID="btnAgregarSala" runat="server" Text="Agregar" CssClass="btn btn-primary" OnClick="btnAgregarSala_Click" />
                    <asp:Button ID="btnModificarSala" runat="server" Text="Modificar" CssClass="btn btn-secondary" OnClick="btnModificarSala_Click" />
                    <asp:Button ID="btnEliminarSala" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminarSala_Click" />
                    <asp:Button ID="btnLimpiarSala" runat="server" Text="Limpiar" CssClass="btn btn-secondary" OnClick="btnLimpiarSala_Click" />
                </div>

                
                <!-- Tabla de Salas -->
                <h2>Lista de Salas</h2>
                <div class="table-container">
                    <asp:GridView ID="gvSalas" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" AutoPostBack="True" OnSelectedIndexChanged="gvSalas_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="id_sala" HeaderText="ID Sala" />
                            <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- Sección de Butacas -->
            <div class="sectionB">
                <h2>Gestionar Butacas</h2>
                <div class="form-group">
                    <label for="txtIdButaca">ID:</label>
                    <asp:TextBox ID="txtIdButaca" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label for="txtNombreButaca">Nombre:</label>
                    <asp:TextBox ID="txtNombreButaca" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label for="ddlSala">Sala:</label>
                    <asp:DropDownList ID="ddlSala" runat="server" CssClass="form-control" />
                </div>
                <div class="button-group">
                    <asp:Button ID="btnAgregarButaca" runat="server" Text="Agregar" CssClass="btn btn-primary" OnClick="btnAgregarButaca_Click" />
                    <asp:Button ID="btnModificarButaca" runat="server" Text="Modificar" CssClass="btn btn-secondary" OnClick="btnModificarButaca_Click" />
                    <asp:Button ID="btnEliminarButaca" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminarButaca_Click" />
                    <asp:Button ID="btnLimpiarButaca" runat="server" Text="Limpiar" CssClass="btn btn-secondary" OnClick="btnLimpiarButaca_Click" />
                </div>

                
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
            </div>
        </div>
    </form>
</asp:Content>
