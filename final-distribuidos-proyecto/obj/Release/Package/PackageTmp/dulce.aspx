<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="dulce.aspx.vb" Inherits="final_distribuidos_proyecto.dulce" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Lista de Dulces</h2>
            <!-- Botón para abrir el modal de agregar dulce -->
            <button type="button" class="btn btn-primary" onclick="abrirDulceModal()">
                <i class="bi bi-plus-circle me-2"></i>Agregar Dulce
            </button>
        </div>

        <!-- Tabla de dulces -->
        <div class="table-responsive">
            <table class="table table-hover table-bordered">
                <thead class="table-primary text-center">
                    <tr>
                        <th>ID Dulce</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Tipo</th>
                        <th>Presentación</th>
                        <th>Estado</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Ejemplo de fila de dulce -->
                    <tr>
                        <td>1</td>
                        <td>Chicle</td>
                        <td>0.50</td>
                        <td>Caramelo</td>
                        <td>Individual</td>
                        <td>Activo</td>
                        <td><img src="ruta_de_imagen.jpg" alt="Imagen Dulce" width="50"></td>
                        <td class="text-center">
                            <a href="#" class="text-primary me-2" title="Ver">
                                <i class="bi bi-eye-fill"></i>
                            </a>
                            <a href="#" class="text-warning me-2" title="Modificar">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="#" class="text-danger" title="Eliminar">
                                <i class="bi bi-trash-fill"></i>
                            </a>
                        </td>
                    </tr>
                    <!-- Agregar más filas aquí según los datos de los dulces -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal para agregar dulce -->
    <div class="modal fade" id="addDulceModal" tabindex="-1" aria-labelledby="addDulceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addDulceModalLabel">Agregar Nuevo Dulce</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <form id="dulceForm" novalidate>
                        <!-- Fila para ID y Nombre -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="idDulce" class="form-label">ID Dulce</label>
                                <input type="text" class="form-control" id="idDulce" name="idDulce" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="nombreDulce" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombreDulce" name="nombreDulce" required>
                            </div>
                        </div>

                        <!-- Fila para Precio y Tipo -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="precioDulce" class="form-label">Precio</label>
                                <input type="number" class="form-control" id="precioDulce" name="precioDulce" min="0" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="tipoDulce" class="form-label">Tipo</label>
                                <select id="tipoDulce" class="form-select" name="tipoDulce" required>
                                    <option value="">Seleccione</option>
                                    <option value="Caramelo">Caramelo</option>
                                    <option value="Chocolate">Chocolate</option>
                                    <option value="Galleta">Galleta</option>
                                    <!-- Agregar más opciones según sea necesario -->
                                </select>
                            </div>
                        </div>

                        <!-- Fila para Presentación y Estado -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="presentacionDulce" class="form-label">Presentación</label>
                                <select id="presentacionDulce" class="form-select" name="presentacionDulce" required>
                                    <option value="">Seleccione</option>
                                    <option value="Bolsa">Bolsa</option>
                                    <option value="Caja">Caja</option>
                                    <option value="Individual">Individual</option>
                                    <!-- Agregar más opciones según sea necesario -->
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="estadoDulce" class="form-label">Estado</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="estadoDulce" name="estadoDulce">
                                    <label class="form-check-label" for="estadoDulce">(Activo)</label>
                                </div>
                            </div>
                        </div>

                        <!-- Fila para Imagen -->
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label for="imagenDulce" class="form-label">Inserte su imagen</label>
                                <input type="file" class="form-control" id="imagenDulce" name="imagenDulce" accept="image/*">
                            </div>
                        </div>

                        <!-- Botón de Enviar -->
                        <button type="submit" class="btn btn-primary w-100">Guardar Dulce</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script para abrir el modal y manejar el formulario -->
    <script>
        // Función para abrir el modal
        function abrirDulceModal() {
            const addDulceModal = new bootstrap.Modal(document.getElementById('addDulceModal'));
            addDulceModal.show();
        }

        // Prevenir el envío del formulario y hacer una validación manual
        document.getElementById('dulceForm').addEventListener('submit', (event) => {
            event.preventDefault();
            alert('Formulario de dulce enviado');  // Aquí puedes manejar el envío del formulario
        });
    </script>

</asp:Content>
