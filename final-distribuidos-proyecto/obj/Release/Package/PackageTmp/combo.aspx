<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="combo.aspx.vb" Inherits="final_distribuidos_proyecto.combo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Combo
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Lista de Combos</h2>
            <!-- Botón para abrir el modal de agregar combo -->
            <button type="button" class="btn btn-primary" onclick="abrirComboModal()">
                <i class="bi bi-plus-circle me-2"></i>Agregar Combo
            </button>
        </div>

        <!-- Tabla de combos -->
        <div class="table-responsive">
            <table class="table table-hover table-bordered">
                <thead class="table-primary text-center">
                    <tr>
                        <th>Nombre</th>
                        <th>Estado</th>
                        <th>Detalle</th>
                        <th>Total</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Ejemplo de fila de combo -->
                    <tr>
                        <td>Combo 1</td>
                        <td>Activo</td>
                        <td>Incluye dulces y canchita</td>
                        <td>20.00</td>
                        <td><img src="ruta_de_imagen.jpg" alt="Imagen Combo" width="50"></td>
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
                    <!-- Agregar más filas aquí según los datos de los combos -->
                </tbody>
            </table>
        </div>
    </div>

<!-- Modal para agregar combo -->
<div class="modal fade" id="addComboModal" tabindex="-1" aria-labelledby="addComboModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addComboModalLabel">Agregar Nuevo Combo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <form id="comboForm" novalidate>
                    <!-- Fila para Nombre y Estado -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="comboNombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="comboNombre" name="comboNombre" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="comboEstado" class="form-label">Estado</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="comboEstado" name="comboEstado">
                                <label class="form-check-label" for="comboEstado">(Activo)</label>
                            </div>
                        </div>
                    </div>

                    <!-- Fila para Detalle -->
                    <div class="row">
                        <div class="col-12 mb-3">
                            <label for="comboDetalle" class="form-label">Detalle</label>
                            <textarea class="form-control" id="comboDetalle" name="comboDetalle" rows="3" required></textarea>
                        </div>
                    </div>

                    <!-- Fila para Total y Imagen -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="comboTotal" class="form-label">Total</label>
                            <input type="number" class="form-control" id="comboTotal" name="comboTotal" min="0" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="comboImagen" class="form-label">Imagen</label>
                            <input type="file" class="form-control" id="comboImagen" name="comboImagen" accept="image/*">
                        </div>
                    </div>

                    <!-- Opciones de Productos para el Combo -->
                    <div class="row">
                        <div class="col-12 mb-3">
                            <label class="form-label">Seleccione los productos para el combo</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="dulces" name="productos" value="dulces">
                                <label class="form-check-label" for="dulces">Dulces</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="canchita" name="productos" value="canchita">
                                <label class="form-check-label" for="canchita">Canchita</label>
                            </div>
                        </div>
                    </div>

                    <!-- Botón de Enviar -->
                    <button type="submit" class="btn btn-primary w-100">Guardar Combo</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Script para abrir el modal y manejar el formulario -->
<script>
    // Función para abrir el modal
    function abrirComboModal() {
        const addComboModal = new bootstrap.Modal(document.getElementById('addComboModal'));
        addComboModal.show();
    }

    // Prevenir el envío del formulario y hacer una validación manual
    document.getElementById('comboForm').addEventListener('submit', (event) => {
        event.preventDefault();
        alert('Formulario de combo enviado');  // Aquí puedes manejar el envío del formulario
    });
</script>

</asp:Content>
