<%@ Page Title="Gestión de Entradas" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="gestionarEntradas.aspx.vb" Inherits="final_distribuidos_proyecto.gestionarEntradas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Gestión de Entradas
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
/* Modal layout */
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

/* Modal content */
.modal-content {
    background-color: #fff;
    padding: 30px;
    border-radius: 10px;
    width: 80%; /* Establece un ancho relativo para que se adapte bien */
    max-width: 1000px; /* Limita el ancho máximo del modal */
    text-align: left;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    overflow-y: auto;
}

/* Modal title */
.modal-content h2 {
    text-align: center;
    font-size: 24px;
    margin-bottom: 20px;
}

/* Close button */
.close-btn {
    color: #aaa;
    font-size: 30px;
    font-weight: bold;
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
}

.close-btn:hover,
.close-btn:focus {
    color: #f44336;
    text-decoration: none;
    cursor: pointer;
}

/* Form group layout for modal fields */
.form-group {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: space-between;
    margin-bottom: 20px;
}

/* Form field styling for 4 columns */
.form-group > div {
    flex: 1 1 22%; /* Cada campo ocupará aproximadamente el 22% del ancho */
    min-width: 200px; /* Establecemos un mínimo de 200px para cada campo */
    box-sizing: border-box;
}

/* Estilo para las etiquetas */
.form-group label {
    font-weight: bold;
    font-size: 14px;
    margin-bottom: 8px;
    display: block;
}

/* Estilo para los campos de texto */
.form-control {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
    font-size: 14px;
    box-sizing: border-box;
}

/* Button styling */
.btn-block {
    width: 100%;
    padding: 12px;
    border-radius: 5px;
    background-color: #007bff;
    border: none;
    color: white;
    cursor: pointer;
    margin-top: 20px;
}

.btn-block:hover {
    background-color: #0056b3;
}

/* Modal adjustments for responsiveness */
@media (max-width: 768px) {
    .modal-content {
        width: 90%;
    }

    /* Form fields in a single column on small screens */
    .form-group > div {
        flex: 1 1 100%; /* En pantallas pequeñas, los campos ocupan todo el ancho */
    }
}

/* Table layout */
.table th {
    text-align: center;
}

/* Table container with scroll */
.table-container {
    max-height: 500px;
    overflow-y: auto;
}

/* Inline form search bar styling */
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

/* Ensuring neat table layout */
.table-bordered th, .table-bordered td {
    border: 1px solid #ddd;
    padding: 8px;
}

.table td:last-child {
    width: 200px; /* Establece un tamaño fijo para la columna de acciones */
    text-align: center; /* Centra los botones */
}
.table td:nth-child(1){
    text-align: center;
}

/* Centrar la columna de Estado */
.table td:nth-child(11){
    text-align: center;
}

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <!-- Barra superior con botones Buscar y Agregar -->
        <div class="form-inline">

            <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" Placeholder="Buscar por ID..." />
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-secondary" />

        </div>

        <!-- Tabla de Entradas -->
        <div class="table-container">
            <asp:GridView ID="gvEntradas" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                OnRowCommand="gvEntradas_RowCommand" DataKeyNames="id_entrada" OnSelectedIndexChanged="gvEntradas_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="id_entrada" HeaderText="ID entrada" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre sala" />
                    <asp:BoundField DataField="butaca" HeaderText="Butaca" />
                    <asp:BoundField DataField="fecha" HeaderText="Fecha" />
                    <asp:BoundField DataField="hora_inicio" HeaderText="Hora inicio" />
                    <asp:BoundField DataField="hora_fin" HeaderText="Hora fin" />
                    <asp:BoundField DataField="monto" HeaderText="Monto" />
                    <asp:BoundField DataField="nombre_pelicula" HeaderText="Nombre pelicula" />
                    <asp:BoundField DataField="estreno" HeaderText="Estreno" />
                    <asp:BoundField DataField="estado" HeaderText="Estado" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("estado").ToString() = "Ocupado" %>' Enabled='<%# Eval("estado").ToString() = "Libre" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnVer" runat="server" Text="Ver" CommandName="Ver" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-info btn-sm" />
                            <asp:LinkButton ID="btnCambiarE" runat="server" Text="Cambiar estado" CommandName="CambiarE" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-warning btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Modal para el Formulario de Ver -->
        <div id="myModalV" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal();">×</span>
                <h2>Detalles de la Entrada</h2>
                <!-- primera columna -->
                <div class="form-group">
                    <div>
                        <label>ID Entrada:</label>
                        <asp:TextBox ID="txtIdEntrada" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>ID Sala:</label>
                        <asp:TextBox ID="txtSala" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>Nombre Sala:</label>
                        <asp:TextBox ID="txtNombreSala" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>Butaca:</label>
                        <asp:TextBox ID="txtButaca" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                </div>
                <!-- segunda columna -->
                <div class="form-group">
                    <div>
                        <label>Función:</label>
                        <asp:TextBox ID="txtFuncion" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>Película:</label>
                        <asp:TextBox ID="txtPelicula" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>Estreno:</label>
                        <asp:TextBox ID="txtEstreno" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                </div>
                <!-- tercera columna -->
                <div class="form-group">
                    <div>
                        <label>Fecha:</label>
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>Hora Inicio:</label>
                        <asp:TextBox ID="txtHoraInicio" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>Hora Fin:</label>
                        <asp:TextBox ID="txtHoraFin" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                </div>
                <!-- cuarta columna -->
                <div class="form-group">
                    <div>
                        <label>Monto:</label>
                        <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                    <div>
                        <label>Estado:</label>
                        <asp:TextBox ID="txtEstado" runat="server" CssClass="form-control" Enabled="false" ReadOnly="true" />
                    </div>
                </div>
            </div>
        </div>




    </form>

   <script type="text/javascript">
       function openModalV() {
           document.getElementById("myModalV").style.display = "flex";
       }
       function closeModal() {
           document.getElementById("myModalV").style.display = "none";
       }
   </script>


</asp:Content>
