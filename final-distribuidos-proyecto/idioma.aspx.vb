Imports capaNegocio
Public Class idioma
    Inherits System.Web.UI.Page

    Dim formatoNegocio As New clsIdiomaPedro()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CargarDatos()
        End If
    End Sub

    Private Sub CargarDatos()
        gvFormatos.DataSource = formatoNegocio.obtenerTodo()
        gvFormatos.DataBind()
    End Sub

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs)
        LimpiarFormulario()
        panelEditar.Visible = True
        lblTitulo.Text = "Agregar Formato"
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs)
        Dim nombre_formato As String = txtNombreFormato.Text
        Dim vigencia As Boolean = chkVigencia.Checked

        If lblTitulo.Text = "Agregar Formato" Then
            formatoNegocio.RegistrarIdioma(nombre_formato, vigencia)
        Else
            Dim id_formato As Integer = ViewState("id_formato")
            formatoNegocio.RegistrarIdioma(id_formato, nombre_formato)
        End If

        CargarDatos()
        panelEditar.Visible = False
    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs)
        panelEditar.Visible = False
    End Sub

    ' Evento RowEditing para entrar en el modo de edición
    Protected Sub gvFormatos_RowEditing(sender As Object, e As GridViewEditEventArgs)
        gvFormatos.EditIndex = e.NewEditIndex
        CargarDatos()
    End Sub

    ' Evento RowUpdating para guardar cambios después de la edición
    Protected Sub gvFormatos_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim id_formato As Integer = Convert.ToInt32(gvFormatos.DataKeys(e.RowIndex).Value)
        Dim txtNombreFormato As TextBox = CType(gvFormatos.Rows(e.RowIndex).FindControl("txtNombreFormato"), TextBox)
        Dim chkEditVigencia As CheckBox = CType(gvFormatos.Rows(e.RowIndex).FindControl("chkEditVigencia"), CheckBox)

        ' Actualizar el formato usando la capa de negocio
        formatoNegocio.ModificarIdioma(id_formato, txtNombreFormato.Text, chkEditVigencia.Checked)

        gvFormatos.EditIndex = -1
        CargarDatos()
    End Sub

    ' Evento RowCancelingEdit para cancelar la edición
    Protected Sub gvFormatos_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        gvFormatos.EditIndex = -1
        CargarDatos()
    End Sub

    ' Evento RowCommand para manejar la eliminación de un registro con confirmación
    Protected Sub gvFormatos_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Eliminar" Then
            Dim id_formato As Integer = Convert.ToInt32(e.CommandArgument)
            formatoNegocio.EliminarIdioma(id_formato)
            CargarDatos()
        End If
    End Sub

    ' Método para limpiar el formulario
    Private Sub LimpiarFormulario()
        txtNombreFormato.Text = ""
        chkVigencia.Checked = False
    End Sub

End Class