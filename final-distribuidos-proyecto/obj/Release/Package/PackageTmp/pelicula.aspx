<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="pelicula.aspx.vb" Inherits="final_distribuidos_proyecto.pelicula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--angelo--%>
    <form runat="server" enctype="multipart/form-data">
        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addPeliculaModal">
            Agregar Nueva Película
        </button>


        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanelGrid" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:GridView ID="gvPelicula" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
                    <Columns>
                        <asp:TemplateField HeaderText="ID" ItemStyle-Width="50px">
                            <ItemTemplate>
                                <%# Eval("id_pelicula") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Nombre Película" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <%# Eval("nombre_pelicula") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Estreno" ItemStyle-Width="100px">
                            <ItemTemplate>
                                <%# Eval("estreno") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Duración" ItemStyle-Width="100px">
                            <ItemTemplate>
                                <%# Eval("duracion") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Clasificación Edad" ItemStyle-Width="100px">
                            <ItemTemplate>
                                <%# Eval("clasificacion_edad") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sinopsis" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <%# Eval("sinopsis") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Poster" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Image ID="imgPoster" runat="server" ImageUrl='<%# "~/image_pelicula/" + Eval("poster") %>' Width="100px" Height="150px" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <!-- Botón "Ver" que lleva todos los datos en atributos data-* -->
                                <button type="button" class="btn btn-info btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#verModal"
                                    data-id="<%# Eval("id_pelicula") %>"
                                    data-nombre="<%# Eval("nombre_pelicula") %>"
                                    data-estreno="<%# Eval("estreno") %>"
                                    data-duracion="<%# Eval("duracion") %>"
                                    data-clasificacion="<%# Eval("clasificacion_edad") %>"
                                    data-sinopsis="<%# Eval("sinopsis") %>"
                                    data-poster="<%# Eval("poster") %>"
                                    data-vigencia="<%# Convert.ToBoolean(Eval("vigencia")) %>">
                                    <i class="bi bi-eye"></i>Ver
                                </button>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="modal fade" id="verModal" tabindex="-1" aria-labelledby="verModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="verModalLabel">Detalles de la Película</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>ID</th>
                                <td id="modalId"></td>
                            </tr>
                            <tr>
                                <th>Nombre Película</th>
                                <td id="modalNombre"></td>
                            </tr>
                            <tr>
                                <th>Estreno</th>
                                <td id="modalEstreno"></td>
                            </tr>
                            <tr>
                                <th>Duración</th>
                                <td id="modalDuracion"></td>
                            </tr>
                            <tr>
                                <th>Clasificación Edad</th>
                                <td id="modalClasificacion"></td>
                            </tr>
                            <tr>
                                <th>Sinopsis</th>
                                <td id="modalSinopsis"></td>
                            </tr>
                            <tr>
                                <th>Poster</th>
                                <td>
                                    <img id="modalPoster" src="" width="100" height="150"></td>
                            </tr>
                            <tr>
                                <th>Vigencia</th>
                                <td>
                                    <input type="checkbox" id="modalVigencia" disabled></td>
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


         
        <div class="modal fade" id="addPeliculaModal" tabindex="-1" aria-labelledby="addPeliculaModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addPeliculaModalLabel">Agregar Nueva Película</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <!-- Fila para dos columnas -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nombrePelicula" class="form-label">Nombre de la Película</label>
                                <asp:TextBox ID="txtNombrePelicula" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="estreno" class="form-label">Estreno</label>
                                <div class="form-check">
                                    <asp:CheckBox ID="chkEstreno" runat="server" CssClass="form-check-input" />
                                    <span class="form-check-label">Estreno</span>
                                </div>
                            </div>
                        </div>

                        <!-- Siguiente fila para dos columnas -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="duracion" class="form-label">Duración</label>
                                <asp:TextBox ID="txtDuracion" runat="server" CssClass="form-control" TextMode="Number" required="required"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="clasificacionEdad" class="form-label">Clasificación de Edad</label>
                                <asp:TextBox ID="txtClasificacionEdad" runat="server" CssClass="form-control" required="required"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Fila siguiente para dos columnas -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="sinopsis" class="form-label">Sinopsis</label>
                                <asp:TextBox ID="txtSinopsis" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" required="required"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="filePoster" class="form-label">Poster (Imagen)</label>
                                <asp:FileUpload ID="filePoster" runat="server" CssClass="form-control" />
                            </div>
                        </div>

                        <!-- Siguiente fila para dos columnas -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="vigencia" class="form-label">Vigencia</label>
                                <div class="form-check">
                                    <asp:CheckBox ID="chkVigencia" runat="server" CssClass="form-check-input" />
                                    <span class="form-check-label">Vigencia</span>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="ddlDirectores" class="form-label">Director</label>
                                <asp:DropDownList ID="ddlDirectores" runat="server" CssClass="form-select" required="required"></asp:DropDownList>
                            </div>
                        </div>

                        <!-- Última fila para dos columnas -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="ddlGeneros" class="form-label">Género</label>
                                <asp:DropDownList ID="ddlGeneros" runat="server" CssClass="form-select" required="required"></asp:DropDownList>
                            </div>
                            <div class="col-md-6 mb-3">
                                <!-- Campo vacío para alineación visual -->
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="GuardarPelicula" />
                    </div>
                </div>
            </div>
        </div>

        </div>




    </form>

    <script type="text/javascript">
        var verModal = document.getElementById('verModal');
        verModal.addEventListener('show.bs.modal', function (event) {
            // Botón que activó el modal
            var button = event.relatedTarget;

            // Obtener datos de los atributos data-* del botón
            var id = button.getAttribute('data-id');
            var nombre = button.getAttribute('data-nombre');
            var estreno = button.getAttribute('data-estreno');
            var duracion = button.getAttribute('data-duracion');
            var clasificacion = button.getAttribute('data-clasificacion');
            var sinopsis = button.getAttribute('data-sinopsis');
            var poster = button.getAttribute('data-poster');
            var vigencia = button.getAttribute('data-vigencia') === 'true';

            // Actualizar el contenido del modal con los datos
            document.getElementById('modalId').textContent = id;
            document.getElementById('modalNombre').textContent = nombre;
            document.getElementById('modalEstreno').textContent = estreno;
            document.getElementById('modalDuracion').textContent = duracion;
            document.getElementById('modalClasificacion').textContent = clasificacion;
            document.getElementById('modalSinopsis').textContent = sinopsis;

            // Construir la URL completa de la imagen
            var imageUrl = location.origin + "/image_pelicula/" + poster;
            document.getElementById('modalPoster').src = imageUrl;

            document.getElementById('modalVigencia').checked = vigencia;
        });

    </script>

</asp:Content>
