Imports capaNegocio

Public Class dulceria
    Inherits System.Web.UI.Page
    Dim objDulce As New clsDulce
    Dim objPre As New clsPresentaciondulce
    Dim objTipo As New clsTipodulce
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            listar_tipo()
            listar_presentacion()
            Listar()
        End If
    End Sub
    Private Sub listar_tipo()
        Try
            Dim dt As DataTable = objPre.listarpresentacion()
            For Each row As DataRow In dt.Rows
                presentacion.Items.Add(row(1))
            Next
        Catch ex As Exception
        End Try
    End Sub
    Private Sub listar_presentacion()
        Try
            Dim dt As DataTable = objTipo.listar_tipo_dulce()
            For Each row As DataRow In dt.Rows
                tipodulce.Items.Add(row(1))
            Next
        Catch ex As Exception

        End Try
    End Sub

    Private Sub Listar()
        phDulces.Controls.Clear()

        Dim dt As DataTable = objDulce.listar_dulces()

        For Each row As DataRow In dt.Rows
            Dim tr As New HtmlTableRow()

            Dim tdId As New HtmlTableCell()
            tdId.InnerText = row(0).ToString()
            tr.Cells.Add(tdId)

            Dim tddulce As New HtmlTableCell()
            tddulce.InnerText = row(1).ToString()
            tr.Cells.Add(tddulce)

            Dim tdTipodulce As New HtmlTableCell()
            tdTipodulce.InnerText = row(3).ToString()

            tr.Cells.Add(tdTipodulce)

            Dim tdpresentacion As New HtmlTableCell()
            tdpresentacion.InnerText = row(6).ToString()
            tr.Cells.Add(tdpresentacion)

            Dim tdEstado As New HtmlTableCell()
            tdEstado.InnerText = row(4).ToString()
            tr.Cells.Add(tdEstado)

            Dim tdPrecio As New HtmlTableCell()
            tdPrecio.InnerText = row(2).ToString()
            tr.Cells.Add(tdPrecio)

            Dim tdOpciones As New HtmlTableCell()
            Dim btnVer As New Button()
            btnVer.Text = "Ver"
            btnVer.CssClass = "btn btn-primary  me-2"
            btnVer.OnClientClick = $"VerDulce({row(0).ToString()},'{row(1).ToString()}','{row(2).ToString()}','{row(3).ToString()}','{row(4).ToString()}','{row(5).ToString()}','{row(6).ToString()}'); return false;"
            tdOpciones.Controls.Add(btnVer)

            Dim btnModificar As New Button()
            btnModificar.Text = "Modificar"
            btnModificar.CssClass = "btn btn-warning me-2"
            btnModificar.OnClientClick = $"EditarDulce({row(0).ToString()},'{row(1).ToString()}','{row(2).ToString()}','{row(3).ToString()}','{row(4).ToString()}','{row(5).ToString()}','{row(6).ToString()}'); return false;"
            tdOpciones.Controls.Add(btnModificar)

            Dim btnBaja As New Button()
            btnBaja.Text = "Dar baja"
            btnBaja.CssClass = "btn btn-secondary me-2"
            btnBaja.OnClientClick = $"dar_baja({row(0).ToString()},'{row(1).ToString()}','{row(2).ToString()}','{row(3).ToString()}','{row(4).ToString()}','{row(5).ToString()}','{row(6).ToString()}'); return false;"
            tdOpciones.Controls.Add(btnBaja)


            Dim btnEliminar As New Button()
            btnEliminar.Text = "Eliminar"
            btnEliminar.CssClass = "btn btn-danger me-2"
            btnEliminar.OnClientClick = $"eliminarDulce({row(0).ToString()},'{row(1).ToString()}','{row(2).ToString()}','{row(3).ToString()}','{row(4).ToString()}','{row(5).ToString()}','{row(6).ToString()}'); return false;"
            tdOpciones.Controls.Add(btnEliminar)


            tr.Cells.Add(tdOpciones)
            phDulces.Controls.Add(tr)
        Next

    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim accion As String = Request.Form("ctl00$ContentPlaceHolder1$btnGuardar")
        ' Dim fl As HtmlInputFile = Request.Form("asd")
        Dim id As String = txtiddulce.Text
        Dim nombre As String = nombredulce.Text
        Dim pre As Decimal = If(Decimal.TryParse(precio.Text, pre), pre, 0.00D)
        Dim tipo_dulce As String = tipodulce.SelectedValue
        Dim prese As String = presentacion.SelectedValue
        Dim st As String = If(estado.Checked, "A", "I")
        Dim nombre_imagen = ""
        Dim nimagen As String = nombreimg.Text
        Dim file As HttpPostedFile = Request.Files("ContentPlaceHolder1_fileInput")

        If accion = "Guardar" Then
            Try
                If fileInput.HasFile Then
                    nombre_imagen = System.IO.Path.GetFileName(fileInput.FileName)

                    Dim uploadDirectory As String = Server.MapPath("~/Uploads/")
                    If Not IO.Directory.Exists(uploadDirectory) Then
                        IO.Directory.CreateDirectory(uploadDirectory)
                    End If

                    Dim filePath As String = System.IO.Path.Combine(uploadDirectory, nombre_imagen)

                    fileInput.SaveAs(filePath)
                    If objDulce.insertar_dulce(nombre, pre, tipo_dulce, nombre_imagen, st, prese) Then
                        Listar()
                        ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se registro correctamente el tipo de dulce!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                    Else
                        ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo registrar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                    End If
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo registrar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        ElseIf accion = "Modificar" Then
            nombre_imagen = System.IO.Path.GetFileName(fileInput.FileName)
            Try
                ' Verificar si el nombre de la imagen está vacío o es nulo
                If String.IsNullOrEmpty(nombre_imagen) Then
                    If objDulce.actualizar_dulce(id, nombre, pre, tipo_dulce, nimagen, st, prese) Then
                        Listar()
                        'limpiar()
                        ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se Modifico correctamente el dulce!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                    Else
                        ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede modificar el dulce!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                    End If
                Else
                    Dim uploadDirectory As String = Server.MapPath("~/Uploads/")
                    If Not IO.Directory.Exists(uploadDirectory) Then
                        IO.Directory.CreateDirectory(uploadDirectory)
                    End If

                    Dim filePath As String = System.IO.Path.Combine(uploadDirectory, nombre_imagen)

                    fileInput.SaveAs(filePath)

                    If objDulce.actualizar_dulce(id, nombre, pre, tipo_dulce, nombre_imagen, st, prese) Then
                        Listar()
                        'limpiar()
                        ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se Modifico correctamente el dulce!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                    Else
                        ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede modificar el dulce!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                    End If

                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo modificar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try

        ElseIf accion = "Eliminar" Then
            Try
                If objDulce.eliminar_dulce(id) Then
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se elimino correctamente!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                    Listar()
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo eliminar, porque estan relacionados con otras tablas!.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo eliminar, porque estan relacionados con otras tablas!.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        ElseIf accion = "Baja" Then
            Try
                If objDulce.dar_baja(id) Then
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se dio de baja correctamente!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                    Listar()
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede dar de baja!.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede dar de baja!.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        End If
    End Sub


End Class