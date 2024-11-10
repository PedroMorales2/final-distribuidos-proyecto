<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="ticket.aspx.vb" Inherits="final_distribuidos_proyecto.ticket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <div class="container mt-4">
            <h2 class="text-center mb-4">Gestionar Tickets</h2>
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar Nuevo Ticket" CssClass="btn btn-primary mt-3" OnClick="btnNuevo_Click" />

            <div class="row">
                <div class="col-md-8">
                    <asp:GridView ID="grvTickets" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        DataKeyNames="id_ticket" OnRowEditing="grvTickets_RowEditing" OnRowUpdating="grvTickets_RowUpdating"
                        OnRowCancelingEdit="grvTickets_RowCancelingEdit" OnRowCommand="grvTickets_RowCommand" OnSelectedIndexChanged="grvTickets_SelectedIndexChanged">
                        <Columns>
                            <asp:TemplateField HeaderText="ID Ticket" ItemStyle-Width="50px">
                                <ItemTemplate><%# Eval("id_ticket") %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Precio" ItemStyle-Width="100px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("precio", "{0:C}") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPrecio" runat="server" Text='<%# Bind("precio") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cantidad" ItemStyle-Width="100px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("cantidad") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCantidad" runat="server" Text='<%# Bind("cantidad") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Descuento" ItemStyle-Width="100px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("descuento", "{0:C}") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDescuento" runat="server" Text='<%# Bind("descuento") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subtotal" ItemStyle-Width="100px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("subtotal", "{0:C}") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSubtotal" runat="server" Text='<%# Bind("subtotal") %>' CssClass="form-control" Enabled="False" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID Usuario" ItemStyle-Width="100px">
                                <ItemTemplate><%# Eval("id_usuario") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtIdUsuario" runat="server" Text='<%# Bind("id_usuario") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-warning btn-sm">Editar</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_ticket") %>' CssClass="btn btn-danger btn-sm" OnClientClick="return confirmDelete();">Eliminar</asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm">Guardar</asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm">Cancelar</asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="col-md-4">
                    <asp:Panel ID="panelEditar" runat="server" Visible="False" CssClass="card p-3 shadow-sm">
                        <h3 class="card-title"><asp:Label ID="lblTitulo" runat="server" Text="Agregar/Editar Ticket"></asp:Label></h3>

                        <div class="form-group">
                            <asp:Label ID="lblPrecio" runat="server" Text="Precio:" CssClass="form-label" />
                            <asp:TextBox ID="txtPrecioPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblCantidad" runat="server" Text="Cantidad:" CssClass="form-label" />
                            <asp:TextBox ID="txtCantidadPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblDescuento" runat="server" Text="Descuento:" CssClass="form-label" />
                            <asp:TextBox ID="txtDescuentoPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblSubtotal" runat="server" Text="Subtotal:" CssClass="form-label" />
                            <asp:TextBox ID="txtSubtotalPanel" runat="server" CssClass="form-control" Enabled="False" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblIdUsuario" runat="server" Text="ID Usuario:" CssClass="form-label" />
                            <asp:TextBox ID="txtIdUsuarioPanel" runat="server" CssClass="form-control" />
                        </div>

                        <div class="d-flex justify-content-between">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function confirmDelete() {
            return confirm("¿Estás seguro de que deseas eliminar este ticket?");
        }
    </script>
</asp:Content>
