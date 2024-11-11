Imports capaNegocio
Imports System.IO
Imports System.Web.Script.Serialization
Imports System.Web.Services
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Drawing.Imaging
Imports System.Web.Configuration


Public Class combodulce
    Inherits System.Web.UI.Page
    Dim objCombo As New clsCombo
    Dim objDulce As New clsDulce

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        listar_combos()
        Listar()
    End Sub

    Private Sub Listar()
        phCombodulce.Controls.Clear()

        ' Simula una llamada a la base de datos
        Dim dt As DataTable = objDulce.listar_dulces()

        ' Itera sobre las filas del DataTable
        For Each row As DataRow In dt.Rows
            ' Crea una nueva fila
            Dim tr As New HtmlTableRow()

            ' Columna ID
            Dim tdId As New HtmlTableCell()
            tdId.InnerText = row(0).ToString()
            tr.Cells.Add(tdId)

            ' Columna Tipo Dulce
            Dim tdTipo As New HtmlTableCell()
            tdTipo.InnerText = row(1).ToString()
            tr.Cells.Add(tdTipo)

            Dim td2 As New HtmlTableCell()
            td2.InnerText = row(2).ToString()
            tr.Cells.Add(td2)

            Dim td3 As New HtmlTableCell()
            td3.InnerText = row(3).ToString()
            tr.Cells.Add(td3)

            Dim td4 As New HtmlTableCell()
            td4.InnerText = row(6).ToString()
            tr.Cells.Add(td4)

            Dim td5 As New HtmlTableCell()
            Dim input As New HtmlInputText()
            input.Attributes("class") = "form-control w-100"
            input.Attributes("type") = "number"
            input.Attributes("id") = row(0).ToString
            td5.Controls.Add(input)

            tr.Cells.Add(td5)

            ' Columna Opciones (botones de editar y eliminar)
            Dim tdOpciones As New HtmlTableCell()

            Dim btnVer As New Button()
            btnVer.Text = "Agregar"
            btnVer.CssClass = "btn btn-primary w-75 btn me-2 text-start"
            btnVer.OnClientClick = $"agregar_carrito({row(0).ToString()}, '{row(1).ToString()}' , '{row(2).ToString()}' , '{row(3).ToString()}' , '{row(6).ToString()}'); return false;"
            tdOpciones.Controls.Add(btnVer)


            tr.Cells.Add(tdOpciones)
            phCombodulce.Controls.Add(tr)
        Next

    End Sub




    Private Sub listar_combos()
        phCombo.Controls.Clear()
        Dim dt As DataTable = objCombo.listar_Combos()

        ' Itera sobre las filas del DataTable
        For Each row As DataRow In dt.Rows
            ' Crea una nueva fila
            Dim tr As New HtmlTableRow()

            ' Columna ID
            Dim tdId As New HtmlTableCell()
            tdId.InnerText = row(0).ToString()
            tr.Cells.Add(tdId)

            ' Columna Tipo Dulce
            Dim tdTipo As New HtmlTableCell()
            tdTipo.InnerText = row(1).ToString()
            tr.Cells.Add(tdTipo)

            Dim td2 As New HtmlTableCell()
            Dim img As New HtmlImage()
            img.Src = "/Uploads/" & row(2).ToString()
            td2.Controls.Add(img)
            tr.Cells.Add(td2)

            Dim td3 As New HtmlTableCell()
            td3.InnerText = row(4).ToString()
            tr.Cells.Add(td3)

            Dim td5 As New HtmlTableCell()
            td5.InnerText = row(3).ToString()
            tr.Cells.Add(td5)

            Dim td4 As New HtmlTableCell()
            td4.InnerText = row(2).ToString()
            tr.Cells.Add(td4)

            Dim tdOpciones As New HtmlTableCell()
            Dim btnVer As New Button()
            btnVer.Text = "Ver"
            btnVer.CssClass = "btn btn-primary btn me-2"
            btnVer.OnClientClick = $"ver_combo({row(0)}, '{HttpUtility.JavaScriptStringEncode(row(1).ToString())}', '{HttpUtility.JavaScriptStringEncode(row(2).ToString())}', '{HttpUtility.JavaScriptStringEncode(row(4).ToString())}', '{HttpUtility.JavaScriptStringEncode(row(3).ToString())}', '{HttpUtility.JavaScriptStringEncode(row(5).ToString())}'); return false;"
            tdOpciones.Controls.Add(btnVer)
            If row(3).ToString = "Inactivo" Then
                Dim btnActivar As New Button()
                btnActivar.Text = "Activar"
                btnActivar.CssClass = "btn btn-success"
                btnActivar.OnClientClick = "activar(" & row(0).ToString() & "); return false;"
                tdOpciones.Controls.Add(btnActivar)
            Else
                Dim btnDarBaja As New Button()
                btnDarBaja.Text = "Dar Baja"
                btnDarBaja.CssClass = "btn btn-secondary"
                btnDarBaja.OnClientClick = "darBaja(" & row(0).ToString() & "); return false;"
                tdOpciones.Controls.Add(btnDarBaja)
            End If

            tr.Cells.Add(tdOpciones)
            phCombo.Controls.Add(tr)
        Next
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btn2.Click
        Dim nombre As String = txtNombre.Text
        Dim precio As String = txtTotal.Text
        Dim detalle As String = txtDetalle.Text
        Dim estado As Char = If(chkActivo.Checked, "A", "I")

        Dim imagen As String = String.Empty
        If fileImagen.HasFile Then
            Dim fileName As String = Path.GetFileName(fileImagen.PostedFile.FileName)
            Dim uploadDir As String = Server.MapPath("~/Uploads/")
            ' Crear la carpeta si no existe
            If Not Directory.Exists(uploadDir) Then
                Directory.CreateDirectory(uploadDir)
            End If

            Dim filePath As String = Path.Combine(uploadDir, fileName)
            fileImagen.SaveAs(filePath)

            imagen = fileName
        End If

        If Request.Cookies("carrito") IsNot Nothing Then
            Dim carritoJSON As String = Request.Cookies("carrito").Value
            Dim carrito As JArray = JArray.Parse(carritoJSON)

            Dim ids As New List(Of Integer)
            Dim unidades As New List(Of Integer)

            For Each item As JObject In carrito
                ids.Add(item("ids"))
                unidades.Add(item("unidades"))
            Next

            If objCombo.insertarCombo(nombre, ids, unidades, precio, detalle, estado, imagen) Then
                listar_combos()
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se registro correctamente el combo!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)

            Else
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Error al agregar el combo!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End If
        Else
            ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No hay valores en el detalle combo, verifique!.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
        End If
    End Sub

    Protected Sub btnBaja_Click(sender As Object, e As EventArgs) Handles Button1.Click
        ' Obtener el valor del botón desde la solicitud (Request.Form)
        Dim boton As String = Request.Form("ctl00$ContentPlaceHolder1$Button1")
        Dim id As Integer = CInt(txtID.Text)
        ' Mostrar un alert con el valor del botón
        If boton = "Activar" Then
            'objCombo.activarCombo(id)
            ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se  activo correctamente!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)

            listar_combos()
        ElseIf boton = "Dar Baja" Then
            'objCombo.darBajaCombo(id)
            ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se dio de baja correctamente!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)

            listar_combos()
        End If
    End Sub




    <WebMethod()>
    Public Shared Function listar_dulces_por_combo(idCombo As Integer) As String
        Dim objCombo As New clsCombo()

        If objCombo Is Nothing Then
            Throw New Exception("Error al crear la instancia de clsCombo.")
        End If

        Dim dt As DataTable = objCombo.detalle_id(idCombo)
        Dim result As New List(Of Dictionary(Of String, Object))()

        ' Iterar sobre las filas del DataTable y generar el objeto JSON
        For Each row As DataRow In dt.Rows
            Dim item As New Dictionary(Of String, Object)()

            ' Asegurar que cada columna no sea DBNull antes de acceder a su valor
            item.Add("id", If(row(0) IsNot DBNull.Value, row(0).ToString(), ""))
            item.Add("nombre", If(row(1) IsNot DBNull.Value, row(1).ToString(), ""))
            item.Add("tipo", If(row(3) IsNot DBNull.Value, row(3).ToString(), ""))
            item.Add("presentacion", If(row(6) IsNot DBNull.Value, row(6).ToString(), ""))

            'item.Add("precio", If(row(2) IsNot DBNull.Value, row(2).ToString(), "")) precio

            item.Add("estado", If(row(4) IsNot DBNull.Value, row(4).ToString(), ""))
            item.Add("unidades", If(row(7) IsNot DBNull.Value, row(7).ToString(), ""))
            ' Agregar el objeto a la lista
            result.Add(item)
        Next

        ' Convertir la lista a JSON
        Dim json As String = New JavaScriptSerializer().Serialize(result)

        Return json
    End Function



End Class