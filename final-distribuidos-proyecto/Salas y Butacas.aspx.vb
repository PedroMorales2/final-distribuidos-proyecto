Imports capaNegocio

Public Class Salas_y_Butacas
    Inherits System.Web.UI.Page

    Dim objSala As New clsSala()
    Dim objButaca As New clsButaca()

    ' Cargar datos iniciales al cargar la página
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ListarSala()
            ListarButaca()
            LlenarComboBoxSalas()
            LlenarComboBoxSalasV()
        End If
    End Sub

    ' Listar Salas en el GridView
    Private Sub ListarSala()
        gvSalas.DataSource = objSala.ListarSalas()
        gvSalas.DataBind()
    End Sub

    ' Agregar una nueva Sala
    Protected Sub btnAgregarSala_Click(sender As Object, e As EventArgs) Handles btnAgregarSala.Click
        If txtNombreSala.Text.Trim() <> "" AndAlso txtNumeroAsientos.Text.Trim() <> "" Then

            ' Guardar la sala con el número de asientos
            objSala.guardarSala(txtNombreSala.Text.Trim(), Convert.ToInt32(txtNumeroAsientos.Text))
            ListarSala()
        End If
        LimpiarSalaFormulario()
        LimpiarSalaV()
        LlenarComboBoxSalas()
        LlenarComboBoxSalasV()
    End Sub


    ' Modificar una Sala existente
    Protected Sub btnModificarSala_Click(sender As Object, e As EventArgs) Handles btnModificarSala.Click
        If txtIdSalaV.Text <> "" And txtNombreSalaV.Text.Trim() <> "" Then
            objSala.modificarSala(CInt(txtIdSalaV.Text), txtNombreSalaV.Text.Trim(), CInt(txtNumeroAsientosV.Text))
            ListarSala()
        End If
        LimpiarSalaFormulario()
        LimpiarSalaV()
        LlenarComboBoxSalas()
        LlenarComboBoxSalasV()
    End Sub

    ' Eliminar una Sala
    Protected Sub btnEliminarSala_Click(sender As Object, e As EventArgs) Handles btnEliminarSala.Click
        If txtIdSalaV.Text <> "" Then
            objSala.eliminarSala(CInt(txtIdSalaV.Text))
            ListarSala()
        End If
        LimpiarSalaFormulario()
        LimpiarSalaV()
        LlenarComboBoxSalas()
        LlenarComboBoxSalasV()
    End Sub

    ' Limpiar campos de Salas
    Protected Sub btnLimpiarSala_Click(sender As Object, e As EventArgs) Handles btnLimpiarSala.Click
        LimpiarSalaFormulario()
        LimpiarSalaV()
    End Sub

    Protected Sub gvSalas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvSalas.SelectedIndexChanged
        Dim row As GridViewRow = gvSalas.SelectedRow
        txtIdSalaV.Text = row.Cells(1).Text
        txtNombreSalaV.Text = row.Cells(2).Text
        txtNombreSalaV.Enabled = True
        txtNumeroAsientosV.Text = row.Cells(3).Text
        txtNumeroAsientosV.Enabled = True
        btnModificarSala.Enabled = True
        btnEliminarSala.Enabled = True
        btnAgregarSala.Enabled = False
    End Sub

    Private Sub LimpiarSalaV()
        txtIdSalaV.Text = ""
        txtNombreSalaV.Text = ""
        txtNombreSalaV.Enabled = False
        txtNumeroAsientosV.Text = ""
        txtNumeroAsientosV.Enabled = False
        btnModificarSala.Enabled = False
        btnEliminarSala.Enabled = False
        btnAgregarSala.Enabled = True
    End Sub

    Private Sub LimpiarSalaFormulario()
        txtNombreSala.Text = ""
        txtNumeroAsientos.Text = ""
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

    ' Llenar ComboBox con Salas
    Private Sub LlenarComboBoxSalasV()
        ddlSalaV.DataSource = objSala.ListarSalas()
        ddlSalaV.DataTextField = "nombre"
        ddlSalaV.DataValueField = "id_sala"
        ddlSalaV.DataBind()
        ddlSalaV.Items.Insert(0, New ListItem("-- Nombre sala --", "0"))
    End Sub

    ' Evento al seleccionar una Sala en el comboBox
    Protected Sub ddlSala_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSala.SelectedIndexChanged
        If ddlSala.SelectedValue <> "0" Then
            Dim dt As DataTable = objSala.buscarSalaPorId(Convert.ToInt32(ddlSala.SelectedValue))
            If dt.Rows.Count > 0 Then

                txtNumeroAsientosb.Text = dt.Rows(0)("num_asientos").ToString()
            Else
                txtNumeroAsientosb.Text = ""
            End If
        Else
            txtNumeroAsientosb.Text = ""
        End If
    End Sub



    ' Validar que la suma de los asientos en A, B, C, D sea igual al total de la sala
    Private Function ValidarDistribucionButacas() As Boolean
        If String.IsNullOrEmpty(txtNumeroAsientosb.Text) Then
            Return False
        End If

        Dim totalAsientos As Integer = Convert.ToInt32(txtNumeroAsientosb.Text)
        Dim asientosA As Integer = If(String.IsNullOrEmpty(txtNombreButacaA.Text), 0, Convert.ToInt32(txtNombreButacaA.Text))
        Dim asientosB As Integer = If(String.IsNullOrEmpty(txtNombreButacaB.Text), 0, Convert.ToInt32(txtNombreButacaB.Text))
        Dim asientosC As Integer = If(String.IsNullOrEmpty(txtNombreButacaC.Text), 0, Convert.ToInt32(txtNombreButacaC.Text))
        Dim asientosD As Integer = If(String.IsNullOrEmpty(txtNombreButacaD.Text), 0, Convert.ToInt32(txtNombreButacaD.Text))

        Dim sumaButacas As Integer = asientosA + asientosB + asientosC + asientosD
        Return sumaButacas = totalAsientos
    End Function


    ' Botón para agregar Butacas
    Protected Sub btnAgregarButaca_Click(sender As Object, e As EventArgs) Handles btnAgregarButaca.Click
        If ddlSala.SelectedValue = "0" OrElse Not ValidarDistribucionButacas() Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error: La suma de asientos no coincide con el número total de asientos de la sala.');", True)
            Return
        End If

        Dim salaId As Integer = Convert.ToInt32(ddlSala.SelectedValue)
        Dim asientosA As Integer = If(String.IsNullOrEmpty(txtNombreButacaA.Text), 0, Convert.ToInt32(txtNombreButacaA.Text))
        Dim asientosB As Integer = If(String.IsNullOrEmpty(txtNombreButacaB.Text), 0, Convert.ToInt32(txtNombreButacaB.Text))
        Dim asientosC As Integer = If(String.IsNullOrEmpty(txtNombreButacaC.Text), 0, Convert.ToInt32(txtNombreButacaC.Text))
        Dim asientosD As Integer = If(String.IsNullOrEmpty(txtNombreButacaD.Text), 0, Convert.ToInt32(txtNombreButacaD.Text))

        ' Agregar butacas por cada fila (A, B, C, D)
        AgregarButacasFila("A", asientosA, salaId)
        AgregarButacasFila("B", asientosB, salaId)
        AgregarButacasFila("C", asientosC, salaId)
        AgregarButacasFila("D", asientosD, salaId)

        ' Actualizar la tabla de Butacas y limpiar campos
        ListarButaca()
        LimpiarFormularioButacas()
    End Sub

    ' Método para agregar butacas por fila
    Private Sub AgregarButacasFila(fila As String, cantidad As Integer, salaId As Integer)
        For i As Integer = 1 To cantidad
            Dim nombreButaca As String = fila & i.ToString()
            objButaca.guardarButaca(nombreButaca, salaId)
        Next
    End Sub

    ' Modificar una Butaca existente
    Protected Sub btnModificarButaca_Click(sender As Object, e As EventArgs) Handles btnModificarButaca.Click
        If txtIdButacaV.Text <> "" And txtNombreButacaV.Text.Trim() <> "" And ddlSalaV.SelectedValue <> "0" Then
            objButaca.modificarButaca(CInt(txtIdButacaV.Text), txtNombreButacaV.Text.Trim(), CInt(ddlSalaV.SelectedValue))
            ListarButaca()
        End If
        LimpiarFormularioButacas()
        LimpiarButacaV()
    End Sub

    ' Eliminar una Butaca
    Protected Sub btnEliminarButaca_Click(sender As Object, e As EventArgs) Handles btnEliminarButaca.Click
        If txtIdButacaV.Text <> "" Then
            objButaca.eliminarButaca(CInt(txtIdButacaV.Text))
            ListarButaca()
        End If
        LimpiarFormularioButacas()
        LimpiarButacaV()
    End Sub

    ' Limpiar campos de Butacas
    Protected Sub btnLimpiarButaca_Click(sender As Object, e As EventArgs) Handles btnLimpiarButaca.Click
        LimpiarButacaV()
        LimpiarFormularioButacas()
    End Sub

    ' Limpiar formulario de Butacas
    Private Sub LimpiarFormularioButacas()
        txtNombreButacaA.Text = ""
        txtNombreButacaB.Text = ""
        txtNombreButacaC.Text = ""
        txtNombreButacaD.Text = ""
        ddlSala.SelectedIndex = 0
        txtNumeroAsientosb.Text = ""
    End Sub


    Protected Sub gvButacas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvButacas.SelectedIndexChanged
        Dim row As GridViewRow = gvButacas.SelectedRow
        txtIdButacaV.Text = row.Cells(1).Text
        ddlSalaV.SelectedValue = row.Cells(3).Text
        ddlSalaV.Enabled = True
        txtNombreButacaV.Text = row.Cells(2).Text
        txtNombreButacaV.Enabled = True
        btnModificarButaca.Enabled = True
        btnEliminarButaca.Enabled = True
        btnAgregarButaca.Enabled = False
    End Sub

    Private Sub LimpiarButacaV()
        txtIdButacaV.Text = ""
        txtNombreButacaV.Text = ""
        txtNombreButacaV.Enabled = False
        ddlSalaV.SelectedIndex = 0
        ddlSalaV.Enabled = False
        btnModificarButaca.Enabled = False
        btnEliminarButaca.Enabled = False
        btnAgregarButaca.Enabled = True
    End Sub

End Class
