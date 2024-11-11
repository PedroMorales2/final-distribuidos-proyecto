<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="presentaciondulce.aspx.vb" Inherits="final_distribuidos_proyecto.presentaciondulce" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Presentación dulce
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-4 text-center " style="width: 75vw;">
        <h2>Gestión presentación dulce</h2>
    </div>
    <form runat="server">
        <!-- Botón para abrir el modal -->
        <div class="mb-3">
            <button type="button" class="btn btn-primary" onclick="agregar()">
                Agregar
            </button>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="tipoDulceModal" tabindex="-1" aria-labelledby="tipoDulceModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="tipoDulceModalLabel">Presentacion dulce</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Panel del formulario dentro del modal -->
                        <asp:Panel ID="pnlForm" runat="server">
                            <div class="mb-1">
                                <div class="d-flex">
                                    <asp:TextBox ID="txtidpresetacion" runat="server" CssClass="form-control me-2 d-none" />
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="txtpresentacion" class="form-label">Presentación:</label>
                                <asp:TextBox ID="txtpresentacion" runat="server" MaxLength="50" CssClass="form-control" required />
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" />
                    </div>
                </div>
            </div>
        </div>
        <div class="container mt-4">
            <div class="row">
                <div class="col-7">
                    <div class="table-responsive">
                        <!-- Tabla con la estructura estándar de Bootstrap -->
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Presentacion</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:PlaceHolder ID="phpresentacion" runat="server"></asp:PlaceHolder>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        // Función para abrir el modal de agregar
        function agregar() {
            var modal = new bootstrap.Modal(document.getElementById('tipoDulceModal'));
            limpiarcampos();
            var boton = document.getElementById('<%= btnGuardar.ClientID %>'); // Accede al botón usando ClientID
            boton.setAttribute('value', 'Guardar');
            modal.show();
        }

        function Verpresentacion(id, tipo) {
            var modal = new bootstrap.Modal(document.getElementById('tipoDulceModal'));
            limpiarcampos();
            var boton = document.getElementById('<%= btnGuardar.ClientID %>'); // Accede al botón usando ClientID
            document.getElementById('tipoDulceModalLabel').textContent = "Presentación dulce";
            boton.classList.add('d-none');

            document.getElementById('ContentPlaceHolder1_txtidpresetacion').value = id;
            document.getElementById('ContentPlaceHolder1_txtpresentacion').value = tipo;

            // Deshabilitar el campo de texto y ocultar el botón
            document.getElementById('ContentPlaceHolder1_txtpresentacion').disabled = true;
            modal.show();
        }

        // Función para editar presentación dulce
        function Editarpresentacion(id, tipo) {
            var modal = new bootstrap.Modal(document.getElementById('tipoDulceModal'));
            limpiarcampos();

            document.getElementById('ContentPlaceHolder1_txtidpresetacion').value = id;
            document.getElementById('ContentPlaceHolder1_txtpresentacion').value = tipo;
            document.getElementById('tipoDulceModalLabel').textContent = "Modificar presentación dulce";

            var boton = document.getElementById('<%= btnGuardar.ClientID %>');
            boton.setAttribute('value', 'Modificar');
            boton.classList.remove('btn-primary');
            boton.classList.add('btn-warning');
            modal.show();
        }

        // Función para eliminar la presentación
        function Eliminarpresentacion(id, tipo) {
            var modal = new bootstrap.Modal(document.getElementById('tipoDulceModal'));
            limpiarcampos();
            document.getElementById('tipoDulceModalLabel').textContent = "¿Deseas eliminar esta presentación?";

            var boton = document.getElementById('<%= btnGuardar.ClientID %>');
            document.getElementById('ContentPlaceHolder1_txtidpresetacion').value = id;
            document.getElementById('ContentPlaceHolder1_txtpresentacion').value = tipo;

            // Deshabilitar el campo de texto y cambiar el color del botón
            document.getElementById('ContentPlaceHolder1_txtpresentacion').disabled = true;
            boton.setAttribute('value', 'Eliminar');
            boton.classList.remove('btn-primary');
            boton.classList.add('btn-danger');  // Cambio de color a rojo para eliminar
            modal.show();
        }


        function limpiarcampos() {
            document.getElementById('tipoDulceModalLabel').textContent = "Agregar tipo dulce";
            var boton = document.getElementById('<%= btnGuardar.ClientID %>');
            boton.classList.remove('d-none');

            // Restablecer valores y estados de los campos
            document.getElementById('ContentPlaceHolder1_txtpresentacion').disabled = false;
            document.getElementById('ContentPlaceHolder1_txtidpresetacion').value = "";
            document.getElementById('ContentPlaceHolder1_txtpresentacion').value = "";

            // Resetear clases del botón
            boton.classList.remove('btn-danger', 'btn-warning');
            boton.classList.add('btn-primary');
        }

    </script>
</asp:Content>
