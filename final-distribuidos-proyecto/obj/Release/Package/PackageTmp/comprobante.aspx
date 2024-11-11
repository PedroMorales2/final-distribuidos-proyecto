<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="comprobante.aspx.vb" Inherits="final_distribuidos_proyecto.comprobante" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Gestión de Comprobantes</h2>
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar Nuevo Comprobante" CssClass="btn btn-primary mt-3" OnClick="btnNuevo_Click" />

            <div class="row">
                <div class="col-md-8">
                    <asp:GridView ID="grvComprobante" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        DataKeyNames="id_comprobante" OnRowEditing="grvComprobante_RowEditing" OnRowUpdating="grvComprobante_RowUpdating"
                        OnRowCancelingEdit="grvComprobante_RowCancelingEdit" OnRowCommand="grvComprobante_RowCommand" OnSelectedIndexChanged="grvComprobante_SelectedIndexChanged">
                        <Columns>
                            <asp:TemplateField HeaderText="ID Comprobante" ItemStyle-Width="50px">
                                <ItemTemplate><%# Eval("id_comprobante") %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total" ItemStyle-Width="150px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("total") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTotal" runat="server" Text='<%# Bind("total") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Impuesto" ItemStyle-Width="150px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("impuesto") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtImpuesto" runat="server" Text='<%# Bind("impuesto") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subtotal" ItemStyle-Width="150px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("subtotal") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSubtotal" runat="server" Text='<%# Bind("subtotal") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fecha Emisión" ItemStyle-Width="200px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("fecha_emision", "{0:yyyy-MM-dd}") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtFechaEmision" runat="server" Text='<%# Bind("fecha_emision") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID Ticket" ItemStyle-Width="150px">
                                <ItemTemplate><%# Eval("id_ticket") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtIdTicket" runat="server" Text='<%# Bind("id_ticket") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID Venta" ItemStyle-Width="150px">
                                <ItemTemplate><%# Eval("id_venta") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtIdVenta" runat="server" Text='<%# Bind("id_venta") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ID Forma Pago" ItemStyle-Width="150px">
                                <ItemTemplate><%# Eval("id_forma") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtIdForma" runat="server" Text='<%# Bind("id_forma") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="200px">
                                <ItemTemplate>
                               <asp:LinkButton ID="btnVer" runat="server" CommandName="Ver" CssClass="btn btn-info btn-sm" Style="width: 70px;">
    <i class="bi bi-eye"></i> Ver
</asp:LinkButton>
                                                  
                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_comprobante") %>' CssClass="btn btn-danger btn-sm" Style="width: 70px;"
                    OnClientClick="return confirmDelete();">
<i class="bi bi-trash"></i> Eliminar
                </asp:LinkButton>
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
                        <h3 class="card-title"><asp:Label ID="lblTitulo" runat="server" Text="Agregar/Editar Comprobante"></asp:Label></h3>

                        <div class="form-group">
                            <asp:Label ID="lblTotal" runat="server" Text="Total:" CssClass="form-label" />
                            <asp:TextBox ID="txtTotalPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblImpuesto" runat="server" Text="Impuesto:" CssClass="form-label" />
                            <asp:TextBox ID="txtImpuestoPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblSubtotal" runat="server" Text="Subtotal:" CssClass="form-label" />
                            <asp:TextBox ID="txtSubtotalPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblFechaEmision" runat="server" Text="Fecha Emisión:" CssClass="form-label" />
                            <asp:TextBox ID="txtFechaEmisionPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                           <asp:Label ID="lblIdTicket" runat="server" Text="ID Ticket:" CssClass="form-label" />
<asp:DropDownList ID="ddlIdTicket" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlIdTicket_SelectedIndexChanged" />

                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblIdVenta" runat="server" Text="ID Venta:" CssClass="form-label" />
<asp:DropDownList ID="ddlIdVenta" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlIdVenta_SelectedIndexChanged" />

                        </div>
                        <div class="form-group">
                          <asp:Label ID="lblIdForma" runat="server" Text="Forma de Pago:" CssClass="form-label" />
<asp:DropDownList ID="ddlIdForma" runat="server" CssClass="form-control" />
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
            return confirm("¿Estás seguro de que deseas eliminar este comprobante?");
        }
    </script>
</asp:Content>
