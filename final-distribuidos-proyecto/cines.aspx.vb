Public Class cines
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs)
        ' Código para el evento btnBuscar_Click
    End Sub

    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs)
        ' Código para el evento btnBuscar_Click
    End Sub

    Protected Sub btnModificar_Click(sender As Object, e As EventArgs)
        ' Código para el evento btnBuscar_Click
    End Sub

    Protected Sub btnEliminar_Click(sender As Object, e As EventArgs)
        ' Código para el evento btnBuscar_Click
    End Sub

    Protected Sub btnLimpiar_Click(sender As Object, e As EventArgs)
        ' Código para el evento btnBuscar_Click
    End Sub

    Protected Sub ddlDepartamento_SelectedIndexChanged(sender As Object, e As EventArgs)
        ' Código para manejar el cambio de selección en ddlDepartamento
    End Sub

    Protected Sub ddlProvincia_SelectedIndexChanged(sender As Object, e As EventArgs)
        ' Código para manejar el cambio de selección en ddlProvincia
    End Sub

    Protected Sub gvCines_RowEditing(sender As Object, e As GridViewEditEventArgs)
        ' Código para manejar el evento RowEditing del GridView gvCines
    End Sub

    Protected Sub gvCines_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        ' Código para manejar la actualización de la fila en gvCines
        ' Ejemplo:
        Dim id_cine As Integer = Convert.ToInt32(gvCines.DataKeys(e.RowIndex).Value)
        Dim txtNombre As TextBox = CType(gvCines.Rows(e.RowIndex).FindControl("txtNombre"), TextBox)
        Dim txtCantidadSalas As TextBox = CType(gvCines.Rows(e.RowIndex).FindControl("txtCantidadSalas"), TextBox)

        ' Lógica para actualizar el registro en la base de datos
        ' Actualiza el cine en la base de datos con los datos editados.

        ' Restablece el índice de edición y recarga los datos.
        gvCines.EditIndex = -1
        CargarDatosCines()
    End Sub

    Protected Sub gvCines_RowCommand(sender As Object, e As GridViewCommandEventArgs)

    End Sub

    Protected Sub gvCines_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        ' Restablece el índice de edición para salir del modo de edición
        gvCines.EditIndex = -1
        ' Vuelve a cargar los datos en gvCines después de cancelar la edición
        CargarDatosCines()
    End Sub

    ' Método para cargar datos en el GridView (puedes ajustarlo según tus necesidades)
    Private Sub CargarDatosCines()
        ' Lógica para cargar datos en gvCines
    End Sub
End Class