Imports capaNegocio

Public Class presentaciondulce
    Inherits System.Web.UI.Page
    Dim objPresentacion As New clsPresentaciondulce
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Listar()
    End Sub


    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim accion As String = Request.Form("ctl00$ContentPlaceHolder1$btnGuardar")
        Dim nombre = txtpresentacion.Text
        Dim id = txtidpresetacion.Text
        If accion = "Guardar" Then
            Try
                If objPresentacion.insertar_presentacion(nombre) Then
                    Limpiar()
                    Listar()
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se registro correctamente la presentación del dulce!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo registrar la presentación, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo registrar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        ElseIf accion = "Modificar" Then

            Try
                If objPresentacion.modificar_presentacion(id, nombre) Then
                    Limpiar()
                    Listar()
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se Modifico correctamente!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo Modificar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo Modificar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        ElseIf accion = "Eliminar" Then
            Try
                If objPresentacion.eliminarPresentacion(id) Then
                    Limpiar()
                    Listar()
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se Elimino correctamente!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede eliminar porque esta presentación está relacionado con otras tablas.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede eliminar, porque esta presentación esta relacionada con otras tablas.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        End If

        Limpiar()
    End Sub

    Private Sub Listar()
        ' Limpia el contenido del PlaceHolder
        phpresentacion.Controls.Clear()

        ' Simula una llamada a la base de datos
        Dim dt As DataTable = objPresentacion.listarpresentacion()

        ' Itera sobre las filas del DataTable
        For Each row As DataRow In dt.Rows
            ' Crea una nueva fila
            Dim tr As New HtmlTableRow()

            ' Columna ID
            Dim tdId As New HtmlTableCell()
            tdId.InnerText = row("id_presentacion").ToString()
            tr.Cells.Add(tdId)

            ' Columna presentacion
            Dim tdTipo As New HtmlTableCell()
            tdTipo.InnerText = row("presentacion").ToString()
            tr.Cells.Add(tdTipo)

            ' Columna Opciones (botones de editar y eliminar)
            Dim tdOpciones As New HtmlTableCell()

            Dim btnVer As New Button()
            btnVer.Text = "Ver"
            btnVer.CssClass = "btn btn-primary btn me-2"
            btnVer.OnClientClick = $"Verpresentacion({row("id_presentacion").ToString()}, '{row("presentacion").ToString()}'); return false;"
            tdOpciones.Controls.Add(btnVer)

            ' Botón Editar
            Dim btnEditar As New Button()
            btnEditar.Text = "Editar"
            btnEditar.CssClass = "btn btn-warning btn me-2"
            btnEditar.OnClientClick = $"Editarpresentacion({row("id_presentacion").ToString()}, '{row("presentacion").ToString()}'); return false;"
            tdOpciones.Controls.Add(btnEditar)

            'Elimina
            Dim btnEliminar As New Button()
            btnEliminar.Text = "Eliminar"
            btnEliminar.CssClass = "btn btn-danger btn"
            btnEliminar.OnClientClick = $"Eliminarpresentacion({row("id_presentacion").ToString()}, '{row("presentacion").ToString()}'); return false;"
            tdOpciones.Controls.Add(btnEliminar)


            tr.Cells.Add(tdOpciones)
            phpresentacion.Controls.Add(tr)
        Next

    End Sub
    Private Sub Limpiar()
        txtpresentacion.Text = ""
        txtidpresetacion.Text = ""
    End Sub
End Class