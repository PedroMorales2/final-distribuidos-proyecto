<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="TipoSocio.aspx.vb" Inherits="final_distribuidos_proyecto.TipoSocio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Gestión de Tipos de Socio</h2>
            
            <!-- Botón para abrir el modal de agregar -->
            <button type="button" class="btn btn-primary mb-3" onclick="limpiarModal()" data-bs-toggle="modal" data-bs-target="#modalAgregar">
                Agregar Nuevo Tipo
            </button>

            <!-- Tabla para listar los tipos de socio -->
            <asp:GridView ID="gvTiposSocio" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
                DataKeyNames="id_tipo" OnRowEditing="gvTiposSocio_RowEditing" OnRowUpdating="gvTiposSocio_RowUpdating"
                OnRowCancelingEdit="gvTiposSocio_RowCancelingEdit" OnRowCommand="gvTiposSocio_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="ID">
                        <ItemTemplate><%# Eval("id_tipo") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nombre Tipo">
                        <ItemTemplate><%# Eval("nombre_tipo") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNombreTipo" runat="server" Text='<%# Bind("nombre_tipo") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Descuento (%)">
                        <ItemTemplate>
                            <%# String.Format("{0:P0}", Eval("descuento")) %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescuento" runat="server" Text='<%# Bind("descuento") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-warning">Editar</asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_tipo") %>' CssClass="btn btn-danger">Eliminar</asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success">Guardar</asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary">Cancelar</asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- Modal para agregar nuevo tipo de socio -->
            <div class="modal fade" id="modalAgregar" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Agregar Tipo de Socio</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox ID="txtNombreTipoModal" runat="server" CssClass="form-control mb-3" placeholder="Nombre Tipo" />
                            <asp:TextBox ID="txtDescuentoModal" runat="server" CssClass="form-control" placeholder="Descuento (%)" />
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function limpiarModal() {
            document.getElementById('<%= txtNombreTipoModal.ClientID %>').value = '';
            document.getElementById('<%= txtDescuentoModal.ClientID %>').value = '';
        }
    </script>
</asp:Content>
