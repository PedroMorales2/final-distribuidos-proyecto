
Imports System.Web.Services
Imports System.Diagnostics
Imports System.Web.Script.Serialization
Imports Newtonsoft.Json.Linq
Imports negocio
Public Class ventadulce
    Inherits System.Web.UI.Page

    Dim objS As New negocio.clsS

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Listar()
    End Sub


    Private Sub Listar()
        ' Limpiar el contenido previo
        phCombodulce.Controls.Clear()

        Dim dt As DataTable = objS.ObtenerDulcesActivos()

        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then
            For Each row As DataRow In dt.Rows
                Dim tr As New TableRow()

                Dim tdId As New TableCell()
                tdId.Text = row("id").ToString()
                tr.Cells.Add(tdId)

                Dim tdNombre As New TableCell()
                tdNombre.Text = row("nombre").ToString()
                tr.Cells.Add(tdNombre)


                Dim tdPresentacion As New TableCell()
                tdPresentacion.Text = row("detalle").ToString()
                tr.Cells.Add(tdPresentacion)

                Dim tdPrecio As New TableCell()
                tdPrecio.Text = row("precio").ToString()
                tr.Cells.Add(tdPrecio)


                Dim tdAccion As New TableCell()
                Dim btnSeleccionar As New Button()
                btnSeleccionar.Text = "Seleccionar"
                btnSeleccionar.CssClass = "btn btn-sm btn-primary"
                Dim parametros As String = $"'{row("id").ToString()}', '{row("nombre").ToString()}', '{row("detalle").ToString()}', {row("precio").ToString()}"

                btnSeleccionar.OnClientClick = $"seleccionarDulce({parametros}); return false;"
                tdAccion.Controls.Add(btnSeleccionar)
                tr.Cells.Add(tdAccion)

                phCombodulce.Controls.Add(tr)
            Next
        End If

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function validar_dni(dni As String) As String
        Dim objS As New negocio.clsS
        If dni.Length = 8 Then
            Dim dt As DataTable = objS.ObtenerDescuentoPorDNI(dni)

            If dt.Rows.Count > 0 Then
                Dim descuento As Decimal = Convert.ToDecimal(dt.Rows(0)("descuento"))
                Return descuento.ToString()
            Else
                Return "No se encontró descuento para este DNI."
            End If
        Else
            Return "DNI inválido"
        End If
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function registrar_venta() As String
        Dim response As New Dictionary(Of String, Object)()
        Dim objS As New clsS
        Try
            Dim ventaCookie As HttpCookie = HttpContext.Current.Request.Cookies("venta")
            If ventaCookie IsNot Nothing Then
                Dim ventaJson As String = ventaCookie.Value

                Try
                    Dim venta As JObject = JObject.Parse(ventaJson)

                    ' Validar propiedades
                    If venta("productos") Is Nothing OrElse venta("dt_compra") Is Nothing Then
                        response.Add("status", "error")
                        response.Add("message", "El JSON de la cookie no contiene las propiedades esperadas.")
                    Else
                        Dim productos As JArray = CType(venta("productos"), JArray)
                        Dim dt_compra As JObject = CType(venta("dt_compra"), JObject)

                        Dim comprador As String = dt_compra("comprador").ToString()
                        Dim subtotal As Decimal = Convert.ToDecimal(dt_compra("Subtotal"))
                        Dim descuento As Decimal = Convert.ToDecimal(dt_compra("Descuento"))
                        Dim total As Decimal = Convert.ToDecimal(dt_compra("Total"))
                        Dim igv As Decimal = Convert.ToDecimal(dt_compra("igv"))

                        Dim cantidad As New List(Of Integer)
                        Dim precio As New List(Of Double)
                        Dim subtotal_detalle As New List(Of Double)
                        Dim idd As New List(Of Integer)
                        Dim idc As New List(Of Integer)

                        For Each item As JObject In productos
                            cantidad.Add(Convert.ToInt32(item("unidades")))
                            precio.Add(Convert.ToDecimal(item("precio")))

                            Dim su As Double = Convert.ToDecimal(item("precio")) * Convert.ToInt32(item("unidades"))

                            subtotal_detalle.Add(Convert.ToDecimal(item("precio")) * Convert.ToDecimal(item("unidades")))

                            If item("id").ToString().StartsWith("D") Then
                                idd.Add(Convert.ToInt32(item("id").ToString().Substring(1)))
                                idc.Add(0)
                            ElseIf item("id").ToString().StartsWith("C") Then
                                idc.Add(Convert.ToInt32(item("id").ToString().Substring(1)))
                                idd.Add(0)
                            End If

                        Next


                        ' Llamar a la función para registrar la venta
                        Dim id_venta As Integer = objS.RegistrarVentaDulce(subtotal, comprador, descuento, total, igv, cantidad, precio, subtotal_detalle, idd, idc)


                        response.Add("id_venta", id_venta)
                    End If
                Catch ex As Exception
                    response.Add("status", "error")
                    response.Add("message", "Error al parsear la cookie 'venta': " & ex.Message)
                End Try
            Else
                response.Add("status", "error")
                response.Add("message", "No se encontró la cookie 'venta'.")
            End If
        Catch ex As Exception
            response.Add("status", "error")
            response.Add("message", "Ocurrió un error al procesar la venta: " & ex.Message)
        End Try

        Return New JavaScriptSerializer().Serialize(response)
    End Function


End Class