<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="entradas.aspx.vb" Inherits="final_distribuidos_proyecto.entradas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Entradas
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Lista de Entradas</h2>
            <!-- Botón para abrir el modal de agregar entrada -->
            <button type="button" class="btn btn-primary" onclick="abrirEntradaModal()">
                <i class="bi bi-plus-circle me-2"></i>Agregar Entrada
            </button>
        </div>

        <!-- Tabla de entradas -->
        <div class="table-responsive">
            <table class="table table-hover table-bordered">
                <thead class="table-primary text-center">
                    <tr>
                        <th>Funciones Programadas</th>
                        <th>Butacas</th>
                        <th>Sala</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Ejemplo de fila de entrada -->
                    <tr>
                        <td>Función A - 8:00 PM</td>
                        <td>F12, F13, F14</td>
                        <td>Sala 1</td>
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
                    <!-- Agregar más filas aquí según los datos de las entradas -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal para agregar entrada -->
    <div class="modal fade" id="addEntradaModal" tabindex="-1" aria-labelledby="addEntradaModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addEntradaModalLabel">Agregar Nueva Entrada</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <form id="entradaForm" novalidate>
                        <!-- Fila para Funciones Programadas -->
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label for="funcionesProgramadas" class="form-label">Funciones Programadas</label>
                                <select id="funcionesProgramadas" class="form-select" name="funcionesProgramadas" required>
                                    <option value="">Seleccione una función</option>
                                    <option value="Funcion A">Función A - 8:00 PM</option>
                                    <option value="Funcion B">Función B - 10:00 PM</option>
                                    <!-- Agregar más opciones según las funciones programadas -->
                                </select>
                            </div>
                        </div>

                        <!-- Fila para Butacas -->
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label for="butacas" class="form-label">Butacas</label>
                                <input type="text" class="form-control" id="butacas" name="butacas" placeholder="Ejemplo: F12, F13, F14" required>
                            </div>
                        </div>

                        <!-- Fila para Sala -->
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label for="sala" class="form-label">Sala</label>
                                <input type="text" class="form-control" id="sala" name="sala" required>
                            </div>
                        </div>

                        <!-- Botón de Enviar -->
                        <button type="submit" class="btn btn-primary w-100">Guardar Entrada</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script para abrir el modal y manejar el formulario -->
    <script>
        // Función para abrir el modal
        function abrirEntradaModal() {
            const addEntradaModal = new bootstrap.Modal(document.getElementById('addEntradaModal'));
            addEntradaModal.show();
        }

        // Prevenir el envío del formulario y hacer una validación manual
        document.getElementById('entradaForm').addEventListener('submit', (event) => {
            event.preventDefault();
            alert('Formulario de entrada enviado');  // Aquí puedes manejar el envío del formulario
        });
    </script>
</asp:Content>
