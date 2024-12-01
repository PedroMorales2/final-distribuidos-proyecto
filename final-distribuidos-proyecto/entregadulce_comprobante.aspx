<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="entregadulce_comprobante.aspx.vb" Inherits="final_distribuidos_proyecto.entregadulce_comprobante" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
     <style>
        .btn {
            border-radius: 4px !important;
            padding: .375rem .75rem !important;
        }



    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="bg-light" style="width: 70vw;">
            <div class="container my-5">
                <div class="card shadow">
                    <div class="card-header text-center bg-primary text-white">
                        <h2>Entrega de venta de dulces</h2>
                    </div>
                    <div class="card-body">
                        <div class="mb-4">
                            <label for="numeroVenta" class="form-label">Número de Venta:</label>
                            <div class="d-flex">
                                <div class="me-2">
                                    <asp:TextBox ID="numeroVenta" CssClass="form-control form-control-sm me-2 w-100" placeholder="Ingresa el número de venta" runat="server"></asp:TextBox>
                                </div>
                                <div>
                                  <asp:Button ID="buscarVenta" CssClass="btn btn-sm btn-primary" Text="Buscar Venta" runat="server" OnClick="buscarVenta_Click" />
                                 <asp:Button ID="limpiarButton" CssClass="btn btn-secondary " Text="Limpiar" runat="server" OnClick="limpiarButton_Click" />

                                </div>
                            </div>
                            <div class="mt-2 w-25">
                                <label for="numeroVenta" class="form-label">Cliente:</label> 
                                  <asp:TextBox ID="cliente" CssClass="form-control form-control-sm me-2 w-100"  ReadOnly runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div id="detalleVenta">
                            <hr />
                            <h5 class="text-center mb-3">Detalle de la Venta</h5>
                            <table class="table table-striped">
                                <thead class="">
                                    <tr>
                                        <th>Producto</th>
                                        <th>Cantidad</th>
                                    </tr>
                                </thead>
                                <tbody >
                                    <asp:Literal ID="productosVentaLiteral" runat="server"></asp:Literal>
                                </tbody>
                            </table>
                            <div class="form-check">
                                    <asp:CheckBox ID="actualizarEstadoCheckbox" Text="Estado" runat="server" />
                            </div>
                                    <asp:Button ID="actualizarEstado" CssClass="btn btn-success mt-3" Text="Actualizar Estado" runat="server" OnClick="actualizarEstado_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
 

    </script>
</asp:Content>
