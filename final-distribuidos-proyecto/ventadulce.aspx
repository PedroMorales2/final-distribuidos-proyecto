<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/maestra-empresa.Master" CodeBehind="ventadulce.aspx.vb" Inherits="final_distribuidos_proyecto.ventadulce" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Venta de dulces
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .btn {
            border-radius: 4px !important;
            padding: .375rem .75rem !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-4 text-center">
        <h2>Venta dulce</h2>
    </div>
    <form id="form1" runat="server">
        <div class="container" style="width: 90vw;">
            <div class="row">
                <div class="col-5">
                    <div class="col-5">
                        <input type="text" id="buscar" class="form-control" placeholder="Ingrese el nombre de un producto" />
                    </div>
                    <div class="col-12 mt-3">
        <table class="table table-bordered">
            <thead id="tabla-encabezado">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Presentación</th>
                    <th>Precio</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody id="tabla_body">
                <asp:PlaceHolder ID="phCombodulce" runat="server"></asp:PlaceHolder>

            </tbody>
            <tfoot>
                <tr class="d-none" id="foot">
                    <td class="text-center" colspan="5">No hay dulces con esa busqueda....</td>
                    
                </tr>
            </tfoot>
        </table>
                    </div>
                </div>
                <div class="col-6 mt-5">
                    <div class="row">
                        <div class="col-12">
                            <table class="table table-bordered">
                             <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Presentación</th>
                                        <th>Precio</th>
                                        <th>Unidades</th>
                                    </tr>
                                </thead>
                                <tbody id="body_dulce">

                                </tbody>
                            </table>
                                <div class="mt-2 text-end">
                                <div class="d-flex justify-content-end" style="right: 0 !important;">
                                    <span  class="me-2">Subtotal:</span> <input  type="number" id="total" readonly  class="form-control me-3 form-control-sm text-center  w-25">          

                                </div>
                                <div  class="d-flex mt-2 justify-content-end" style="right: 0 !important;">
                                           <label class="me-2">Dni:</label> <input id="dni" oninput="validar_dni()"  class="form-control me-3 form-control-sm text-center  w-25" />
                                </div>
                                <div class="d-flex justify-content-end mt-2" style="right: 0 !important;">
                                             <label class="me-2">Descuento:</label> <input type="number" id="descuento" class="form-control me-3 form-control-sm text-center  w-25" readonly />
                                </div>
                               <div class="d-flex justify-content-end mt-2" style="right: 0 !important;">
                                             <label class="me-2">Total:</label> <input type="number" id="tot" class="form-control me-3 form-control-sm text-center  w-25" readonly />
                                </div>
                                <div class="mt-2">
                                    <button type="button" onclick="comprar()"  class="btn btn-sm btn-primary" style="width:265px">
                                        Comprar
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                     
            </div>
        </div>
    </form>
    <script type="text/javascript">
        document.getElementById('buscar').addEventListener('input', buscar);

        function buscar() {
            const valor = document.getElementById('buscar').value.toLowerCase();
            var cuerpo = document.getElementById('tabla_body');
            var filas = cuerpo.getElementsByTagName('tr');
            var filasVisibles = 0;
            for (var i = 0; i < filas.length; i++) {
                var celdas = filas[i].getElementsByTagName('td');
                if (celdas.length > 1) {
                    var dulce = celdas[1].innerText.toLowerCase();
                    if (dulce.includes(valor)) {
                        filas[i].classList.remove('d-none');
                        filasVisibles++;
                    } else {
                        filas[i].classList.add('d-none');
                    }

                }
            }
            if (filasVisibles == 0) {
                document.getElementById('foot').classList.remove('d-none');
            } else {
                document.getElementById('foot').classList.add('d-none');
            }

        }
        let productos = [];
        let datos_compra;
        function seleccionarDulce(id, nombre, detalle, precio) {
            const id_array = productos.map(productos => productos.id);
            var tabla_producto = document.getElementById('body_dulce');
            var total = document.getElementById('total');
            const filas_html = `
            <tr>
	            <td>${id}</td>
                <td>${nombre}</td>
                <td>${detalle}</td>
                <td>
                 <input  disabled value="${precio}" type="number" min=1 class="form-control form-control-sm text-center"  >
                </td>
                <td>
                    <input oninput="recalcular()" value="1" type="number" min=1 class="form-control form-control-sm text-center"  >
                </td>
                 <td>
                    <div>
                        <button type="button" class="btn btn-danger" onclick="eliminar_producto('${id}')">Eliminar</button>
                    </div> 
       
                </td>
             </tr>
            `;
            if (!id_array.includes(id)) {
                productos.push({
                    'id': id,
                    'nombre': nombre,
                    'detalle': detalle,
                    'precio': precio,
                    'unidades': 1
                });
                tabla_producto.innerHTML += filas_html;
                total.value = (parseFloat(precio) + parseFloat(total.value || 0)).toFixed(2);
            }
            validar_dni();
        }

        function recalcular() {
            const tabla = document.getElementById('body_dulce');
            const filas = tabla.getElementsByTagName('tr');
            let subtotal = 0;
            var total = document.getElementById('total');
            for (var i = 0; i < filas.length; i++) {
                var celdas = filas[i].getElementsByTagName('td');
                if (celdas.length > 0) {
                    var precio = parseFloat(celdas[3].getElementsByTagName('input')[0].value) || 0;
                    var unidades = parseInt(celdas[4].getElementsByTagName('input')[0].value) || 0;

                    if (unidades == 0) {
                        celdas[4].getElementsByTagName('input')[0].value = 1;
                        unidades = 1;
                    }

                    subtotal += precio * unidades;
                    productos[i].unidades = unidades;

                }
            }
            if (subtotal == 0) {
                total.value = '';
            } else {
                total.value = subtotal.toFixed(2);
            }
            validar_dni();
        }

        function eliminar_producto(id, valor) {
            var tabla_producto = document.getElementById('body_dulce');
            for (var i = 0; i < productos.length; i++) {
                if (productos[i].id == id) {
                    productos.splice(i, 1);
                    tabla_producto.deleteRow(i);
                    i--;
                    break;
                }
            }
            if (valor !== 'Si') {
                recalcular();
                validar_dni();
            }
        }

        function comprar() {
            var total = document.getElementById('total');
            if (total.value == 0 || total.value == '') {
                alert('Selecciona un producto para comprar');
                total.value = '';
                total.textContent = '';
            } else {
                var total = parseFloat(document.getElementById('tot').value); // Obtener el total
                var subtotal = total / 1.18; // Calcular el subtotal sin IGV
                var igv = total - subtotal;

                var datos_compra = {
                    'comprador': document.getElementById('dni').value,
                    'Subtotal': parseFloat(document.getElementById('total').value),
                    'Descuento': (parseFloat(document.getElementById('total').value) - total).toFixed(2),
                    'Total': total,
                    'igv': igv.toFixed(2)
                };

                var venta = {
                    'productos': productos, 
                    'dt_compra': datos_compra
                };

                console.log(venta);
                document.cookie = "venta=" + JSON.stringify(venta) + "; path=/; max-age=3600";
                fetch('ventadulce.aspx/registrar_venta', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                })
                .then(response => response.json())  // Convierte la respuesta en formato JSON
                    .then(data => {
                        if (data.d) {
                            var responseData = JSON.parse(data.d);
                            console.log('id_venta:', responseData.id_venta);
                            Swal.fire({
                                icon: 'success',
                                title: 'Venta de dulce registrado!',
                                text: 'ID de la venta del dulce: ' + responseData.id_venta,
                                showConfirmButton: false,
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Hubo un problema al registrar la venta. Intenta nuevamente.',
                                showConfirmButton: true
                            });
                        }
                    })
                    .catch(error => {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Ha ocurrido un error inesperado.',
                            showConfirmButton: true
                        });
                    });


                    
            }
        }


        function validar_dni() {
            const dni = document.getElementById('dni').value;
            const descuento = document.getElementById('descuento');
            const total = document.getElementById('tot');
            const subtotal = document.getElementById('total');
            if (dni.length == 8) {
                fetch('ventadulce.aspx/validar_dni', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ dni: dni })
                })
                .then(response => response.json())
                .then(data => {
                    descuento.value = data.d;
                    total.value = (subtotal.value - (subtotal.value * data.d)).toFixed(2);

                })
                .catch(error => {
                    console.error('Error:', error);
                });
            }
        }

        function limpiar_venta() {
            document.getElementById('body_dulce').innerHTML = '';
            document.getElementById('total').value = '';
            document.getElementById('tot').value = '';
            document.getElementById('descuento').value = '';
            document.getElementById('dni').value = '';
            productos = '';
        }

    </script>
</asp:Content>