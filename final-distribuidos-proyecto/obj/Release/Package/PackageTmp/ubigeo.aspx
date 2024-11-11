<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="ubigeo.aspx.vb" Inherits="final_distribuidos_proyecto.ubigeo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Gestionar Ubigeo</h2>
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar Nuevo Ubigeo" CssClass="btn btn-primary mt-3" OnClick="btnNuevo_Click" />

            <div class="row">
                <div class="col-md-8">
                    <asp:GridView ID="grvUbigeo" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        DataKeyNames="id_ubigeo" OnRowEditing="grvUbigeo_RowEditing" OnRowUpdating="grvUbigeo_RowUpdating"
                        OnRowCancelingEdit="grvUbigeo_RowCancelingEdit" OnRowCommand="grvUbigeo_RowCommand" OnSelectedIndexChanged="grvUbigeo_SelectedIndexChanged">
                        <Columns>
                            <asp:TemplateField HeaderText="ID Ubigeo" ItemStyle-Width="50px">
                                <ItemTemplate><%# Eval("id_ubigeo") %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Departamento" ItemStyle-Width="150px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("departamento") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDepartamento" runat="server" Text='<%# Bind("departamento") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Provincia" ItemStyle-Width="150px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("provincia") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtProvincia" runat="server" Text='<%# Bind("provincia") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Distrito" ItemStyle-Width="150px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("distrito") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDistrito" runat="server" Text='<%# Bind("distrito") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="200px">
                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-warning btn-sm" Style="width: 70px;">
<i class="bi bi-pencil-square"></i> Editar
                </asp:LinkButton>
                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_ubigeo") %>' CssClass="btn btn-danger btn-sm" Style="width: 70px;"
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
                        <h3 class="card-title"><asp:Label ID="lblTitulo" runat="server" Text="Agregar/Editar Ubigeo"></asp:Label></h3>

                        <div class="form-group">
                            <asp:Label ID="lblDepartamento" runat="server" Text="Departamento:" CssClass="form-label" />
                            <asp:TextBox ID="txtDepartamentoPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblProvincia" runat="server" Text="Provincia:" CssClass="form-label" />
                            <asp:TextBox ID="txtProvinciaPanel" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblDistrito" runat="server" Text="Distrito:" CssClass="form-label" />
                            <asp:TextBox ID="txtDistritoPanel" runat="server" CssClass="form-control" />
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
            return confirm("¿Estás seguro de que deseas eliminar este cine?");
        }
    </script>
</asp:Content>
