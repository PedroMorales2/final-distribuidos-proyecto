<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="cines.aspx.vb" Inherits="final_distribuidos_proyecto.cines" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <div class="container mt-4">
                       <div id="alertContainer" runat="server" class="alert alert-dismissible fade show" style="display: none;">
                <span id="alertMessage" runat="server"></span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <h2 class="text-center mb-4">Gestión de Cines</h2>
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar Nuevo Cine" CssClass="btn btn-primary mt-3" OnClick="btnAgregar_Click" />

            <div class="row">
                <div class="col-md-8">
                    <asp:GridView ID="gvCines" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                        DataKeyNames="id_cine" OnRowEditing="gvCines_RowEditing" OnRowUpdating="gvCines_RowUpdating"
                        OnRowCancelingEdit="gvCines_RowCancelingEdit" OnRowCommand="gvCines_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="ID Cine" ItemStyle-Width="50px">
                                <ItemTemplate><%# Eval("id_cine") %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Nombre" ItemStyle-Width="150px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("nombre") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("nombre") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cantidad de Salas" ItemStyle-Width="100px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("cant_salas") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCantSalas" runat="server" Text='<%# Bind("cant_salas") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dirección" ItemStyle-Width="200px">
                                <ItemTemplate><span style="font-size: 14px;"><%# Eval("direccion") %></span></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDireccion" runat="server" Text='<%# Bind("direccion") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Imagen" ItemStyle-Width="200px">
    <ItemTemplate>
        <asp:Image ID="imgCine" runat="server" ImageUrl='<%# "~/recursos/" + Eval("enlace_imagen") %>' Width="100px" Height="100px" />
    </ItemTemplate>
</asp:TemplateField>

                            <asp:TemplateField HeaderText="ID Ubigeo" ItemStyle-Width="100px">
                                <ItemTemplate><%# Eval("id_ubigeo") %></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="200px">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-warning btn-sm">Editar</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("id_cine") %>' CssClass="btn btn-danger btn-sm" OnClientClick="return confirmDelete();">Eliminar</asp:LinkButton>
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
                        <h3 class="card-title"><asp:Label ID="lblTitulo" runat="server" Text="Agregar/Editar Cine"></asp:Label></h3>
                        <div class="form-group">
                            <asp:Label ID="lblNombreCine" runat="server" Text="Nombre Cine:" CssClass="form-label" />
                            <asp:TextBox ID="txtNombreCine" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblCantSalas" runat="server" Text="Cantidad de Salas:" CssClass="form-label" />
                            <asp:TextBox ID="txtCantSalas" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblDireccion" runat="server" Text="Dirección:" CssClass="form-label" />
                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblImagen" runat="server" Text="Imagen:" CssClass="form-label" />
                            <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control" onchange="previewImage(event)"/>
                        </div>

                        <!-- Aquí se agregará la vista previa de la imagen seleccionada -->
<div class="form-group">
    <asp:Image ID="imgPreview" runat="server" Width="100px" Height="100px" Style="display:none;" />
</div>

<div class="form-group">
    <asp:Label ID="lblDepartamento" runat="server" Text="Departamento:" CssClass="form-label" />
    <asp:UpdatePanel ID="upDepartamento" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" CssClass="form-control" />
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div class="form-group">
    <asp:Label ID="lblProvincia" runat="server" Text="Provincia:" CssClass="form-label" />
    <asp:UpdatePanel ID="upProvincia" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:DropDownList ID="ddlProvincia" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProvincia_SelectedIndexChanged" CssClass="form-control" />
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div class="form-group">
    <asp:Label ID="lblDistrito" runat="server" Text="Distrito:" CssClass="form-label" />
    <asp:UpdatePanel ID="upDistrito" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:DropDownList ID="ddlDistrito" runat="server" CssClass="form-control" />
        </ContentTemplate>
    </asp:UpdatePanel>
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

        function previewImage(event) {
            var file = event.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var imgPreview = document.getElementById('<%= imgPreview.ClientID %>');
                     imgPreview.src = e.target.result;
                     imgPreview.style.display = "block";
                 };
                 reader.readAsDataURL(file);
             }
         }
    </script>

</asp:Content>
