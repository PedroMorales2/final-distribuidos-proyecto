<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="combodulce.aspx.vb" Inherits="final_distribuidos_proyecto.combodulce" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Combo dulce
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-4 text-center">
        <h2>Gestión tipo dulce</h2>
    </div>

    <form id="form1" runat="server">
        <div class="container" style="width: 100vw;">
            <div class="row">
                <!-- Primera mitad: Formulario -->
                <div class="col-5">
                    <div class="row">
                        <!-- Columna izquierda del formulario -->
                        <div class="col-6">
                            <div class="mb-3 d-none">
                                <asp:Label ID="lblID" runat="server" Text="ID:" AssociatedControlID="txtID" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtID" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <asp:Label ID="lblNombre" runat="server" Text="Nombre:" AssociatedControlID="txtNombre" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <asp:Label ID="lblTotal" runat="server" Text="Precio" AssociatedControlID="txtTotal" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                            </div>
                            <div class="mt-5">
                                <asp:Label ID="lblEstado" runat="server" Text="Activo:" AssociatedControlID="chkActivo" CssClass="form-label"></asp:Label>
                                <asp:CheckBox ID="chkActivo" runat="server" CssClass="form-check-input" />
                            </div>
                        </div>
                        <!-- Columna derecha del formulario -->
                        <div class="col-5">
                            <div class="mb-3">
                                <asp:Label ID="lblDetalle" runat="server" Text="Detalle:" AssociatedControlID="txtDetalle" CssClass="form-label"></asp:Label>
                                <asp:TextBox TextMode="MultiLine" ID="txtDetalle" runat="server" CssClass="form-control" Rows="1"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <asp:Label ID="lblImagen" runat="server" Text="Imagen:" AssociatedControlID="fileImagen" CssClass="form-label"></asp:Label>
                                <asp:FileUpload Accept="image/*" ID="fileImagen" runat="server" CssClass="form-control" onchange="mostrar_imagen()" />
                                <br />
                                <img id="imagen" src="" alt="Imagen de referencia" class="img-fluid mt-2" />
                            </div>
                        </div>
                        <div class="col-6">
                        </div>

                        <div>
                            <button type="button" id="btn1" class="btn btn-primary" onclick="agregar()">Nuevo</button>
                        </div>
                    </div>
                    <!-- Botón de agregar debajo del formulario -->
                    <div class="text-center mt-3">
                        <asp:Button Text="Agregar" ID="btn2" runat="server" class="btn btn-primary d-none" CausesValidation="true" OnClick="btnGuardar_Click" />
                        <asp:Button Text="Agregar" ID="Button1" runat="server" class="btn btn-primary d-none" CausesValidation="false" OnClick="btnBaja_Click" />

                    </div>
                </div>

                <!-- Segunda mitad: Primer acordeón para la tabla -->
                <div class="col-6">
                    <div class="accordion" id="accordionExample1">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    Tabla de dulces
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse " aria-labelledby="headingOne" data-bs-parent="#accordionExample1">
                                <div class="accordion-body">
                                    <!-- Tabla de combos -->
                                    <div class="table-responsive" style="height: 300px; overflow-y: auto;">
                                        <table class="table table-hover table-bordered">
                                            <thead class="table-primary text-center">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Dulce</th>
                                                    <th>Tipo</th>
                                                    <th>Presentación</th>
                                                    <th>Presentación</th>
                                                    <th>Unidades</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:PlaceHolder ID="phCombodulce" runat="server"></asp:PlaceHolder>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Segunda fila: Segundo acordeón para otra tabla -->
                <div class="col-11 mt-4">
                    <div class="accordion" id="accordionExample3">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingTree">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTree" aria-expanded="false" aria-controls="collapseTree">
                                    Detalle Combo
                                </button>
                            </h2>
                            <div id="collapseTree" class="accordion-collapse collapse" aria-labelledby="headingTree" data-bs-parent="#accordionExample3" style="height: 300px; overflow-y: auto;">
                                <div class="accordion-body">
                                    <div class="table-responsive" style="height: 300px; overflow-y: auto;">
                                        <table class="table table-hover table-bordered text-center">
                                            <thead class="table-primary">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Dulce</th>
                                                    <th>Tipo</th>
                                                    <th>Presentación</th>
                                                    <th>Unidades</th>
                                                    <th id="one" class="d-none">Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbb">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Segunda fila: Segundo acordeón para otra tabla -->
                <div class="col-11 mt-4">
                    <div class="accordion" id="accordionExample2">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="headingTwo">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                    Combos
                                </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse show" aria-labelledby="headingTwo" data-bs-parent="#accordionExample2">
                                <div class="accordion-body">
                                    <div class="table-responsive" style="height: 300px; overflow-y: auto;">
                                        <table class="table table-hover table-bordered text-center">
                                            <thead class="table-primary">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Nombre</th>
                                                    <th>Imagen</th>
                                                    <th>Detalle</th>
                                                    <th>Estado</th>
                                                    <th>Total</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:PlaceHolder ID="phCombo" runat="server"></asp:PlaceHolder>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        let carrito = []
        var id = document.getElementById('ContentPlaceHolder1_txtID');
        var nombre = document.getElementById('ContentPlaceHolder1_txtNombre');
        var detalle = document.getElementById('ContentPlaceHolder1_txtDetalle');
        var precio = document.getElementById('ContentPlaceHolder1_txtTotal');
        var file = document.getElementById('ContentPlaceHolder1_fileImagen');
        var imagen = document.getElementById('imagen');
        var st = document.getElementById('ContentPlaceHolder1_chkActivo');
        var btn1 = document.getElementById('btn1');
        var btn2 = document.getElementById('ContentPlaceHolder1_btn2');
        limpiar();
        function ver_combo(ids, combo, total, detalles, estado, imagen1) {
            limpiar();
            id.value = ids;
            id.disabled = true;

            nombre.value = combo;
            nombre.disabled = true;

            detalle.value = detalles;
            detalle.disabled = true;

            precio.value = total;
            precio.disabled = true;

            file.classList.add("d-none");

            if (estado == "Activo") {
                st.checked = true;
            }
            st.disabled = true;
            imagen.src = `/Uploads/${imagen1}`;

            fetch('combodulce.aspx/listar_dulces_por_combo', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ idCombo: ids })
            })
                .then(response => response.json())
                .then(data => {
                    // Obtener el cuerpo de la tabla donde se agregarán las filas
                    const tbody = document.getElementById('tbb');


                    // Asegurarse de que 'data.d' sea un array antes de iterar
                    const dulces = JSON.parse(data.d);  // Convertir el string JSON en un objeto JS

                    // Limpiar el contenido del tbody antes de agregar nuevas filas
                    tbody.innerHTML = "";

                    // Iterar sobre cada dulce y crear una fila
                    dulces.forEach(dulce => {
                        const row = document.createElement('tr');

                        // Crear y agregar cada celda a la fila
                        row.innerHTML = `
                    <td>${dulce.id}</td>
                    <td>${dulce.nombre}</td>
                    <td>${dulce.tipo}</td>
                    <td>${dulce.presentacion}</td>
                    <td>${dulce.unidades}</td>
                    `;

                        // Agregar la fila completa al tbody
                        tbody.appendChild(row);
                    });
                })
                .catch(error => {
                    console.log("Error al obtener los dulces:", error);
                });

        }

        function limpiar() {
            file.classList.remove("d-none");
            id.value = "";
            id.disabled = false;
            nombre.value = "";
            nombre.disabled = false;
            detalle.value = "";
            detalle.disabled = false;
            precio.value = "";
            precio.disabled = false;
            file.classList.remove("d-none");
            file.text
            imagen.src = "";
            st.checked = false;
            st.disabled = false;
            btn2.classList.add('d-none');
            btn1.classList.remove('d-none');
            st.checked = false;
            const inputs = document.querySelectorAll('input[type="number"]');
            document.getElementById('tbb').textContent = "";
            carrito = [];
            inputs.forEach(input => {
                input.value = "";
            });
        }

        function agregar() {
            limpiar();
            btn2.classList.remove('d-none');
            btn1.classList.add('d-none');


        }


        function agregar_carrito(ids, combo, total, detalles, estado, imagen1) {
            var unidades = parseInt(document.getElementById(ids).value);

            // Verificar si las unidades están entre 1 y 3
            if (unidades >= 1 && unidades <= 3) {
                // Buscar si el producto ya existe en el carrito
                var productoExistente = carrito.find(function (producto) {
                    return producto.ids === ids;  // Comparar el ID del producto
                });

                if (productoExistente) {
                    // Si el producto ya existe, actualizar las unidades
                    productoExistente.unidades = unidades;
                } else {
                    // Si el producto no existe, agregar un nuevo producto
                    var producto = {
                        "ids": ids,
                        "combo": combo,
                        "total": total,
                        "detalles": detalles,
                        "estado": estado,
                        "imagen1": imagen1,
                        "unidades": unidades
                    };
                    carrito.push(producto);
                }

                // Almacenar el carrito en una cookie
                document.cookie = "carrito=" + JSON.stringify(carrito) + "; path=/; max-age=3600"; // max-age=3600 para 1 hora

                // Actualizar la tabla del carrito
                actualizarTabla();
            } else {
                alert("Selecciona unidades entre 1 y 3");
            }
        }


        function mostrar_imagen() {
            var fileInput = document.getElementById('<%= fileImagen.ClientID %>');  // Obtén el ID correcto del FileUpload
            var imgElement = document.getElementById('imagen');

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

        function actualizarTabla() {
            // Limpiar el contenido de la tabla antes de agregar nuevos datos
            var tbody = document.getElementById('tbb');
            tbody.innerHTML = ""; // Limpiar la tabla

            // Iterar sobre el carrito para agregar filas a la tabla
            carrito.forEach(function (producto) {
                var tr = document.createElement('tr');

                // Crear las celdas para cada campo del producto
                var tdId = document.createElement('td');
                tdId.textContent = producto.ids;
                tr.appendChild(tdId);

                var tdCombo = document.createElement('td');
                tdCombo.textContent = producto.combo;
                tr.appendChild(tdCombo);



                var tdDetalles = document.createElement('td');
                tdDetalles.textContent = producto.detalles;
                tr.appendChild(tdDetalles);

                var tdEstado = document.createElement('td');
                tdEstado.textContent = producto.estado;
                tr.appendChild(tdEstado);

                var tdUnidades = document.createElement('td');
                tdUnidades.textContent = producto.unidades;
                tr.appendChild(tdUnidades);

                // Agregar la fila a la tabla
                tbody.appendChild(tr);
            });
        }
        function activar(ids) {
            limpiar()
            id.value = ids

            var boton = document.getElementById('<%= Button1.ClientID %>');

            boton.value = "Activar";

            boton.click();
        }

        function darBaja(ids) {
            limpiar()
            id.value = ids

            var boton = document.getElementById('<%= Button1.ClientID %>');

            boton.value = "Dar Baja";

            boton.click();
        }

    </script>
</asp:Content>
