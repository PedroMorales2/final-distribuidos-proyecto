Imports System.Data
Imports capa_datos
Imports capaNegocio

Public Class ticket
    Inherits System.Web.UI.Page

    Dim objTicket As New clsTicket()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ListarTickets()
        End If
    End Sub

    ' Método para listar los tickets en el GridView
    Private Sub ListarTickets()
        Try
            grvTickets.DataSource = objTicket.ObtenerTickets()
            grvTickets.DataBind()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al listar tickets: " & ex.Message & "');", True)
        End Try
    End Sub

    ' Evento al hacer clic en el botón "Agregar Nuevo Ticket"
    Protected Sub btnNuevo_Click(sender As Object, e As EventArgs)
        panelEditar.Visible = True
        lblTitulo.Text = "Agregar Ticket"
        LimpiarFormulario()
    End Sub

    ' Método para limpiar el formulario de edición
    Private Sub LimpiarFormulario()
        txtPrecioPanel.Text = ""
        txtCantidadPanel.Text = ""
        txtDescuentoPanel.Text = ""
        txtSubtotalPanel.Text = ""
        txtIdUsuarioPanel.Text = ""
    End Sub

    ' Evento al hacer clic en el botón "Guardar" en el panel de edición
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs)
        Try
            Dim precio As Decimal = Decimal.Parse(txtPrecioPanel.Text)
            Dim cantidad As Integer = Integer.Parse(txtCantidadPanel.Text)
            Dim id_usuario As Integer = Integer.Parse(txtIdUsuarioPanel.Text)
            Dim descuento As Decimal = objTicket.ObtenerDescuentoPorUsuario(id_usuario)
            Dim subtotal As Decimal = (precio * cantidad) - descuento

            If lblTitulo.Text = "Agregar Ticket" Then
                If objTicket.RegistrarTicket(precio, cantidad, descuento, subtotal, id_usuario) Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Ticket registrado correctamente.');", True)
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al registrar el ticket.');", True)
                End If
            Else
                Dim id_ticket As Integer = Integer.Parse(ViewState("id_ticket").ToString())
                If objTicket.ActualizarTicket(id_ticket, cantidad, precio, descuento, subtotal) Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Ticket actualizado correctamente.');", True)
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al actualizar el ticket.');", True)
                End If
            End If

            ListarTickets()
            panelEditar.Visible = False
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al guardar el ticket: " & ex.Message & "');", True)
        End Try
    End Sub

    ' Evento de edición en el GridView
    Protected Sub grvTickets_RowEditing(sender As Object, e As GridViewEditEventArgs)
        Dim id_ticket As Integer = Convert.ToInt32(grvTickets.DataKeys(e.NewEditIndex).Value)
        Dim dt As DataTable = objTicket.ObtenerTicketPorId(id_ticket)
        If dt.Rows.Count > 0 Then
            Dim row As DataRow = dt.Rows(0)
            txtPrecioPanel.Text = row("precio").ToString()
            txtCantidadPanel.Text = row("cantidad").ToString()
            txtDescuentoPanel.Text = row("descuento").ToString()
            txtSubtotalPanel.Text = row("subtotal").ToString()
            txtIdUsuarioPanel.Text = row("id_usuario").ToString()
            ViewState("id_ticket") = id_ticket
            lblTitulo.Text = "Editar Ticket"
            panelEditar.Visible = True
        End If
    End Sub

    ' Evento para actualizar el ticket en el GridView
    Protected Sub grvTickets_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Try
            Dim id_ticket As Integer = Convert.ToInt32(grvTickets.DataKeys(e.RowIndex).Value)
            Dim cantidad As Integer = Integer.Parse(CType(grvTickets.Rows(e.RowIndex).FindControl("txtCantidad"), TextBox).Text)
            Dim precio As Decimal = Decimal.Parse(CType(grvTickets.Rows(e.RowIndex).FindControl("txtPrecio"), TextBox).Text)
            Dim descuento As Decimal = Decimal.Parse(CType(grvTickets.Rows(e.RowIndex).FindControl("txtDescuento"), TextBox).Text)
            Dim subtotal As Decimal = (precio * cantidad) - descuento

            If objTicket.ActualizarTicket(id_ticket, cantidad, precio, descuento, subtotal) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Ticket actualizado correctamente.');", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al actualizar el ticket.');", True)
            End If

            grvTickets.EditIndex = -1
            ListarTickets()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al actualizar el ticket: " & ex.Message & "');", True)
        End Try
    End Sub

    ' Evento de eliminación en el GridView
    Protected Sub grvTickets_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Eliminar" Then
            Dim id_ticket As Integer = Convert.ToInt32(e.CommandArgument)
            Try
                If objTicket.EliminarTicket(id_ticket) Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Ticket eliminado correctamente.');", True)
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('No se puede eliminar el ticket, ya que está referenciado en otras tablas.');", True)
                End If
                ListarTickets()
            Catch ex As Exception
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al eliminar el ticket: " & ex.Message & "');", True)
            End Try
        End If
    End Sub

    ' Evento para cancelar la edición en el GridView
    Protected Sub grvTickets_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        grvTickets.EditIndex = -1
        ListarTickets()
    End Sub

    ' Evento para manejar la selección de una fila en el GridView
    Protected Sub grvTickets_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim id_ticket As Integer = Convert.ToInt32(grvTickets.SelectedDataKey.Value)
        Dim dt As DataTable = objTicket.ObtenerTicketPorId(id_ticket)
        If dt.Rows.Count > 0 Then
            Dim row As DataRow = dt.Rows(0)
            txtPrecioPanel.Text = row("precio").ToString()
            txtCantidadPanel.Text = row("cantidad").ToString()
            txtDescuentoPanel.Text = row("descuento").ToString()
            txtSubtotalPanel.Text = row("subtotal").ToString()
            txtIdUsuarioPanel.Text = row("id_usuario").ToString()
            ViewState("id_ticket") = id_ticket
            lblTitulo.Text = "Editar Ticket"
            panelEditar.Visible = True
        End If
    End Sub

    ' Evento al cancelar la edición o el agregado de un ticket
    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs)
        panelEditar.Visible = False
        LimpiarFormulario()
    End Sub
End Class
