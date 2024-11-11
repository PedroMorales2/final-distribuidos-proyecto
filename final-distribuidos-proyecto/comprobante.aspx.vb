Imports System.Data
Imports capaNegocio
Imports negocio

Public Class comprobante
    Inherits System.Web.UI.Page

    Dim objComprobante As New clsComprobante()
    Dim obj As New clsS()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ListarComprobantes() ' Llamar a la función para listar comprobantes al cargar la página
            CargarTicketsDisponibles()
            CargarVentasDisponibles()
            CargarFormasDePago()
            txtFechaEmisionPanel.Text = DateTime.Now.ToString("yyyy-MM-dd")
        End If
    End Sub

    Private Sub CargarTicketsDisponibles()
        Dim dtTickets As DataTable = obj.ObtenerTicketsSinComprobante()
        ddlIdTicket.DataSource = dtTickets
        ddlIdTicket.DataTextField = "id_ticket"
        ddlIdTicket.DataValueField = "id_ticket"
        ddlIdTicket.DataBind()
        ddlIdTicket.Items.Insert(0, New ListItem("-- Seleccionar Ticket --", ""))
    End Sub

    Private Sub CargarVentasDisponibles()
        Dim dtVentas As DataTable = obj.ObtenerVentasSinComprobante()
        ddlIdVenta.DataSource = dtVentas
        ddlIdVenta.DataTextField = "id_venta"
        ddlIdVenta.DataValueField = "id_venta"
        ddlIdVenta.DataBind()
        ddlIdVenta.Items.Insert(0, New ListItem("-- Seleccionar Venta --", ""))
    End Sub

    Private Sub CargarFormasDePago()
        Dim dtFormasPago As DataTable = obj.ObtenerFormasPago()
        ddlIdForma.DataSource = dtFormasPago
        ddlIdForma.DataTextField = "nombre"
        ddlIdForma.DataValueField = "id_forma"
        ddlIdForma.DataBind()
        ddlIdForma.Items.Insert(0, New ListItem("-- Seleccionar Forma de Pago --", ""))
    End Sub

    Protected Sub ddlIdTicket_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlIdTicket.SelectedIndexChanged
        Try
            If Not String.IsNullOrEmpty(ddlIdTicket.SelectedValue) Then
                Dim idTicket As Integer = Convert.ToInt32(ddlIdTicket.SelectedValue)
                Dim dtTicket As DataTable = obj.ObtenerTicketPorID(idTicket)

                If dtTicket.Rows.Count > 0 Then
                    ' Ejemplo de cómo obtener el campo "subtotal" del ticket seleccionado
                    Dim subtotal As Decimal = Convert.ToDecimal(dtTicket.Rows(0)("subtotal"))
                    ' Aquí puedes continuar con los cálculos u operaciones necesarias
                    txtSubtotalPanel.Text = subtotal.ToString("F2")
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al seleccionar el ticket: " & ex.Message & "');", True)
        End Try
    End Sub


    Protected Sub ddlIdVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlIdVenta.SelectedIndexChanged
        CalcularTotales()
    End Sub

    Private Sub CalcularTotales()
        Dim subtotal As Decimal = 0

        ' Obtener subtotal del Ticket seleccionado
        If Not String.IsNullOrEmpty(ddlIdTicket.SelectedValue) Then
            Dim dtTicket As DataTable = obj.ObtenerTicketPorID(Convert.ToInt32(ddlIdTicket.SelectedValue))
            If dtTicket.Rows.Count > 0 Then
                subtotal += Convert.ToDecimal(dtTicket.Rows(0)("subtotal"))
            End If
        End If

        ' Obtener subtotal de la Venta seleccionada
        If Not String.IsNullOrEmpty(ddlIdVenta.SelectedValue) Then
            Dim dtVenta As DataTable = obj.ObtenerVentaPorID(Convert.ToInt32(ddlIdVenta.SelectedValue))
            If dtVenta.Rows.Count > 0 Then
                subtotal += Convert.ToDecimal(dtVenta.Rows(0)("subtotal"))
            End If
        End If

        ' Calcular impuesto y total
        Dim impuesto As Decimal = subtotal * 0.18D
        Dim total As Decimal = subtotal + impuesto

        ' Asignar valores a los campos
        txtSubtotalPanel.Text = subtotal.ToString("F2")
        txtImpuestoPanel.Text = impuesto.ToString("F2")
        txtTotalPanel.Text = total.ToString("F2")
    End Sub

    ' Evento para mostrar el panel de edición en modo "Agregar"
    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        LimpiarFormulario()
        lblTitulo.Text = "Agregar Nuevo Comprobante"
        panelEditar.Visible = True
        ViewState("EditMode") = False ' Indicamos que estamos en modo de inserción
    End Sub

    ' Guardar comprobante (Agregar o Editar)
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            ' Variables para capturar los datos del formulario
            Dim total As Decimal = Decimal.Parse(txtTotalPanel.Text)
            Dim impuesto As Decimal = Decimal.Parse(txtImpuestoPanel.Text)
            Dim subtotal As Decimal = Decimal.Parse(txtSubtotalPanel.Text)
            Dim fechaEmision As Date = Date.Parse(txtFechaEmisionPanel.Text)
            Dim idTicket As Integer? = If(String.IsNullOrEmpty(ddlIdTicket.SelectedValue), CType(Nothing, Integer?), Integer.Parse(ddlIdTicket.SelectedValue))
            Dim idVenta As Integer? = If(String.IsNullOrEmpty(ddlIdVenta.SelectedValue), CType(Nothing, Integer?), Integer.Parse(ddlIdVenta.SelectedValue))
            Dim idFormaPago As Integer = Integer.Parse(ddlIdForma.SelectedValue)

            If ViewState("EditMode") = False Then
                ' Agregar nuevo comprobante
                If objComprobante.RegistrarComprobante(total, impuesto, subtotal, fechaEmision, idTicket, idVenta, idFormaPago) Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Comprobante registrado correctamente.');", True)
                End If
            Else
                ' Editar comprobante existente
                Dim idComprobante As Integer = Convert.ToInt32(ViewState("id_comprobante"))
                If objComprobante.ModificarComprobante(idComprobante, total, impuesto, subtotal, fechaEmision, idTicket, idVenta, idFormaPago) Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Comprobante actualizado correctamente.');", True)
                End If
            End If
            CargarTicketsDisponibles()
            CargarVentasDisponibles()
            CargarFormasDePago()
            ListarComprobantes()
            panelEditar.Visible = False
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al guardar el comprobante: " & ex.Message & "');", True)
        End Try
    End Sub

    ' Método para listar los comprobantes en el GridView
    Private Sub ListarComprobantes()
        Try
            ' Obtener la lista de comprobantes desde la capa de negocio
            Dim dt As DataTable = objComprobante.ObtenerComprobantes()

            ' Asignar el DataTable como origen de datos del GridView y enlazar los datos
            grvComprobante.DataSource = dt
            grvComprobante.DataBind()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al listar los comprobantes: " & ex.Message & "');", True)
        End Try
    End Sub

    ' Cancelar edición y ocultar el panel
    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        LimpiarFormulario()
        panelEditar.Visible = False
    End Sub

    ' Evento de edición en el GridView
    Protected Sub grvComprobante_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles grvComprobante.RowEditing
        ' Aquí puedes implementar la lógica para editar un comprobante si es necesario
    End Sub

    ' Cancelar edición en el GridView
    Protected Sub grvComprobante_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles grvComprobante.RowCancelingEdit
        grvComprobante.EditIndex = -1
        ListarComprobantes()
    End Sub

    ' Evento de comando en el GridView para eliminar comprobantes
    Protected Sub grvComprobante_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvComprobante.RowCommand
        If e.CommandName = "Eliminar" Then
            Dim idComprobante As Integer = Convert.ToInt32(e.CommandArgument)
            Try
                If objComprobante.EliminarComprobante(idComprobante) Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Comprobante eliminado correctamente.');", True)
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al eliminar el comprobante.');", True)
                End If
                ListarComprobantes()
            Catch ex As Exception
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al eliminar el comprobante: " & ex.Message & "');", True)
            End Try
        End If
    End Sub

    ' Método para limpiar los controles del formulario de edición
    Private Sub LimpiarFormulario()
        txtTotalPanel.Text = ""
        txtImpuestoPanel.Text = ""
        txtSubtotalPanel.Text = ""
        txtFechaEmisionPanel.Text = DateTime.Now.ToString("yyyy-MM-dd")
        ddlIdTicket.ClearSelection()
        ddlIdVenta.ClearSelection()
        ddlIdForma.ClearSelection()
    End Sub

    ' Evento para manejar selección en el GridView
    Protected Sub grvComprobante_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grvComprobante.SelectedIndexChanged
        ' Maneja la selección si es necesario
    End Sub

    Protected Sub grvComprobante_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles grvComprobante.RowUpdating
        ' Deja este método vacío si no tienes lógica específica para RowUpdating
    End Sub

End Class
