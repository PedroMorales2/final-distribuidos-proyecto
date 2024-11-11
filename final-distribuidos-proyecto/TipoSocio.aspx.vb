Imports capaNegocio


Public Class TipoSocio
    Inherits System.Web.UI.Page
    Dim socioNegocio As New clsSocio()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CargarDatos()
        End If
    End Sub

    Private Sub CargarDatos()
        gvTiposSocio.DataSource = socioNegocio.ObtenerSocios()
        gvTiposSocio.DataBind()
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs)
        Dim nombre As String = txtNombreTipoModal.Text.Trim()
        Dim descuento As Decimal

        If Decimal.TryParse(txtDescuentoModal.Text, descuento) Then
            If descuento > 1 Then descuento /= 100
            socioNegocio.RegistrarTipoSocio(nombre, descuento)
        End If
        CargarDatos()
    End Sub

    Protected Sub gvTiposSocio_RowEditing(sender As Object, e As GridViewEditEventArgs)
        gvTiposSocio.EditIndex = e.NewEditIndex
        CargarDatos()
    End Sub

    Protected Sub gvTiposSocio_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim id_tipo As Integer = Convert.ToInt32(gvTiposSocio.DataKeys(e.RowIndex).Value)
        Dim txtNombreTipo As TextBox = CType(gvTiposSocio.Rows(e.RowIndex).FindControl("txtNombreTipo"), TextBox)
        Dim txtDescuento As TextBox = CType(gvTiposSocio.Rows(e.RowIndex).FindControl("txtDescuento"), TextBox)
        Dim descuento As Decimal

        If Decimal.TryParse(txtDescuento.Text, descuento) Then
            If descuento > 1 Then descuento /= 100
            socioNegocio.ModificarTipoSocio(id_tipo, txtNombreTipo.Text, descuento)
        End If
        gvTiposSocio.EditIndex = -1
        CargarDatos()
    End Sub

    Protected Sub gvTiposSocio_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        gvTiposSocio.EditIndex = -1
        CargarDatos()
    End Sub

    Protected Sub gvTiposSocio_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Eliminar" Then
            Dim id_tipo As Integer = Convert.ToInt32(e.CommandArgument)
            socioNegocio.EliminarTipoSocio(id_tipo)
            CargarDatos()
        End If
    End Sub
End Class