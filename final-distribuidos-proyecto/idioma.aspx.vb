Imports capaNegocio

Public Class idioma
    Inherits System.Web.UI.Page

    Dim idiomaNegocio As New clsIdiomaPedro()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CargarDatos()
        End If
    End Sub

    Private Sub CargarDatos()
        gvIdiomas.DataSource = idiomaNegocio.obtenerTodo()
        gvIdiomas.DataBind()
    End Sub

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs)
        LimpiarFormulario()
        panelEditar.Visible = True
        lblTitulo.Text = "Agregar Idioma"
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs)
        Dim nombre_idioma As String = txtNombreIdiomaPanel.Text
        Dim vigencia As Boolean = chkVigenciaPanel.Checked

        If lblTitulo.Text = "Agregar Idioma" Then
            idiomaNegocio.RegistrarIdioma(nombre_idioma, vigencia)
        Else
            Dim id_idioma As Integer = ViewState("id_idioma")
            idiomaNegocio.ModificarIdioma(id_idioma, nombre_idioma, vigencia)
        End If

        CargarDatos()
        panelEditar.Visible = False
    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs)
        panelEditar.Visible = False
    End Sub

    ' Evento RowEditing para entrar en el modo de edición
    Protected Sub gvIdiomas_RowEditing(sender As Object, e As GridViewEditEventArgs)
        gvIdiomas.EditIndex = e.NewEditIndex
        CargarDatos()
    End Sub

    ' Evento RowUpdating para guardar cambios después de la edición
    Protected Sub gvIdiomas_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim id_idioma As Integer = Convert.ToInt32(gvIdiomas.DataKeys(e.RowIndex).Value)
        Dim txtNombreIdioma As TextBox = CType(gvIdiomas.Rows(e.RowIndex).FindControl("txtNombreIdioma"), TextBox)
        Dim chkEditVigencia As CheckBox = CType(gvIdiomas.Rows(e.RowIndex).FindControl("chkEditVigencia"), CheckBox)

        ' Actualizar el idioma usando la capa de negocio
        idiomaNegocio.ModificarIdioma(id_idioma, txtNombreIdioma.Text, chkEditVigencia.Checked)

        gvIdiomas.EditIndex = -1
        CargarDatos()
    End Sub

    ' Evento RowCancelingEdit para cancelar la edición
    Protected Sub gvIdiomas_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        gvIdiomas.EditIndex = -1
        CargarDatos()
    End Sub

    ' Evento RowCommand para manejar la eliminación de un registro con confirmación
    Protected Sub gvIdiomas_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Eliminar" Then
            Dim id_idioma As Integer = Convert.ToInt32(e.CommandArgument)
            idiomaNegocio.EliminarIdioma(id_idioma)
            CargarDatos()
        End If
    End Sub

    ' Método para limpiar el formulario
    Private Sub LimpiarFormulario()
        txtNombreIdiomaPanel.Text = ""
        chkVigenciaPanel.Checked = False
    End Sub

End Class
