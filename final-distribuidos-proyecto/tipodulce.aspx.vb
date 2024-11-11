Imports capaNegocio

Public Class tipodulce
    Inherits System.Web.UI.Page
    Dim objTipo As New clsTipodulce

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Listar()
    End Sub
    Private Sub Listar()
        ' Limpia el contenido del PlaceHolder
        phTiposDulce.Controls.Clear()

        ' Simula una llamada a la base de datos
        Dim dt As DataTable = objTipo.listar_tipo_dulce()

        ' Itera sobre las filas del DataTable
        For Each row As DataRow In dt.Rows
            ' Crea una nueva fila
            Dim tr As New HtmlTableRow()

            ' Columna ID
            Dim tdId As New HtmlTableCell()
            tdId.InnerText = row("tipo_dulce").ToString()
            tr.Cells.Add(tdId)

            ' Columna Tipo Dulce
            Dim tdTipo As New HtmlTableCell()
            tdTipo.InnerText = row("Tipo").ToString()
            tr.Cells.Add(tdTipo)

            ' Columna Opciones (botones de editar y eliminar)
            Dim tdOpciones As New HtmlTableCell()

            Dim btnVer As New Button()
            btnVer.Text = "Ver"
            btnVer.CssClass = "btn btn-primary btn me-2"
            btnVer.OnClientClick = $"VerTipoDulce({row("tipo_dulce").ToString()}, '{row("Tipo").ToString()}'); return false;"
            tdOpciones.Controls.Add(btnVer)

            ' Botón Editar
            Dim btnEditar As New Button()
            btnEditar.Text = "Editar"
            btnEditar.CssClass = "btn btn-warning btn me-2"
            btnEditar.OnClientClick = $"EditarTipoDulce({row("tipo_dulce").ToString()}, '{row("Tipo").ToString()}'); return false;"
            tdOpciones.Controls.Add(btnEditar)

            'Elimina
            Dim btnEliminar As New Button()
            btnEliminar.Text = "Eliminar"
            btnEliminar.CssClass = "btn btn-danger btn"
            btnEliminar.OnClientClick = $"eliminarTipoDulce({row("tipo_dulce").ToString()}, '{row("Tipo").ToString()}'); return false;"
            tdOpciones.Controls.Add(btnEliminar)


            tr.Cells.Add(tdOpciones)
            phTiposDulce.Controls.Add(tr)
        Next

    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim mensaje As String = ""
        Dim accion As String = Request.Form("ctl00$ContentPlaceHolder1$btnGuardar")
        Dim nombre = txtNombre.Text

        If accion = "Guardar" Then
            Try
                If objTipo.insertar_tipo_dulce(txtNombre.Text) Then
                    Limpiar()
                    Listar()
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se registro correctamente el tipo de dulce!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo registrar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se pudo registrar, compruebe sus datos!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        ElseIf accion = "Modificar" Then
            Dim id = txtIdTipo.Text
            Try
                If objTipo.modificar_tipo_dulce(id, nombre) Then
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
            Dim id = txtIdTipo.Text
            Try
                If objTipo.eliminarTipoDulce(id) Then
                    Limpiar()
                    Listar()
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'Se Elimino correctamente!', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#007bff'}).showToast();", True)
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede eliminar porque este tipo está relacionado con otras tablas.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
                End If
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "Toast", "Toastify({text: 'No se puede eliminar porque este tipo está relacionado con otras tablas.', duration: 3000, close: true, gravity: 'bottom', position: 'right', backgroundColor: '#FF4D4D'}).showToast();", True)
            End Try
        End If

        Limpiar()
    End Sub
    Private Sub Limpiar()
        txtIdTipo.Text = ""
        txtNombre.Text = ""
    End Sub

End Class