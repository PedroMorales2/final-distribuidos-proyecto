Imports negocio

Public Class entregadulce_comprobante
    Inherits System.Web.UI.Page

    Dim objsS As New clsS

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub



    Protected Sub buscarVenta_Click(sender As Object, e As EventArgs) Handles buscarVenta.Click
        Dim id_venta As String = numeroVenta.Text
        Try
            ' Obtener los datos de la venta y el estado
            Dim dt = objsS.obtener_venta(id_venta)
            Dim st = objsS.obtener_estado(id_venta)
            Dim usuario = objsS.obtener_nombre_cliente(id_venta)
            If (dt.Rows.Count > 0) Then
                productosVentaLiteral.Text = ""

                ' Recorrer los detalles de la venta
                For Each row As DataRow In dt.Rows
                    Dim producto As String = row("nombre_producto").ToString()
                    Dim cantidad As Integer = Convert.ToInt32(row("cantidad"))
                    Dim precio As Double = Convert.ToDouble(row("precio"))
                    Dim subtotal As Double = Convert.ToDouble(row("subtotal"))

                    Dim fila As String = $"<tr>
                                         <td>{producto}</td>
                                         <td>{cantidad}</td>
                                       </tr>"

                    productosVentaLiteral.Text &= fila
                Next

                If st.Rows.Count > 0 Then
                    Dim estado As Integer = Convert.ToInt32(st.Rows(0)("estado_venta"))
                    cliente.Text = usuario
                    If estado = 1 Then
                        actualizarEstadoCheckbox.Checked = True
                        actualizarEstadoCheckbox.Enabled = False
                        actualizarEstado.Enabled = False
                    Else
                        actualizarEstado.Enabled = True
                        actualizarEstadoCheckbox.Checked = False
                        actualizarEstadoCheckbox.Enabled = True
                    End If
                End If
            Else
                productosVentaLiteral.Text = ""
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se encontró esa venta', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#dc3545'}).showToast();", True)
            End If
        Catch ex As Exception
            productosVentaLiteral.Text = ""
            ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Error al obtener los datos', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#dc3545'}).showToast();", True)
        End Try
    End Sub

    Protected Sub actualizarEstado_Click(sender As Object, e As EventArgs)
        Dim id_venta As String = numeroVenta.Text
        Try
            Dim nuevoEstado As Integer = If(actualizarEstadoCheckbox.Checked, 1, 0)

            Dim result As Integer = objsS.actualizar_estado(id_venta, nuevoEstado)

            If result Then
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Estado actualizado correctamente', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#28a745'}).showToast();", True)
            Else
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Error al actualizar el estado', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#dc3545'}).showToast();", True)
            End If
        Catch ex As Exception
            ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Error al procesar la solicitud', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#dc3545'}).showToast();", True)
        End Try
    End Sub
    Protected Sub limpiarButton_Click(sender As Object, e As EventArgs)
        numeroVenta.Text = ""
        cliente.Text = ""
        productosVentaLiteral.Text = ""
        actualizarEstadoCheckbox.Checked = False
        actualizarEstado.Enabled = True ' Si es necesario habilitarlo nuevamente
    End Sub


End Class