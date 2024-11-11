<%@ Page Title="Gestión de Entradas" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="gestionarEntradas.aspx.vb" Inherits="final_distribuidos_proyecto.gestionarEntradas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Gestión de Entradas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container {
            max-height: 500px;
            overflow-y: auto;
        }

        .form-inline {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

            .form-inline input[type="text"] {
                width: 200px;
                padding: 8px;
            }

            .form-inline .btn {
                padding: 8px 12px;
            }

        .modal {
            display: none; /* Asegúrate de que el modal esté oculto al cargar */
            position: fixed;
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            text-align: end;
        }

            .modal-content h2 {
                text-align: center;
            }

        .close-btn {
            color: #aaa;
            float: right;
            font-size: 24px;
            cursor: pointer;
            margin-top: -20px;
        }

            .close-btn:hover {
                color: red;
            }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

            .form-group label {
                font-weight: bold;
            }

        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
        }

        .btn-block {
            width: 100%;
            padding: 12px;
            border-radius: 5px;
            background-color: #007bff;
            border: none;
            color: #fff;
            cursor: pointer;
            margin-top: 20px;
        }

            .btn-block:hover {
                background-color: #0056b3;
            }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <!-- Barra superior con botones Buscar y Agregar -->
        <div class="form-inline">

            <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" Placeholder="Buscar por ID..." />
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-secondary" />
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-primary" />

        </div>

        <!-- Tabla de Entradas -->
        <div class="table-container">
            <asp:GridView ID="gvEntradas" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                OnRowCommand="gvEntradas_RowCommand" DataKeyNames="id_entrada">
                <Columns>
                    <asp:BoundField DataField="id_entrada" HeaderText="ID Entrada" />
                    <asp:BoundField DataField="id_butaca" HeaderText="ID Butaca" />
                    <asp:BoundField DataField="id_sala" HeaderText="ID Sala" />
                    <asp:BoundField DataField="id_funcion" HeaderText="ID Función" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkEstadoGrid" runat="server" Checked='<%# Convert.ToBoolean(Eval("estado")) %>' Enabled="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnVer" runat="server" Text="Ver" CommandName="Ver" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-info btn-sm" />
                            <asp:LinkButton ID="btnModificar" runat="server" Text="Modificar" CommandName="Modificar" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-warning btn-sm" />
                            <asp:LinkButton ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-danger btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Modal para el Formulario de Agregar  -->
       <div id="myModalAgregar" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal();">×</span>
                <h2>Agregar Entrada</h2>
                <div class="form-group">
                    <label>ID Entrada:</label>
                    <asp:TextBox ID="txtIdEntrada" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label>Función Programada:</label>
                    <asp:DropDownList ID="ddlFuncion" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Butaca:</label>
                    <asp:DropDownList ID="ddlButaca" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Sala:</label>
                    <asp:DropDownList ID="ddlSala" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Estado:</label>
                    <asp:CheckBox ID="chkEstado" runat="server" Text="Ocupado" />
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar entrada" CssClass="btn btn-success btn-block" />
            </div>
        </div>

         <!-- Modal para el Formulario de Modificar  -->
        <div id="myModalModificar" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal();">×</span>
                <h2>Agregar Entrada</h2>
                <div class="form-group">
                    <label>ID Entrada:</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label>Función Programada:</label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Butaca:</label>
                    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Sala:</label>
                    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Estado:</label>
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Ocupado" />
                </div>
                <asp:Button ID="Button1" runat="server" Text="Guardar modificacion de entrada" CssClass="btn btn-success btn-block" />
            </div>
        </div>

         <!-- Modal para el Formulario de Ver  -->
        <div id="myModalV" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal();">×</span>
                <h2>Agregar Entrada</h2>
                <div class="form-group">
                    <label>ID Entrada:</label>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Enabled="false" />
                </div>
                <div class="form-group">
                    <label>Función Programada:</label>
                    <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Butaca:</label>
                    <asp:DropDownList ID="DropDownList5" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Sala:</label>
                    <asp:DropDownList ID="DropDownList6" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Estado:</label>
                    <asp:CheckBox ID="CheckBox2" runat="server" Text="Ocupado" />
                </div>
            </div>
        </div>

    </form>

   <script type="text/javascript">
       function openModal() {
           document.getElementById("myModalAgregar").style.display = "flex";
       }
       function openModalM() {
           document.getElementById("myModalModificar").style.display = "flex";
       }
       function openModalV() {
           document.getElementById("myModalV").style.display = "flex";
       }
       function closeModal() {
           document.getElementById("myModalAgregar").style.display = "none";
           document.getElementById("myModalModificar").style.display = "none";
           document.getElementById("myModalV").style.display = "none";
       }
   </script>


</asp:Content>
