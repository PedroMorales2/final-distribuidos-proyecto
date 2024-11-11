<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="formatoPelicula.aspx.vb" Inherits="final_distribuidos_proyecto.formatoPelicula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--angelo--%>

    <form runat="server">
        <div class="container mt-4">
            <h2 class="text-center mb-4">Gestión de Formato Película</h2>
            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addFormatoModal">
                Agregar Nueva Película
            </button>

            <asp:GridView ID="gvFormatoPelicula" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                DataKeyNames="id_pelicula" OnRowCommand="gvFormatoPelicula_RowCommand">
                <Columns>

                    <asp:BoundField DataField="id_pelicula" HeaderText="ID Película" ItemStyle-Width="50px" ReadOnly="True" />


                    <asp:BoundField DataField="nombre_pelicula" HeaderText="Nombre Película" ItemStyle-Width="150px" />


                    <asp:BoundField DataField="nombre_idioma" HeaderText="Nombre Idioma" ItemStyle-Width="150px" />


                    <asp:BoundField DataField="nombre_formato" HeaderText="Nombre Formato" ItemStyle-Width="150px" />


                    <asp:BoundField DataField="nombre_pais" HeaderText="Nombre País" ItemStyle-Width="150px" />


                    <asp:TemplateField HeaderText="Póster" ItemStyle-Width="100px">
                        <ItemTemplate>
                            <img src='<%# ResolveUrl("~/image_pelicula/" & Eval("poster")) %>' alt="Póster de Película" style="width: 80px; height: auto;" />
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="200px">
                        <ItemTemplate>

                            <button type="button" class="btn btn-info btn-sm"
                                data-bs-toggle="modal" data-bs-target="#verFormatoModal"
                                data-id="<%# Eval("id_pelicula") %>"
                                data-nombre="<%# Eval("nombre_pelicula") %>"
                                data-idioma="<%# Eval("nombre_idioma") %>"
                                data-formato="<%# Eval("nombre_formato") %>"
                                data-pais="<%# Eval("nombre_pais") %>"
                                data-poster="<%# Eval("poster") %>"> <!-- Añadido el atributo data-poster -->
                                <i class="bi bi-eye"></i>Ver
                            </button>



                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Eliminar" 
                                CommandArgument='<%# Convert.ToString(Eval("id_pelicula")) + "," + Convert.ToString(Eval("id_idioma")) + "," + Convert.ToString(Eval("id_formato")) + "," + Convert.ToString(Eval("id_pais")) %>' 
                                CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirm('¿Está seguro de que desea eliminar este formato?');">
                                <i class="bi bi-trash"></i> Eliminar
                            </asp:LinkButton>


                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>



        <div class="modal fade" id="addFormatoModal" tabindex="-1" aria-labelledby="addFormatoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Detalles del Formato de Película</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>ID Película</th>
                                <td id="modalIdPelicula"></td>
                            </tr>
                            <tr>
                                <th>Nombre Película</th>
                                <td>
                                    <asp:DropDownList ID="ddlModalNombrePelicula" runat="server" CssClass="form-select"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>Idioma</th>
                                <td>
                                    <asp:DropDownList ID="ddlModalIdioma" runat="server" CssClass="form-select"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>Formato</th>
                                <td>
                                    <asp:DropDownList ID="ddlModalFormato" runat="server" CssClass="form-select"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <th>País</th>
                                <td>
                                    <asp:DropDownList ID="ddlModalPais" runat="server" CssClass="form-select"></asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnGuardarFormato" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardarFormato_Click" />
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>




    </form>
    <!-- Modal para Ver Formato de Película -->
    <div class="modal fade" id="verFormatoModal" tabindex="-1" aria-labelledby="verFormatoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="verFormatoModalLabel">Detalles del Formato de Película</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>ID Película</th>
                            <td id="detalleIdPelicula"></td>
                        </tr>
                        <tr>
                            <th>Nombre Película</th>
                            <td id="detalleNombrePelicula"></td>
                        </tr>
                        <tr>
                            <th>Idioma</th>
                            <td id="detalleIdioma"></td>
                        </tr>
                        <tr>
                            <th>Formato</th>
                            <td id="detalleFormato"></td>
                        </tr>
                        <tr>
                            <th>País</th>
                            <td id="detallePais"></td>
                        </tr>
                        <tr>
                            <th>Póster</th>
                            <td>
                                <img id="detallePoster" src="" alt="Póster de Película" style="width: 150px; height: auto;" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var verFormatoModal = document.getElementById('verFormatoModal');
        verFormatoModal.addEventListener('show.bs.modal', function (event) {
            // Botón que activó el modal
            var button = event.relatedTarget;

            // Obtener datos de los atributos data-* del botón
            var id = button.getAttribute('data-id');
            var nombre = button.getAttribute('data-nombre');
            var idioma = button.getAttribute('data-idioma');
            var formato = button.getAttribute('data-formato');
            var pais = button.getAttribute('data-pais');
            var poster = button.getAttribute('data-poster'); // Obtener el nombre de la imagen del póster

            // Actualizar el contenido del modal con los datos
            document.getElementById('detalleIdPelicula').textContent = id;
            document.getElementById('detalleNombrePelicula').textContent = nombre;
            document.getElementById('detalleIdioma').textContent = idioma;
            document.getElementById('detalleFormato').textContent = formato;
            document.getElementById('detallePais').textContent = pais;
            document.getElementById('detallePoster').src = '/image_pelicula/' + poster; // Ruta de la imagen
        });
    </script>

</asp:Content>
