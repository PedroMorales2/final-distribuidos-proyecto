Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Security
Imports dato

Public Class clsS
    Dim conexion As New conection()
    Dim objMan As New mant
    Dim strSQL As String



    Public Function ObtenerCinePorID(idCine As Integer) As DataTable
        Try
            Dim query As String = "SELECT * FROM Cine WHERE id_cine = @id_cine"
            Dim parametros As New List(Of SqlParameter) From {
            New SqlParameter("@id_cine", idCine)
        }
            Return conexion.EjecutarConsulta(query, parametros)
        Catch ex As Exception
            Throw New Exception("Error al obtener el cine: " & ex.Message)
        End Try
    End Function


    Public Function ObtenerTickets() As DataTable
        Dim query As String = "SELECT id_ticket, subtotal FROM Ticket"
        Return objMan.listarComando(query)
    End Function

    Public Function ObtenerVentas() As DataTable
        Dim query As String = "SELECT id_venta, subtotal FROM Venta_dulce"
        Return objMan.listarComando(query)
    End Function

    Public Function ObtenerFormasPago() As DataTable
        Dim query As String = "SELECT id_forma, nombre FROM Forma_pago"
        Return objMan.listarComando(query)
    End Function

    ' Método para obtener tickets sin comprobante
    Public Function ObtenerTicketsSinComprobante() As DataTable
        Dim query As String = "SELECT id_ticket FROM Ticket WHERE id_ticket NOT IN (SELECT id_ticket FROM Comprobante WHERE id_ticket IS NOT NULL)"
        Return objMan.listarComando(query)
    End Function

    ' Método para obtener ventas sin comprobante
    Public Function ObtenerVentasSinComprobante() As DataTable
        Dim query As String = "SELECT id_venta FROM Venta_dulce WHERE id_venta NOT IN (SELECT id_venta FROM Comprobante WHERE id_venta IS NOT NULL)"
        Return objMan.listarComando(query)
    End Function

    Public Function ObtenerVentaPorID(idVenta As Integer) As DataTable
        Try
            Dim query As String = "SELECT * FROM Venta_dulce WHERE id_venta = @id_venta"
            Dim parametros As New List(Of SqlParameter) From {
            New SqlParameter("@id_venta", idVenta)
        }
            Return conexion.EjecutarConsulta(query, parametros)
        Catch ex As Exception
            Throw New Exception("Error al obtener la venta: " & ex.Message)
        End Try
    End Function


    Public Function ObtenerTicketPorID(idTicket As Integer) As DataTable
        Try
            Dim query As String = "SELECT * FROM Ticket WHERE id_ticket = @id_ticket"
            Dim parametros As New List(Of SqlParameter) From {
            New SqlParameter("@id_ticket", idTicket)
        }
            Return conexion.EjecutarConsulta(query, parametros)
        Catch ex As Exception
            Throw New Exception("Error al obtener el ticket: " & ex.Message)
        End Try
    End Function

    Public Function ObtenerDulcesActivos() As DataTable
        Try
            Dim query As String = "
                SELECT concat('D',dl.id_dulce) AS id, dl.nombre AS nombre, pr.presentacion AS detalle, dl.precio AS precio
                FROM dulceria AS dl
                INNER JOIN presentacion_dulce AS pr ON pr.id_presentacion = dl.id_presentacion_dulce
                WHERE dl.estado = 'A'

                UNION ALL

                SELECT concat('C',cb.id_combo) AS id, cb.nombre AS nombre, cb.detalle AS detalle, cb.monto_total AS precio
                FROM combo AS cb
                WHERE cb.estado = 'A';
            "

            Return conexion.EjecutarConsulta(query, New List(Of SqlParameter)())
        Catch ex As Exception
            Throw New Exception("Error al obtener los dulces: " & ex.Message)
        End Try
    End Function

    Public Function ObtenerDescuentoPorDNI(DNI As String) As DataTable
        Try
            ' Consulta SQL con el parámetro @DNI
            Dim query As String = "
            SELECT tp.descuento 
            FROM usuario AS us
            INNER JOIN Tipo_socio AS tp 
                ON tp.id_tipo = us.id_tiposocio 
            WHERE us.numero_doc = @DNI;
        "
            Return conexion.EjecutarConsulta(query, New List(Of SqlParameter) From {
                New SqlParameter("@DNI", SqlDbType.VarChar) With {
                    .Value = DNI
                }
            })
        Catch ex As Exception
            Throw New Exception("Error al obtener el descuento: " & ex.Message)
        End Try
    End Function

    Public Function RegistrarVentaDulce(subtotal As Double, dni_usuario As String, descuento As Double, total As Double, igv As Double, cantidad As List(Of Integer), precio As List(Of Double), subtotal_detalle As List(Of Double), id_dulce As List(Of Integer), id_combo As List(Of Integer)) As Integer
        Try

            Dim query As String = "
        INSERT INTO venta (subtotal, id_usuario, descuento, total, igv)
        VALUES (@subtotal, (SELECT TOP 1 id_usuario FROM usuario WHERE numero_doc = @dni_usuario), @descuento, @total, @igv);
        SELECT SCOPE_IDENTITY();"

            ' Ejecutar la consulta para insertar la venta
            Dim idGenerado As Integer = Convert.ToInt32(conexion.EjecutarConsulta(query, New List(Of SqlParameter) From {
        New SqlParameter("@subtotal", SqlDbType.Decimal) With {.Value = subtotal},
        New SqlParameter("@dni_usuario", SqlDbType.VarChar) With {.Value = dni_usuario},
        New SqlParameter("@descuento", SqlDbType.Decimal) With {.Value = descuento},
        New SqlParameter("@total", SqlDbType.Decimal) With {.Value = total},
        New SqlParameter("@igv", SqlDbType.Decimal) With {.Value = igv}
    }).Rows(0)(0))

            ' Comprobar que las listas tengan la misma longitud
            If cantidad.Count <> precio.Count OrElse cantidad.Count <> subtotal_detalle.Count OrElse cantidad.Count <> id_dulce.Count OrElse cantidad.Count <> id_combo.Count Then
                Throw New Exception("Las listas no tienen la misma longitud.")
            End If

            ' Insertar los detalles de la venta
            For i As Integer = 0 To cantidad.Count - 1
                Dim detalleQuery As String = "
            INSERT INTO detalle_venta(id_venta, id_dulce, id_combo, cantidad, precio, subtotal)
            VALUES (@id_venta, @id_dulce, @id_combo, @cantidad, @precio, @subtotal)"

                ' Ejecutar el detalle de la venta para cada ítem
                conexion.EjecutarConsulta(detalleQuery, New List(Of SqlParameter) From {
            New SqlParameter("@id_venta", SqlDbType.Int) With {.Value = idGenerado},
            New SqlParameter("@id_dulce", SqlDbType.Int) With {.Value = id_dulce(i)},
            New SqlParameter("@id_combo", SqlDbType.Int) With {.Value = id_combo(i)},
            New SqlParameter("@cantidad", SqlDbType.Int) With {.Value = cantidad(i)},
            New SqlParameter("@precio", SqlDbType.Decimal) With {.Value = precio(i)},
            New SqlParameter("@subtotal", SqlDbType.Decimal) With {.Value = subtotal_detalle(i)}
        })
            Next

            Dim comprobanteQuery As String = "
        INSERT INTO comprobante (total, impuesto, subtotal, fecha_emision, id_ticket, id_venta, id_forma)
        VALUES (@total, @impuesto, @subtotal, @fecha_emision, @id_ticket, @id_venta, @id_forma);
        SELECT SCOPE_IDENTITY();"

            conexion.EjecutarConsulta(comprobanteQuery, New List(Of SqlParameter) From {
            New SqlParameter("@total", SqlDbType.Decimal) With {.Value = total},
            New SqlParameter("@impuesto", SqlDbType.Decimal) With {.Value = igv},
            New SqlParameter("@subtotal", SqlDbType.Decimal) With {.Value = subtotal},
            New SqlParameter("@fecha_emision", SqlDbType.DateTime) With {.Value = DateTime.Now},
            New SqlParameter("@id_ticket", SqlDbType.Int) With {.Value = 0},
            New SqlParameter("@id_venta", SqlDbType.Int) With {.Value = idGenerado},
            New SqlParameter("@id_forma", SqlDbType.Int) With {.Value = 1}
        })

            ' Retornar el ID generado
            Return idGenerado

        Catch ex As Exception
            Throw New Exception("Error al registrar la venta: " & ex.Message)
        End Try
    End Function


    Public Function obtener_venta(id_venta As Integer) As DataTable
        Try
            Dim query As String = "
        SELECT 
            CASE 
                WHEN dv.id_dulce > 0 THEN du.nombre
                WHEN dv.id_combo > 0 THEN c.nombre
                ELSE NULL
            END AS nombre_producto,
            CASE 
                WHEN dv.id_dulce > 0 THEN du.precio
                WHEN dv.id_combo > 0 THEN c.monto_total
                ELSE 0
            END AS precio,
            dv.cantidad,
            dv.subtotal
        FROM 
            comprobante co
        JOIN 
            detalle_venta dv ON dv.id_venta = co.id_venta
        LEFT JOIN 
            dulceria du ON dv.id_dulce = du.id_dulce
        LEFT JOIN 
            combo c ON dv.id_combo = c.id_combo
        WHERE 
            co.id_venta = @id_venta AND co.id_ticket = 0
        "

            Return conexion.EjecutarConsulta(query, New List(Of SqlParameter) From {
                New SqlParameter("@id_venta", SqlDbType.Int) With {.Value = id_venta}
            })
        Catch ex As Exception
            Throw New Exception("Error al obtener la venta: " & ex.Message)
        End Try
    End Function

    Public Function obtener_estado(id_venta As Integer) As DataTable
        Try
            ' Consulta para obtener solo el estado de la venta
            Dim query As String = "
        SELECT co.estado AS estado_venta
        FROM comprobante co
        WHERE co.id_venta = @id_venta AND co.id_ticket = 0
        "

            ' Ejecutar la consulta y devolver el resultado
            Return conexion.EjecutarConsulta(query, New List(Of SqlParameter) From {
            New SqlParameter("@id_venta", SqlDbType.Int) With {.Value = id_venta}
        })
        Catch ex As Exception
            Throw New Exception("Error al obtener el estado de la venta: " & ex.Message)
        End Try
    End Function


    Public Function actualizar_estado(id_venta As Integer, nuevoEstado As Integer) As Boolean
        Try
            Dim query As String = "
            UPDATE comprobante
            SET estado = " & nuevoEstado & "
            WHERE id_venta = " & id_venta
            objMan.ejecutarComando(query)
            Return 1
        Catch ex As Exception
            Return 0
        End Try
    End Function


    Public Function obtener_nombre_cliente(id_venta As Integer) As String
        Try
            Dim query As String = "SELECT CONCAT(usu.apellidos, ' ', usu.nombre) AS nombre_cliente
                               FROM venta AS v
                               INNER JOIN usuario AS usu ON usu.id_usuario = v.id_usuario
                               WHERE v.id_venta = " & id_venta

            Dim dt As DataTable = objMan.listarComando(query)

            If dt.Rows.Count > 0 Then
                Return dt.Rows(0)("nombre_cliente").ToString()
            Else
                Return String.Empty
            End If
        Catch ex As Exception
            Throw New Exception("Error al obtener el nombre del cliente: " & ex.Message)
        End Try
    End Function



End Class
