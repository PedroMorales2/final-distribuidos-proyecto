<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="formatoPedro.aspx.vb" Inherits="final_distribuidos_proyecto.formato" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Gestión de Formatos</h2>
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar Nuevo Formato" CssClass="btn btn-primary mt-3" OnClick="btnAgregar_Click" />

            <div class="row">
                <div class="col-md-8">

                    <asp:GridView ID="gvFormatos" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        DataKeyNames="id_formato" OnRowEditing="gvFormatos_RowEditing" OnRowUpdating="gvFormatos_RowUpdating"
                        OnRowCancelingEdit="gvFormatos_RowCancelingEdit" OnRowCommand="gvFormatos_RowCommand">
                        <Columns>

                            <asp:TemplateField HeaderText="ID" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <%# Eval("id_formato") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <%# Eval("id_formato") %>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Nombre Formato" ItemStyle-Width="500px">
                                <ItemTemplate>
                                    <span style="font-size: 14px;"><%# Eval("nombre_formato") %></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNombreFormato" runat="server" Text='<%# Bind("nombre_formato") %>' CssClass="form-control" Style="width: 100%; font-size: 14px; padding: 5px;" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Vigencia" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkVigencia" runat="server" Checked='<%# Convert.ToBoolean(Eval("vigencia")) %>' Enabled="False" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkEditVigencia" runat="server" Checked='<%# Bind("vigencia") %>' CssClass="form-check-input" Style="width: 20px; height: 20px;" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="800px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVer" runat="server" CommandName="Ver" CssClass="btn btn-info btn-sm" Style="width: 70px;">
                    <i class="bi bi-eye"></i> Ver
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-warning btn-sm" Style="width: 70px;">
                    <i class="bi bi-pencil-square"></i> Editar
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_formato") %>' CssClass="btn btn-danger btn-sm" Style="width: 70px;"
                                        OnClientClick="return confirmDelete();">
                    <i class="bi bi-trash"></i> Eliminar
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-success btn-sm" Style="width: 70px;">
                    <i class="bi bi-check-lg"></i> Guardar
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-secondary btn-sm" Style="width: 70px;">
                    <i class="bi bi-x-lg"></i> Cancelar
                                    </asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>






                </div>

                <div class="col-md-4">
                    <asp:Panel ID="panelEditar" runat="server" Visible="False" CssClass="card p-3 shadow-sm">
                        <h3 class="card-title">
                            <asp:Label ID="lblTitulo" runat="server" Text="Agregar/Editar Formato"></asp:Label></h3>

                        <div class="form-group">
                            <asp:Label ID="lblNombreFormato" runat="server" Text="Nombre Formato:" CssClass="form-label" />
                            <asp:TextBox ID="txtNombreFormato" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblVigencia" runat="server" Text="Vigencia:" CssClass="form-label" />
                            <asp:CheckBox ID="chkVigencia" runat="server" CssClass="form-check-input" />
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
            // Mostrar SweetAlert para confirmación
            return swal({
                title: "¿Estás seguro?",
                text: "Esta acción eliminará el formato de forma permanente.",
                icon: "warning",
                buttons: ["Cancelar", "Eliminar"],
                dangerMode: true,
            }).then((willDelete) => {
                return willDelete; // Si se confirma, permite el postback
            });
        }
    </script>



</asp:Content>
