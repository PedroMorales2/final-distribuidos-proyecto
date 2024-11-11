Imports capaNegocio
Public Class pelicula
    Inherits System.Web.UI.Page

    Dim clsPelicula As New clsPelicula

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            listar()
            LlenarComboDirectores()
            LlenarComboGeneros()
        End If
    End Sub

    Protected Sub listar()
        gvPelicula.DataSource = clsPelicula.retornar_peliculas()
        gvPelicula.DataBind()
    End Sub

    Private Sub LlenarComboDirectores()
        Try
            Dim dtDirectores As DataTable = clsPelicula.retornar_directores()
            ddlDirectores.DataSource = dtDirectores
            ddlDirectores.DataTextField = "nombre completo" ' El nombre de la columna en el DataTable
            ddlDirectores.DataValueField = "id_director"
            ddlDirectores.DataBind()
            ddlDirectores.Items.Insert(0, New ListItem("-- Seleccione Director --", ""))
        Catch ex As Exception
            ' Manejo de errores
            Throw New Exception("Error al llenar el combobox de directores: " & ex.Message)
        End Try
    End Sub

    Private Sub LlenarComboGeneros()
        Try
            Dim dtGeneros As DataTable = clsPelicula.retornar_genero()
            ddlGeneros.DataSource = dtGeneros
            ddlGeneros.DataTextField = "nombre_genero" ' El nombre de la columna en el DataTable
            ddlGeneros.DataValueField = "id_pelicula"
            ddlGeneros.DataBind()
            ddlGeneros.Items.Insert(0, New ListItem("-- Seleccione Género --", ""))
        Catch ex As Exception
            ' Manejo de errores
            Throw New Exception("Error al llenar el combobox de géneros: " & ex.Message)
        End Try
    End Sub

    Protected Sub GuardarPelicula(ByVal sender As Object, ByVal e As EventArgs)
        Try
            ' Obtener valores de los controles en el formulario
            Dim nombrePelicula As String = txtNombrePelicula.Text
            Dim estreno As Boolean = chkEstreno.Checked ' Obtener el valor booleano de Estreno
            Dim duracion As Integer = Convert.ToInt32(txtDuracion.Text)
            Dim clasificacionEdad As String = txtClasificacionEdad.Text
            Dim sinopsis As String = txtSinopsis.Text
            Dim vigencia As Boolean = chkVigencia.Checked ' Obtener el valor booleano de Vigencia

            ' Obtener valores de los comboboxes
            Dim idDirector As Integer = Convert.ToInt32(ddlDirectores.SelectedValue)
            Dim idGenero As Integer = Convert.ToInt32(ddlGeneros.SelectedValue)

            ' Guardar la imagen
            Dim nombreArchivo As String = ""
            If filePoster.HasFile Then
                Dim rutaCarpeta As String = Server.MapPath("~/image_pelicula/")
                If Not System.IO.Directory.Exists(rutaCarpeta) Then
                    System.IO.Directory.CreateDirectory(rutaCarpeta)
                End If
                nombreArchivo = System.IO.Path.GetFileName(filePoster.FileName)
                filePoster.SaveAs(System.IO.Path.Combine(rutaCarpeta, nombreArchivo))
            Else
                Throw New Exception("Por favor seleccione una imagen para el poster.")
            End If

            ' Llamar al método de registro en la base de datos
            Dim exito As Boolean = clsPelicula.registrar_pelicula(nombrePelicula, duracion, clasificacionEdad, sinopsis, nombreArchivo, estreno, vigencia, idDirector, idGenero)

            If exito Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Success", "alert('Película guardada exitosamente');", True)
                listar()
            Else
                Throw New Exception("No se pudo registrar la película en la base de datos.")
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Error", "alert('Error al guardar la película: " & ex.Message & "');", True)
        End Try
    End Sub



End Class
