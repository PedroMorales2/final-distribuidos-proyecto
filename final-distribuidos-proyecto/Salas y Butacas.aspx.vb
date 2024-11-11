Imports capaNegocio

Public Class Salas_y_Butacas
    Inherits System.Web.UI.Page

    Dim objSala As New clsSala()
    Dim objButaca As New clsButaca()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ListarSala()
            ListarButaca()
            LlenarComboBoxSalas()
        End If
    End Sub

    ' Listar Salas en el GridView
    Private Sub ListarSala()
        gvSalas.DataSource = objSala.ListarSalas()
        gvSalas.DataBind()
    End Sub

    ' Listar Butacas en el GridView
    Private Sub ListarButaca()
        gvButacas.DataSource = objButaca.listarButacas()
        gvButacas.DataBind()
    End Sub

    ' Llenar ComboBox con Salas
    Private Sub LlenarComboBoxSalas()
        ddlSala.DataSource = objSala.ListarSalas()
        ddlSala.DataTextField = "nombre"
        ddlSala.DataValueField = "id_sala"
        ddlSala.DataBind()
        ddlSala.Items.Insert(0, New ListItem("-- Seleccionar Sala --", "0"))
    End Sub

    ' Agregar una nueva Sala
    Protected Sub btnAgregarSala_Click(sender As Object, e As EventArgs) Handles btnAgregarSala.Click
        If txtNombreSala.Text.Trim() <> "" Then
            objSala.guardarSala(txtNombreSala.Text.Trim())
            ListarSala()
            LimpiarSala()
        End If
    End Sub

    ' Modificar una Sala existente
    Protected Sub btnModificarSala_Click(sender As Object, e As EventArgs) Handles btnModificarSala.Click
        If txtIdSala.Text <> "" And txtNombreSala.Text.Trim() <> "" Then
            objSala.modificarSala(CInt(txtIdSala.Text), txtNombreSala.Text.Trim())
            ListarSala()
            LimpiarSala()
        End If
    End Sub

    ' Eliminar una Sala
    Protected Sub btnEliminarSala_Click(sender As Object, e As EventArgs) Handles btnEliminarSala.Click
        If txtIdSala.Text <> "" Then
            objSala.eliminarSala(CInt(txtIdSala.Text))
            ListarSala()
            LimpiarSala()
        End If
    End Sub

    ' Limpiar campos de Salas
    Protected Sub btnLimpiarSala_Click(sender As Object, e As EventArgs) Handles btnLimpiarSala.Click
        LimpiarSala()
    End Sub

    ' Agregar una nueva Butaca
    Protected Sub btnAgregarButaca_Click(sender As Object, e As EventArgs) Handles btnAgregarButaca.Click
        If txtNombreButaca.Text.Trim() <> "" And ddlSala.SelectedValue <> "0" Then
            objButaca.guardarButaca(txtNombreButaca.Text.Trim(), CInt(ddlSala.SelectedValue))
            ListarButaca()
            LimpiarButaca()
        End If
    End Sub

    ' Modificar una Butaca existente
    Protected Sub btnModificarButaca_Click(sender As Object, e As EventArgs) Handles btnModificarButaca.Click
        If txtIdButaca.Text <> "" And txtNombreButaca.Text.Trim() <> "" And ddlSala.SelectedValue <> "0" Then
            objButaca.modificarButaca(CInt(txtIdButaca.Text), txtNombreButaca.Text.Trim(), CInt(ddlSala.SelectedValue))
            ListarButaca()
            LimpiarButaca()
        End If
    End Sub

    ' Eliminar una Butaca
    Protected Sub btnEliminarButaca_Click(sender As Object, e As EventArgs) Handles btnEliminarButaca.Click
        If txtIdButaca.Text <> "" Then
            objButaca.eliminarButaca(CInt(txtIdButaca.Text))
            ListarButaca()
            LimpiarButaca()
        End If
    End Sub

    ' Limpiar campos de Butacas
    Protected Sub btnLimpiarButaca_Click(sender As Object, e As EventArgs) Handles btnLimpiarButaca.Click
        LimpiarButaca()
    End Sub


    Protected Sub gvSalas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvSalas.SelectedIndexChanged
        Dim row As GridViewRow = gvSalas.SelectedRow
        txtIdSala.Text = row.Cells(1).Text
        txtNombreSala.Text = row.Cells(2).Text
        btnModificarSala.Enabled = True
        btnEliminarSala.Enabled = True
        btnAgregarSala.Enabled = False
    End Sub

    Protected Sub gvButacas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvButacas.SelectedIndexChanged
        Dim row As GridViewRow = gvButacas.SelectedRow
        txtIdButaca.Text = row.Cells(1).Text
        txtNombreButaca.Text = row.Cells(2).Text
        ddlSala.SelectedValue = row.Cells(3).Text
        btnModificarButaca.Enabled = True
        btnEliminarButaca.Enabled = True
        btnAgregarButaca.Enabled = False
    End Sub

    Private Sub LimpiarSala()
        txtIdSala.Text = ""
        txtNombreSala.Text = ""
        btnModificarSala.Enabled = False
        btnEliminarSala.Enabled = False
        btnAgregarSala.Enabled = True
    End Sub

    Private Sub LimpiarButaca()
        txtIdButaca.Text = ""
        txtNombreButaca.Text = ""
        ddlSala.SelectedIndex = 0
        btnModificarButaca.Enabled = False
        btnEliminarButaca.Enabled = False
        btnAgregarButaca.Enabled = True
    End Sub

End Class
