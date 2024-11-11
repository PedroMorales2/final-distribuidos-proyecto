<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="director.aspx.vb" Inherits="final_distribuidos_proyecto.director" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Director de Pelicula
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <%--angelo--%>
    <form runat="server">

        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addDirectorModal">
            Agregar Nuevo Director
        </button>



        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanelDirectores" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:GridView ID="gvDirectores" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
                    <Columns>
                        <asp:TemplateField HeaderText="ID Director">
                            <ItemTemplate>
                                <%# Eval("id_director") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nombre Completo">
                            <ItemTemplate>
                                <%# Eval("nombre completo") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="País">
                            <ItemTemplate>
                                <%# Eval("pais") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Biografía">
                            <ItemTemplate>
                                <%# Eval("biografia") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Premios">
                            <ItemTemplate>
                                <%# Eval("premios") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Vigencia">
                            <ItemTemplate>
                                <%# Eval("vigencia") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <button type="button" class="btn btn-info btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#verDirectorModal"
                                    data-id="<%# Eval("id_director") %>"
                                    data-nombre="<%# Eval("nombre completo") %>"
                                    data-pais="<%# Eval("pais") %>"
                                    data-biografia="<%# Eval("biografia") %>"
                                    data-premios="<%# Eval("premios") %>"
                                    data-vigencia="<%# Eval("vigencia") %>">
                                    Ver
               
                                </button>

                                <button type="button" class="btn btn-warning btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editDirectorModal"
                                    data-id="<%# Eval("id_director") %>"
                                    data-nombre="<%# Eval("nombre completo") %>"
                                    data-pais="<%# Eval("pais") %>"
                                    data-biografia="<%# Eval("biografia") %>"
                                    data-premios="<%# Eval("premios") %>"
                                    data-vigencia="<%# Eval("vigencia") %>">
                                    <i class="bi bi-pencil-square"></i>Editar
                               
                                </button>
                            </ItemTemplate>


                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>


        <!-- Modal para ver detalles del director -->
        <div class="modal fade" id="verDirectorModal" tabindex="-1" aria-labelledby="verDirectorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verDirectorModalLabel">Detalles del Director</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>ID Director</th>
                                <td id="modalIdDirector"></td>
                            </tr>
                            <tr>
                                <th>Nombre Completo</th>
                                <td id="modalNombreCompleto"></td>
                            </tr>
                            <tr>
                                <th>País</th>
                                <td id="modalPais"></td>
                            </tr>
                            <tr>
                                <th>Biografía</th>
                                <td id="modalBiografia"></td>
                            </tr>
                            <tr>
                                <th>Premios</th>
                                <td id="modalPremios"></td>
                            </tr>
                            <tr>
                                <th>Vigencia</th>
                                <td id="modalVigencia"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>


        <%--modal--%>


        <!-- Modal para agregar nuevo director -->
        <div class="modal fade" id="addDirectorModal" tabindex="-1" aria-labelledby="addDirectorModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addDirectorModalLabel">Agregar Nuevo Director</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nombreDirector" class="form-label">Nombre</label>
                                <asp:TextBox ID="txtNombreDirector" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="apellidosDirector" class="form-label">Apellidos</label>
                                <asp:TextBox ID="txtApellidosDirector" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="pais" class="form-label">País</label>
                                <asp:DropDownList ID="ddlPais" runat="server" CssClass="form-select" required="required">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="biografia" class="form-label">Biografía</label>
                                <asp:TextBox ID="txtBiografia" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" required="required"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="premios" class="form-label">Premios</label>
                                <asp:TextBox ID="txtPremios" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="vigencia" class="form-label">Vigencia</label>
                                <asp:CheckBox ID="chkVigencia" runat="server" CssClass="form-check-input" />
                                <span class="form-check-label">Activo</span>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnGuardarDirector" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="GuardarDirector" />
                    </div>
                </div>
            </div>
        </div>



        <%--modal edicion--%>


        <div class="modal fade" id="editDirectorModal" tabindex="-1" aria-labelledby="editDirectorModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editDirectorModalLabel">Editar Director</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Campo oculto para almacenar el ID del director -->
                        <asp:HiddenField ID="hiddenDirectorId" runat="server" />

                        <!-- Primera fila: Nombre y Apellidos -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtEditNombreDirector" class="form-label">Nombre</label>
                                <asp:TextBox ID="txtEditNombreDirector" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="txtEditApellidosDirector" class="form-label">Apellidos</label>
                                <asp:TextBox ID="txtEditApellidosDirector" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Segunda fila: País y Biografía -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="ddlEditPais" class="form-label">País</label>
                                <asp:DropDownList ID="ddlEditPais" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="txtEditBiografia" class="form-label">Biografía</label>
                                <asp:TextBox ID="txtEditBiografia" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Tercera fila: Premios y Vigencia -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="txtEditPremios" class="form-label">Premios</label>
                                <asp:TextBox ID="txtEditPremios" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="chkEditVigencia" class="form-label">Vigencia</label>
                                <div class="form-check">
                                    <asp:CheckBox ID="chkEditVigencia" runat="server" CssClass="form-check-input" />
                                    <label class="form-check-label" for="chkEditVigencia">Activo</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer del modal con el botón para guardar cambios -->
                    <div class="modal-footer">
                        <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" OnClick="ModificarDirector" />
                    </div>
                </div>
            </div>
        </div>




    </form>



    <script type="text/javascript">
        var verDirectorModal = document.getElementById('verDirectorModal');
        verDirectorModal.addEventListener('show.bs.modal', function (event) {
            // Botón que activó el modal
            var button = event.relatedTarget;

            // Obtener datos de los atributos data-* del botón
            var id = button.getAttribute('data-id');
            var nombre = button.getAttribute('data-nombre');
            var pais = button.getAttribute('data-pais');
            var biografia = button.getAttribute('data-biografia');
            var premios = button.getAttribute('data-premios');
            var vigencia = button.getAttribute('data-vigencia');

            // Actualizar el contenido del modal con los datos
            document.getElementById('modalIdDirector').textContent = id;
            document.getElementById('modalNombreCompleto').textContent = nombre;
            document.getElementById('modalPais').textContent = pais;
            document.getElementById('modalBiografia').textContent = biografia;
            document.getElementById('modalPremios').textContent = premios;
            document.getElementById('modalVigencia').textContent = vigencia;
        });



        var editDirectorModal = document.getElementById('editDirectorModal');
        editDirectorModal.addEventListener('show.bs.modal', function (event) {
            // Botón que activó el modal
            var button = event.relatedTarget;

            // Obtener datos de los atributos data-* del botón
            var id = button.getAttribute('data-id');
            var fullName = button.getAttribute('data-nombre'); // Nombre completo
            var idPais = button.getAttribute('data-pais');
            var biografia = button.getAttribute('data-biografia');
            var premios = button.getAttribute('data-premios');
            var estado = button.getAttribute('data-vigencia') === 'A';

            // Separar nombre y apellidos
            var nombre = '';
            var apellidos = '';
            if (fullName) {
                var nameParts = fullName.split(' ');
                nombre = nameParts[0]; // La primera palabra como nombre
                apellidos = nameParts.slice(1).join(' '); // El resto como apellidos
            }

            // Llenar los campos del modal
            document.getElementById('<%= hiddenDirectorId.ClientID %>').value = id;
    document.getElementById('<%= txtEditNombreDirector.ClientID %>').value = nombre;
    document.getElementById('<%= txtEditApellidosDirector.ClientID %>').value = apellidos;
    document.getElementById('<%= ddlEditPais.ClientID %>').value = idPais;
    document.getElementById('<%= txtEditBiografia.ClientID %>').value = biografia;
    document.getElementById('<%= txtEditPremios.ClientID %>').value = premios;
    document.getElementById('<%= chkEditVigencia.ClientID %>').checked = estado;
});






    </script>

</asp:Content>
