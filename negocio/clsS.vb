Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Security
Imports dato

Public Class clsS
    Dim conexion As New conection()
    Dim objMan As New mant
    Dim strSQL As String



    Public Function ObtenerCinePorID(idCine As Integer) As DataTable
        Try
            Dim query As String = "SELECT * FROM Cine WHERE id_cine = @id_cine"
            Dim parametros As New List(Of SqlParameter) From {
            New SqlParameter("@id_cine", idCine)
        }
            Return conexion.EjecutarConsulta(query, parametros)
        Catch ex As Exception
            Throw New Exception("Error al obtener el cine: " & ex.Message)
        End Try
    End Function


    Public Function ObtenerTickets() As DataTable
        Dim query As String = "SELECT id_ticket, subtotal FROM Ticket"
        Return objMan.listarComando(query)
    End Function

    Public Function ObtenerVentas() As DataTable
        Dim query As String = "SELECT id_venta, subtotal FROM Venta_dulce"
        Return objMan.listarComando(query)
    End Function

    Public Function ObtenerFormasPago() As DataTable
        Dim query As String = "SELECT id_forma, nombre FROM Forma_pago"
        Return objMan.listarComando(query)
    End Function

    ' Método para obtener tickets sin comprobante
    Public Function ObtenerTicketsSinComprobante() As DataTable
        Dim query As String = "SELECT id_ticket FROM Ticket WHERE id_ticket NOT IN (SELECT id_ticket FROM Comprobante WHERE id_ticket IS NOT NULL)"
        Return objMan.listarComando(query)
    End Function

    ' Método para obtener ventas sin comprobante
    Public Function ObtenerVentasSinComprobante() As DataTable
        Dim query As String = "SELECT id_venta FROM Venta_dulce WHERE id_venta NOT IN (SELECT id_venta FROM Comprobante WHERE id_venta IS NOT NULL)"
        Return objMan.listarComando(query)
    End Function

    Public Function ObtenerVentaPorID(idVenta As Integer) As DataTable
        Try
            Dim query As String = "SELECT * FROM Venta_dulce WHERE id_venta = @id_venta"
            Dim parametros As New List(Of SqlParameter) From {
            New SqlParameter("@id_venta", idVenta)
        }
            Return conexion.EjecutarConsulta(query, parametros)
        Catch ex As Exception
            Throw New Exception("Error al obtener la venta: " & ex.Message)
        End Try
    End Function


    Public Function ObtenerTicketPorID(idTicket As Integer) As DataTable
        Try
            Dim query As String = "SELECT * FROM Ticket WHERE id_ticket = @id_ticket"
            Dim parametros As New List(Of SqlParameter) From {
            New SqlParameter("@id_ticket", idTicket)
        }
            Return conexion.EjecutarConsulta(query, parametros)
        Catch ex As Exception
            Throw New Exception("Error al obtener el ticket: " & ex.Message)
        End Try
    End Function


End Class
