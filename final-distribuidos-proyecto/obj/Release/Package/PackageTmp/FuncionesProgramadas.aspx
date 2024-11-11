<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="FuncionesProgramadas.aspx.vb" Inherits="final_distribuidos_proyecto.FuncionesProgramadas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Funciones Programadas
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">

        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addFunctionModal">
            Agregar Nueva Función
        </button>



        <asp:GridView ID="gvFuncionesProgramadas" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
            <Columns>
                <asp:TemplateField HeaderText="Nombre Película" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <%# Eval("NOMBRE PELICULA") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Nombre Idioma" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <%# Eval("NOMBRE IDIOMA") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Nombre Formato" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <%# Eval("NOMBRE DEL FORMATO") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Fecha de la Función" ItemStyle-Width="120px">
                    <ItemTemplate>
                        <%# Eval("FECHA DE LA FUNCION") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Hora de Inicio" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <%# Eval("HORA DE INICIO") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Hora de Fin" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <%# Eval("HORA DE FIN") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Monto de la Película" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <%# Eval("MONTO DE LA PELICULA") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Nombre de la Sala" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <%# Eval("NOMBRE DE LA SALA") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Nombre del Cine" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <%# Eval("NOMBRE DEL CINE") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Póster" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Image ID="imgPoster" runat="server"
                            ImageUrl='<%# "~/image_pelicula/" + Eval("poster") %>'
                            Width="100px" Height="150px"
                            AlternateText="Póster de Película" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Ver">
                    <ItemTemplate>
                        <button type="button" class="btn btn-info btn-sm"
                            data-bs-toggle="modal" data-bs-target="#verDetalleModal"
                            data-pelicula="<%# Eval("NOMBRE PELICULA") %>"
                            data-idioma="<%# Eval("NOMBRE IDIOMA") %>"
                            data-formato="<%# Eval("NOMBRE DEL FORMATO") %>"
                            data-fecha="<%# Eval("FECHA DE LA FUNCION") %>"
                            data-inicio="<%# Eval("HORA DE INICIO") %>"
                            data-fin="<%# Eval("HORA DE FIN") %>"
                            data-monto="<%# Eval("MONTO DE LA PELICULA") %>"
                            data-sala="<%# Eval("NOMBRE DE LA SALA") %>"
                            data-cine="<%# Eval("NOMBRE DEL CINE") %>"
                            data-poster="<%# "/image_pelicula/" + Eval("poster") %>">
                            Ver
               
                        </button>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>




        <div class="modal fade" id="addFunctionModal" tabindex="-1" aria-labelledby="addFunctionModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addFunctionModalLabel">Agregar Nueva Función Programada</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="fechaFuncion" class="form-label">Fecha de la Función</label>
                                    <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="horaInicio" class="form-label">Hora de Inicio</label>
                                    <asp:TextBox ID="txtHoraInicio" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="horaFin" class="form-label">Hora de Fin</label>
                                    <asp:TextBox ID="txtHoraFin" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                </div>
                                <div class="mb-3">
                                    <label for="monto" class="form-label">Monto</label>
                                    <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="formato" class="form-label">Formato</label>
                                    <asp:DropDownList ID="ddlFormato" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                </div>
                                <div class="mb-3">
                                    <label for="idioma" class="form-label">Idioma</label>
                                    <asp:DropDownList ID="ddlIdioma" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                </div>
                                <div class="mb-3">
                                    <label for="pelicula" class="form-label">Película</label>
                                    <asp:DropDownList ID="ddlPelicula" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                </div>
                                <div class="mb-3">
                                    <label for="sala" class="form-label">Sala</label>
                                    <asp:DropDownList ID="ddlSala" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                </div>
                                <div class="mb-3">
                                    <label for="cine" class="form-label">Cine</label>
                                    <asp:DropDownList ID="ddlCine" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnGuardarFuncion" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardarFuncion_Click" />
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>




        <div class="modal fade" id="verDetalleModal" tabindex="-1" aria-labelledby="verDetalleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="verDetalleModalLabel"><i class="bi bi-info-circle-fill"></i> Detalles de la Función Programada</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- Columna para la Imagen -->
                    <div class="col-md-5 text-center">
                        <img id="detallePoster" src="" alt="Póster de Película" class="img-fluid rounded shadow-sm mb-3" style="width: 100%; max-width: 300px; height: auto;" />
                    </div>
                    <!-- Columna para los Detalles -->
                    <div class="col-md-7">
                        <p><i class="bi bi-film me-2"></i><strong>Película:</strong> <span id="detallePelicula"></span></p>
                        <p><i class="bi bi-translate me-2"></i><strong>Idioma:</strong> <span id="detalleIdioma"></span></p>
                        <p><i class="bi bi-aspect-ratio me-2"></i><strong>Formato:</strong> <span id="detalleFormato"></span></p>
                        <p><i class="bi bi-calendar3 me-2"></i><strong>Fecha de la Función:</strong> <span id="detalleFecha"></span></p>
                        <p><i class="bi bi-clock me-2"></i><strong>Hora de Inicio:</strong> <span id="detalleInicio"></span></p>
                        <p><i class="bi bi-clock-history me-2"></i><strong>Hora de Fin:</strong> <span id="detalleFin"></span></p>
                        <p><i class="bi bi-currency-dollar me-2"></i><strong>Monto:</strong> <span id="detalleMonto"></span></p>
                        <p><i class="bi bi-door-open me-2"></i><strong>Sala:</strong> <span id="detalleSala"></span></p>
                        <p><i class="bi bi-building me-2"></i><strong>Cine:</strong> <span id="detalleCine"></span></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><i class="bi bi-x-circle"></i> Cerrar</button>
            </div>
        </div>
    </div>
</div>





    </form>


    <script type="text/javascript">
        // Escucha el evento de mostrar el modal
        var verDetalleModal = document.getElementById('verDetalleModal');
        verDetalleModal.addEventListener('show.bs.modal', function (event) {
            // Botón que activó el modal
            var button = event.relatedTarget;

            // Extrae información de los atributos data-* del botón
            var pelicula = button.getAttribute('data-pelicula');
            var idioma = button.getAttribute('data-idioma');
            var formato = button.getAttribute('data-formato');
            var fecha = button.getAttribute('data-fecha');
            var inicio = button.getAttribute('data-inicio');
            var fin = button.getAttribute('data-fin');
            var monto = button.getAttribute('data-monto');
            var sala = button.getAttribute('data-sala');
            var cine = button.getAttribute('data-cine');
            var poster = button.getAttribute('data-poster'); // Obtener la URL del póster

            // Actualiza el contenido del modal con los datos
            document.getElementById('detallePelicula').textContent = pelicula;
            document.getElementById('detalleIdioma').textContent = idioma;
            document.getElementById('detalleFormato').textContent = formato;
            document.getElementById('detalleFecha').textContent = fecha;
            document.getElementById('detalleInicio').textContent = inicio;
            document.getElementById('detalleFin').textContent = fin;
            document.getElementById('detalleMonto').textContent = monto;
            document.getElementById('detalleSala').textContent = sala;
            document.getElementById('detalleCine').textContent = cine;
            document.getElementById('detallePoster').src = poster; // Establecer la imagen del póster
        });

    </script>
</asp:Content>
