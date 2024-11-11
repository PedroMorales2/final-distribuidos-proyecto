Imports System.Data
Imports System.Data.SqlClient


Public Class mant
    Dim objConecta As New conection
    Dim cm As New SqlCommand

    'Insertar, actualizar y eliminar
    Sub ejecutarComando(strConsulta As String)
        Try
            objConecta.AbrirConexion()
            cm.Connection = objConecta.MiConexion
            cm.CommandText = strConsulta
            cm.ExecuteNonQuery()
        Catch ex As Exception
            Throw New Exception("Error al realizar la operación: " & ex.Message)
        Finally
            objConecta.CerrarConexion() ' Asegurarse de cerrar la conexión
        End Try
    End Sub



    'Seleccionar
    Public Function listarComando(strConsulta As String) As DataTable
        Dim dt As New DataTable
        Dim da As SqlDataAdapter
        Try
            objConecta.AbrirConexion()
            da = New SqlDataAdapter(strConsulta, objConecta.MiConexion)
            da.Fill(dt)
            Return dt
        Catch ex As Exception
            Throw New Exception("Error al realizar la consulta: " & ex.Message)
        Finally
            objConecta.CerrarConexion() ' Asegurarse de cerrar la conexión
        End Try
    End Function

    Public Function listarComando(Optional strConsulta As String = "", Optional strConsulta1 As String = "") As DataSet
        Dim ds As New DataSet
        Dim da As SqlDataAdapter
        Try
            objConecta.AbrirConexion()
            da = New SqlDataAdapter(strConsulta, objConecta.MiConexion)
            da.Fill(ds, "Tabla1")
            Return ds
        Catch ex As Exception
            Throw New Exception("Error al realizar la consulta: " & ex.Message)
        Finally
            objConecta.CerrarConexion() ' Asegurarse de cerrar la conexión
        End Try
    End Function

    Public Function ejecutarComandosTransaccion(comandos As List(Of String)) As Boolean
        Dim transaction As SqlTransaction = Nothing

        Try
            objConecta.AbrirConexion()
            transaction = objConecta.MiConexion.BeginTransaction()
            cm.Connection = objConecta.MiConexion
            cm.Transaction = transaction

            For Each comando In comandos
                cm.CommandText = comando
                cm.ExecuteNonQuery()
            Next

            ' Si todo se ejecuta correctamente, confirmar la transacción
            transaction.Commit()
            Return True
        Catch ex As Exception
            ' Si ocurre un error, revertir la transacción
            If transaction IsNot Nothing Then
                transaction.Rollback()
            End If
            Throw New Exception("Error al ejecutar la transacción: " & ex.Message)
        Finally
            objConecta.CerrarConexion() ' Asegurarse de cerrar la conexión
        End Try
    End Function
End Class
