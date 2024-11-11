Imports capa_negocio
Imports capaNegocio

Public Class ubigeo
    Inherits Page

    Dim objUbigeo As New clsUbigeo

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            listarUbigeos()
        End If
    End Sub

    Private Sub listarUbigeos()
        Try
            grvUbigeo.DataSource = objUbigeo.ObtenerUbigeos()
            grvUbigeo.DataBind()
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        ' Hacer visible el panel de edición
        panelEditar.Visible = True

        ' Limpiar los campos de entrada
        txtDepartamentoPanel.Text = ""
        txtProvinciaPanel.Text = ""
        txtDistritoPanel.Text = ""

        ' Cambiar el título del panel a "Agregar Ubigeo"
        lblTitulo.Text = "Agregar Nuevo Ubigeo"
    End Sub


    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            ' Obtener los valores del panel de edición
            Dim departamento As String = txtDepartamentoPanel.Text
            Dim provincia As String = txtProvinciaPanel.Text
            Dim distrito As String = txtDistritoPanel.Text

            ' Lógica para guardar el nuevo Ubigeo (utilizando la capa de negocio o acceso a datos)
            ' Ejemplo: objUbigeo.AgregarUbigeo(departamento, provincia, distrito)
            If objUbigeo.RegistrarUbigeo(departamento, provincia, distrito) Then
            Else
            End If

            ' Ocultar el panel después de guardar y recargar la lista de ubigeos
            panelEditar.Visible = False
            listarUbigeos()
        Catch ex As Exception
        End Try
    End Sub


    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs)
        limpiarControles()
        panelEditar.Visible = False
    End Sub

    Protected Sub btnModificar_Click(sender As Object, e As EventArgs)
        If ViewState("SelectedUbigeoId") IsNot Nothing Then
            Try
                panelEditar.Visible = True
                lblTitulo.Text = "Editar Ubigeo"
                ViewState("EditMode") = True ' Modo edición
            Catch ex As Exception
            End Try
        Else
        End If
    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs)
        Try
            ' Verifica que los campos requeridos tengan valores
            If Not String.IsNullOrEmpty(txtDepartamentoPanel.Text) AndAlso Not String.IsNullOrEmpty(txtProvinciaPanel.Text) AndAlso Not String.IsNullOrEmpty(txtDistritoPanel.Text) Then
                ' Llama a EliminarUbigeo con los valores de departamento, provincia y distrito
                If objUbigeo.EliminarUbigeo(txtDepartamentoPanel.Text, txtProvinciaPanel.Text, txtDistritoPanel.Text) Then
                Else
                End If

                ' Limpia los campos y actualiza la lista de ubigeos
                limpiarControles()
                listarUbigeos()
                panelEditar.Visible = False
            Else
                ' Mensaje de error si faltan datos
            End If
        Catch ex As Exception
        End Try
    End Sub


    Protected Sub btnLimpiar_Click(sender As Object, e As EventArgs)
        limpiarControles()
    End Sub

    Private Sub limpiarControles()
        txtDepartamentoPanel.Text = ""
        txtProvinciaPanel.Text = ""
        txtDistritoPanel.Text = ""
        ViewState("SelectedUbigeoId") = Nothing
        ViewState("EditMode") = False
        panelEditar.Visible = False
    End Sub

    Protected Sub grvUbigeo_SelectedIndexChanged(sender As Object, e As EventArgs)
        Try
            Dim id As Integer = Convert.ToInt32(grvUbigeo.SelectedRow.Cells(0).Text)
            ViewState("SelectedUbigeoId") = id

            txtDepartamentoPanel.Text = HttpUtility.HtmlDecode(grvUbigeo.SelectedRow.Cells(1).Text)
            txtProvinciaPanel.Text = HttpUtility.HtmlDecode(grvUbigeo.SelectedRow.Cells(2).Text)
            txtDistritoPanel.Text = HttpUtility.HtmlDecode(grvUbigeo.SelectedRow.Cells(3).Text)

        Catch ex As Exception
        End Try
    End Sub

    Protected Sub grvUbigeo_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grvUbigeo, "Select$" & e.Row.RowIndex)
            e.Row.ToolTip = "Haz clic para seleccionar esta fila."
        End If
    End Sub

    Protected Sub grvUbigeo_RowEditing(sender As Object, e As GridViewEditEventArgs)
        ' Pone el GridView en modo edición en la fila seleccionada
        grvUbigeo.EditIndex = e.NewEditIndex
        listarUbigeos()
    End Sub

    Protected Sub grvUbigeo_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Try
            ' Obtiene el ID del Ubigeo que se está editando
            Dim idUbigeo As Integer = Convert.ToInt32(grvUbigeo.DataKeys(e.RowIndex).Value)

            ' Obtiene los nuevos valores ingresados por el usuario en los controles de la fila en edición
            Dim row As GridViewRow = grvUbigeo.Rows(e.RowIndex)
            Dim nuevoDepartamento As String = CType(row.FindControl("txtDepartamento"), TextBox).Text
            Dim nuevaProvincia As String = CType(row.FindControl("txtProvincia"), TextBox).Text
            Dim nuevoDistrito As String = CType(row.FindControl("txtDistrito"), TextBox).Text

            ' Llama al método para modificar el Ubigeo
            If objUbigeo.ModificarUbigeo(idUbigeo, nuevoDepartamento, nuevaProvincia, nuevoDistrito) Then
            Else
            End If

            ' Sale del modo de edición y recarga el GridView
            grvUbigeo.EditIndex = -1
            listarUbigeos()
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub grvUbigeo_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        ' Cancela el modo de edición en el GridView
        grvUbigeo.EditIndex = -1
        listarUbigeos()
    End Sub

    Protected Sub grvUbigeo_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Try
            If e.CommandName = "Eliminar" Then
                ' Obtener el índice de la fila seleccionada
                Dim index As Integer = Convert.ToInt32(e.CommandArgument)
                ' Obtener la fila seleccionada en el GridView
                Dim row As GridViewRow = grvUbigeo.Rows(index)

                ' Obtener los valores necesarios desde las celdas de la fila
                Dim departamento As String = row.Cells(1).Text
                Dim provincia As String = row.Cells(2).Text
                Dim distrito As String = row.Cells(3).Text

                ' Llama al método para eliminar el Ubigeo
                If objUbigeo.EliminarUbigeo(departamento, provincia, distrito) Then
                Else
                End If

                ' Recarga la lista de Ubigeos después de eliminar
                listarUbigeos()
            End If
        Catch ex As Exception
        End Try
    End Sub


End Class
