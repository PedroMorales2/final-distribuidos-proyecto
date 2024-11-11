<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="formaPago.aspx.vb" Inherits="final_distribuidos_proyecto.formaPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Forma de pago
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Lista de Formas de Pago</h2>
            <!-- Botón para abrir el modal de agregar forma de pago -->
            <button type="button" class="btn btn-primary" onclick="abrirFormaPagoModal()">
                <i class="bi bi-plus-circle me-2"></i>Agregar Forma de Pago
           
           
            </button>
        </div>

        <!-- Tabla de formas de pago -->
        <div class="table-responsive">
            <table class="table table-hover table-bordered">
                <thead class="table-primary text-center">
                    <tr>
                        <th>Nombre</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Ejemplo de fila de forma de pago -->
                    <tr>
                        <td>Tarjeta de Crédito</td>
                        <td>Activo</td>
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
                    <!-- Agregar más filas aquí según las formas de pago disponibles -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal para agregar forma de pago -->
    <div class="modal fade" id="addFormaPagoModal" tabindex="-1" aria-labelledby="addFormaPagoModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addFormaPagoModalLabel">Agregar Nueva Forma de Pago</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <form id="formaPagoForm" novalidate>
                        <!-- Campo para Nombre -->
                        <div class="mb-3">
                            <label for="nombreFormaPago" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombreFormaPago" name="nombreFormaPago" required>
                        </div>

                        <!-- Campo para Estado -->
                        <div class="mb-3">
                            <label for="estadoFormaPago" class="form-label">Estado</label>
                            <select id="estadoFormaPago" class="form-select" name="estadoFormaPago" required>
                                <option value="Activo">Activo</option>
                                <option value="Inactivo">Inactivo</option>
                            </select>
                        </div>

                        <!-- Botón de Enviar -->
                        <button type="submit" class="btn btn-primary w-100">Guardar Forma de Pago</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script para abrir el modal y manejar el formulario -->
    <script>
        // Función para abrir el modal
        function abrirFormaPagoModal() {
            const addFormaPagoModal = new bootstrap.Modal(document.getElementById('addFormaPagoModal'));
            addFormaPagoModal.show();
        }

        // Prevenir el envío del formulario y hacer una validación manual
        document.getElementById('formaPagoForm').addEventListener('submit', (event) => {
            event.preventDefault();
            alert('Formulario de forma de pago enviado');  // Aquí puedes manejar el envío del formulario
        });
    </script>
</asp:Content>
