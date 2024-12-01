Imports System.Data
Imports System.Data.SqlClient

Public Class conection
    Private Const connectionString As String = "workstation id=bd_cine.mssql.somee.com;packet size=4096;user id=grup01Distri2024_SQLLogin_1;pwd=k3lf5a9t2p;data source=bd_cine.mssql.somee.com;persist security info=False;initial catalog=bd_cine;TrustServerCertificate=True"
    Private cn As SqlConnection

    Public Sub New()
        cn = New SqlConnection(connectionString)
    End Sub

    ' Método para verificar la conexión
    Public Function VerificarConexion() As Boolean
        Try
            If cn.State <> ConnectionState.Open Then
                cn.Open()
            End If
            Return True ' Conexión exitosa
        Catch ex As Exception
            Console.WriteLine("Error al conectar: " & ex.Message)
            Return False ' Error en la conexión
        Finally
            If cn.State = ConnectionState.Open Then
                cn.Close() ' Cerrar la conexión después de verificar
            End If
        End Try
    End Function

    ' Método para abrir la conexión
    Public Sub AbrirConexion()
        Try
            If cn.State = ConnectionState.Closed Then
                cn.Open()
            End If
        Catch ex As Exception
            Throw New Exception("Error al abrir la conexión: " & ex.Message)
        End Try
    End Sub

    ' Método para cerrar la conexión
    Public Sub CerrarConexion()
        Try
            If cn.State = ConnectionState.Open Then
                cn.Close()
            End If
        Catch ex As Exception
            Throw New Exception("Error al cerrar la conexión: " & ex.Message)
        End Try
    End Sub

    ' Propiedad para obtener la conexión
    Public ReadOnly Property MiConexion() As SqlConnection
        Get
            Return cn
        End Get
    End Property

    Public Function EjecutarConsulta(query As String, Optional parametros As List(Of SqlParameter) = Nothing) As DataTable
        Dim dt As New DataTable()
        Try
            AbrirConexion()
            Using cmd As New SqlCommand(query, cn)
                ' Añadir parámetros si existen
                If parametros IsNot Nothing Then
                    cmd.Parameters.AddRange(parametros.ToArray())
                End If

                Using da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                End Using
            End Using
        Catch ex As Exception
            Throw New Exception("Error al ejecutar la consulta: " & ex.Message)
        Finally
            CerrarConexion()
        End Try
        Return dt
    End Function

    ' Método para ejecutar comandos INSERT, UPDATE o DELETE
    Public Function EjecutarComando(query As String, Optional parametros As List(Of SqlParameter) = Nothing) As Boolean
        Try
            AbrirConexion()
            Using cmd As New SqlCommand(query, cn)
                ' Añadir parámetros si existen
                If parametros IsNot Nothing Then
                    cmd.Parameters.AddRange(parametros.ToArray())
                End If

                cmd.ExecuteNonQuery()
            End Using
            Return True
        Catch ex As Exception
            Throw New Exception("Error al ejecutar el comando: " & ex.Message)
        Finally
            CerrarConexion()
        End Try
    End Function


    Public Function EjecutarConsultaScalar(query As String, parametros As List(Of SqlParameter)) As Object
        Try
            AbrirConexion()
            Using cmd As New SqlCommand(query, cn)
                ' Añadir parámetros si existen
                If parametros IsNot Nothing Then
                    cmd.Parameters.AddRange(parametros.ToArray())
                End If

                ' Ejecutar la consulta y devolver el resultado
                Return cmd.ExecuteScalar()
            End Using
        Catch ex As Exception
            Throw New Exception("Error al ejecutar la consulta: " & ex.Message)
        Finally
            CerrarConexion()
        End Try
    End Function

    Public Function listarComando_dos(query As String, Optional parametros As List(Of SqlParameter) = Nothing) As DataTable
        Dim dt As New DataTable()
        Try
            AbrirConexion()
            Using cmd As New SqlCommand(query, MiConexion)
                ' Si hay parámetros, se agregan a la consulta
                If parametros IsNot Nothing Then
                    cmd.Parameters.AddRange(parametros.ToArray())
                End If
                Using da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                End Using
            End Using
        Catch ex As Exception
            Throw New Exception("Error al ejecutar la consulta: " & ex.Message)
        Finally
            CerrarConexion()
        End Try
        Return dt
    End Function

End Class
