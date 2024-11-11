<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="dulceria.aspx.vb" Inherits="final_distribuidos_proyecto.dulceria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Dulceria
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server" > 
    <!------ Boton de agregar ------>
    <div class="mb-3">
        <button type="button" class="btn btn-primary" onclick="agregar()">
            Agregar
        </button>
    </div>
    <div class ="mt-4 text-center " style="width: 75vw;">
        <div class="row">
         <div class="modal fade" id="DulceModal" tabindex="-1" aria-labelledby="DulceModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DulceModalLabel">Información de Tipo de Dulce</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                         <!-- Fila para Nombre y Estado -->
                             <div class="row text-start">
                                 <div class="col-6 mb-3 ">
                                    <asp:TextBox ID="txtiddulce" runat="server" CssClass="form-control d-none" ></asp:TextBox>
                                    <asp:TextBox ID="nombreimg" runat="server" CssClass="form-control d-none" ></asp:TextBox>

                                     <label for="nombredulce" class="form-label">Nombre:</label>
                                     <asp:TextBox ID="nombredulce" runat="server" CssClass="form-control" required></asp:TextBox>
                                 </div>
                                 <div class="col-6 mb-3" id="block1">
                                     <label for="precio" class="form-label">Precio:</label>
                                     <asp:TextBox  type="number" ID="precio" runat="server" CssClass="form-control" required ></asp:TextBox>
                                 </div>
                             </div>
                            <div class="row  text-start" id="block2">
                               <div class="col-6 mb-3">
                                   <label for="tipodulce" class="form-label">Tipo dulce:</label>
                
                                   <asp:DropDownList runat="server" ID="tipodulce" class="form-select" name="tipodulce" required >
                                   </asp:DropDownList>
                               </div>
                               <div class="col-6 mb-3">
                                   <label for="presentacion" class="form-label">Presentación:</label>
                                   <asp:DropDownList runat="server" ID="presentacion" class="form-select" name="presentacion" required >
                                   </asp:DropDownList>

                               </div>
                           </div>
                            <div class="row  text-start" id="block3">
                               <div class="col-6 mb-3">
                                   <label for="st" class="form-label">Estado:</label>
                                   <br />
                                    <asp:CheckBox name="estado" ID="estado" runat="server" />
                                   <label for="estado" class="form-label">(Activo)</label>
                               </div>
                             </div>
                             <div class="row  text-start" id="block4">
                               <div class="col-12 mb-3 d-mx">
                                    <label for="comboImagen" class="form-label">Imagen</label>
                                   <br />
                                    <asp:FileUpload ID="fileInput" name="fileInput" runat="server" CssClass="form-control" Accept="image/*" onchange="mostrar_imagen()" required />
                                   <img id="src_img" style="height: 180px;" class="mt-3" />

              
                               </div>
                             </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <asp:Button type="button"  ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
                    </div>
                </div>
            </div>
        </div>  
        
    </div>
</div>
    <!-- Tabla para mostrar los dulces -->
        <div class="container mt-4" >
            <div class="row">
                <div class="col-10">
                    <div class="table-responsive">
                        <!-- Tabla con la estructura estándar de Bootstrap -->
                        <table class="table table-striped">
                            <thead>
                                <tr class="text-center table-primary">
                                    <th>ID</th>
                                    <th>Dulce</th>
                                    <th>Tipo</th>
                                    <th>Presentación</th>
                                    <th>Estado</th>
                                    <th>Precio</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:PlaceHolder ID="phDulces" runat="server"></asp:PlaceHolder>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    
</form>

    <script>
        function agregar() {
            limpiarcampos();
            var modal = new bootstrap.Modal(document.getElementById('DulceModal'));
            var boton = document.getElementById('<%= btnGuardar.ClientID %>'); // Accede al botón usando ClientID
            boton.setAttribute('value', 'Guardar');
            boton.classList.remove('btn-warning', 'btn-danger');
            boton.classList.add('btn-primary');
            modal.show();
        }
        function VerDulce(id, dulce, precio, tipo, estado, imagen, presentacion) {
            limpiarcampos();

            var modal = new bootstrap.Modal(document.getElementById('DulceModal'));
            var boton = document.getElementById('<%= btnGuardar.ClientID %>'); // Accede al botón usando ClientID
            document.getElementById('DulceModalLabel').textContent = "Dulce";
            boton.classList.add('d-none');
            document.getElementById('ContentPlaceHolder1_txtiddulce').value = id;
            document.getElementById('ContentPlaceHolder1_nombredulce').value = dulce;
            document.getElementById('ContentPlaceHolder1_precio').value = precio;
            document.getElementById('ContentPlaceHolder1_tipodulce').value = tipo;
            document.getElementById('ContentPlaceHolder1_presentacion').value = presentacion;
            if (estado == "Activo") {
                document.getElementById('ContentPlaceHolder1_estado').checked = true;
            }
            document.getElementById('ContentPlaceHolder1_fileInput').classList.add('d-none');
            document.getElementById('src_img').src = `/Uploads/${imagen}`;

            // Deshabilitar el campo de texto y ocultar el botón
            document.getElementById('ContentPlaceHolder1_nombredulce').disabled = true;
            document.getElementById('ContentPlaceHolder1_precio').disabled = true;
            document.getElementById('ContentPlaceHolder1_tipodulce').disabled = true;
            document.getElementById('ContentPlaceHolder1_presentacion').disabled = true;
            document.getElementById('ContentPlaceHolder1_estado').disabled = true;

            modal.show();
        }

        function eliminarDulce(id, dulce, precio, tipo, estado, imagen, presentacion) {
            var modal = new bootstrap.Modal(document.getElementById('DulceModal'));
            limpiarcampos();
            ocultar();
            document.getElementById('ContentPlaceHolder1_nombredulce').value = dulce;
            document.getElementById('ContentPlaceHolder1_nombredulce').disabled = true;
            document.getElementById('ContentPlaceHolder1_txtiddulce').value = id;
            document.getElementById('ContentPlaceHolder1_precio').value = precio;
            document.getElementById('ContentPlaceHolder1_tipodulce').value = tipo;
            document.getElementById('ContentPlaceHolder1_presentacion').value = presentacion;
            if (estado == "Activo") {
                document.getElementById('ContentPlaceHolder1_estado').checked = true;
            }
            document.getElementById('ContentPlaceHolder1_fileInput').classList.add('d-none');
            document.getElementById('src_img').src = `/Uploads/${imagen}`;
            document.getElementById('ContentPlaceHolder1_fileInput').removeAttribute('required');


            document.getElementById('ContentPlaceHolder1_txtiddulce').value = id;
            document.getElementById('DulceModalLabel').textContent = "¿Deseas eliminar este tipo de dulce?";

            var boton = document.getElementById('<%= btnGuardar.ClientID %>'); // Accede al botón usando ClientID
            boton.setAttribute('value', 'Eliminar');
            boton.classList.remove('btn-primary');
            boton.classList.add('btn-danger'); 
            modal.show();
        }

        function ocultar() {
            document.getElementById('block1').classList.add('d-none');
            document.getElementById('block2').classList.add('d-none');
            document.getElementById('block3').classList.add('d-none');
            document.getElementById('block4').classList.add('d-none');
        }
        function mostrar(){
            document.getElementById('block1').classList.remove('d-none');
            document.getElementById('block2').classList.remove('d-none');
            document.getElementById('block3').classList.remove('d-none');
            document.getElementById('block4').classList.remove('d-none');
        }
        function dar_baja(id, dulce, precio, tipo, estado, imagen, presentacion) {
            limpiarcampos();
            var modal = new bootstrap.Modal(document.getElementById('DulceModal'));
            var boton = document.getElementById('<%= btnGuardar.ClientID %>'); // Accede al botón usando ClientID
            document.getElementById('DulceModalLabel').textContent = "Dulce";
            boton.classList.add('d-none');
            document.getElementById('ContentPlaceHolder1_txtiddulce').value = id;
            document.getElementById('ContentPlaceHolder1_nombredulce').value = dulce;
            document.getElementById('ContentPlaceHolder1_precio').value = precio;
            document.getElementById('ContentPlaceHolder1_tipodulce').value = tipo;
            document.getElementById('ContentPlaceHolder1_presentacion').value = presentacion;
            if (estado == "Activo") {
                document.getElementById('ContentPlaceHolder1_estado').checked = true;
            }
            document.getElementById('ContentPlaceHolder1_fileInput').classList.add('d-none');
            document.getElementById('src_img').src = `/Uploads/${imagen}`;
            document.getElementById('ContentPlaceHolder1_fileInput').removeAttribute('required');

            boton.setAttribute('value', 'Baja');

            boton.click();
        }


        function EditarDulce(id, dulce, precio, tipo, estado, imagen, presentacion) {
            var modal = new bootstrap.Modal(document.getElementById('DulceModal'));
            limpiarcampos();
            document.getElementById('ContentPlaceHolder1_fileInput').removeAttribute('required');

            var boton = document.getElementById('<%= btnGuardar.ClientID %>');
            boton.setAttribute('value', 'Modificar');
            boton.classList.remove('btn-primary', 'btn-danger');
            boton.classList.add('btn-warning');
            document.getElementById('ContentPlaceHolder1_txtiddulce').value = id;
            document.getElementById('ContentPlaceHolder1_nombredulce').value = dulce;
            document.getElementById('ContentPlaceHolder1_precio').value = precio;



            document.getElementById('ContentPlaceHolder1_tipodulce').value = tipo;
            document.getElementById('ContentPlaceHolder1_presentacion').value = presentacion;
            document.getElementById('ContentPlaceHolder1_nombreimg').value = imagen;



            if (estado == "Activo") {
                document.getElementById('ContentPlaceHolder1_estado').checked = true;
            }
            document.getElementById('DulceModalLabel').textContent = "Modificar dulce";
            document.getElementById('src_img').src = `/Uploads/${imagen}`;


            modal.show();
        }


        function limpiarcampos() {
            mostrar();
            var boton = document.getElementById('<%= btnGuardar.ClientID %>');
            document.getElementById('ContentPlaceHolder1_fileInput').setAttribute('required','required');

            boton.classList.remove('d-none');
            document.getElementById('DulceModalLabel').textContent = "Agregar dulce";
            document.getElementById('ContentPlaceHolder1_fileInput').classList.remove('d-none');
            

            document.getElementById('<%= fileInput.ClientID %>').value = "";
            document.getElementById('ContentPlaceHolder1_nombredulce').disabled = false;
            document.getElementById('ContentPlaceHolder1_nombredulce').value = "";
            document.getElementById('ContentPlaceHolder1_nombreimg').value = "";
            document.getElementById('ContentPlaceHolder1_txtiddulce').value = "";



            document.getElementById('ContentPlaceHolder1_precio').disabled = false;
            document.getElementById('ContentPlaceHolder1_precio').value = "";

            document.getElementById('ContentPlaceHolder1_tipodulce').selectedIndex = -1;
            document.getElementById('ContentPlaceHolder1_tipodulce').disabled = false;

            document.getElementById('ContentPlaceHolder1_presentacion').selectedIndex = -1;
            document.getElementById('ContentPlaceHolder1_presentacion').disabled = false;


            document.getElementById('ContentPlaceHolder1_estado').disabled = false;
            document.getElementById('ContentPlaceHolder1_estado').checked = false;


            document.getElementById('src_img').src = "";
        }

        function mostrar_imagen() {
            var fileInput = document.getElementById('<%= fileInput.ClientID %>');  // Obtén el ID correcto del FileUpload
            var imgElement = document.getElementById('src_img');

            // Verifica si hay un archivo seleccionado
            if (fileInput.files && fileInput.files[0]) {
                var reader = new FileReader(); // Lee el archivo

                reader.onload = function (e) {
                    imgElement.classList.remove('d-none');  // Muestra la imagen
                    imgElement.src = e.target.result;       // Establece la imagen seleccionada
                };

                reader.readAsDataURL(fileInput.files[0]);  // Convierte la imagen en un formato adecuado para mostrarla
            }
        }

    </script>
</asp:Content>
