Imports capaNegocio
Public Class formatoPelicula
    Inherits System.Web.UI.Page

    Dim objFormato As New clsFormatoPeliculaPedro

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CargarDatos()
            CargarPeliculas()
            CargarIdiomas()
            CargarFormatos()
            CargarPaises()
        End If
    End Sub

    Private Sub CargarDatos()
        gvFormatoPelicula.DataSource = objFormato.ObtenerFormatoPelicula()
        gvFormatoPelicula.DataBind()
    End Sub

    Private Sub CargarPeliculas()
        ddlModalNombrePelicula.DataSource = objFormato.ObtenerPeliculas()
        ddlModalNombrePelicula.DataTextField = "nombre_pelicula"
        ddlModalNombrePelicula.DataValueField = "id_pelicula"
        ddlModalNombrePelicula.DataBind()
    End Sub

    Private Sub CargarIdiomas()
        ddlModalIdioma.DataSource = objFormato.ObtenerIdiomas()
        ddlModalIdioma.DataTextField = "nombre_idioma"
        ddlModalIdioma.DataValueField = "id_idioma"
        ddlModalIdioma.DataBind()
    End Sub

    Private Sub CargarFormatos()
        ddlModalFormato.DataSource = objFormato.ObtenerFormatos()
        ddlModalFormato.DataTextField = "nombre_formato"
        ddlModalFormato.DataValueField = "id_formato"
        ddlModalFormato.DataBind()
    End Sub

    Private Sub CargarPaises()
        ddlModalPais.DataSource = objFormato.ObtenerPais()
        ddlModalPais.DataTextField = "nombre_pais"
        ddlModalPais.DataValueField = "id_pais"
        ddlModalPais.DataBind()
    End Sub

    Protected Sub btnGuardarFormato_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            ' Obtener los valores seleccionados en los DropDownList
            Dim idPelicula As Integer = Convert.ToInt32(ddlModalNombrePelicula.SelectedValue)
            Dim idIdioma As Integer = Convert.ToInt32(ddlModalIdioma.SelectedValue)
            Dim idFormato As Integer = Convert.ToInt32(ddlModalFormato.SelectedValue)
            Dim idPais As Integer = Convert.ToInt32(ddlModalPais.SelectedValue)

            ' Llamar al método de negocio para agregar el formato de película
            objFormato.AgregarFormatoPelicula(idPelicula, idIdioma, idFormato, idPais)

            ' Mensaje de éxito o alguna acción adicional si es necesario
            Response.Write("<script>alert('Formato de película agregado con éxito.');</script>")

            ' Recargar datos o actualizar la vista si es necesario
            CargarDatos()
        Catch ex As Exception
            ' Manejar excepciones y mostrar mensaje de error
            Response.Write("<script>alert('Error al agregar el formato de película: " & ex.Message & "');</script>")
        End Try
    End Sub


    Protected Sub gvFormatoPelicula_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Eliminar" Then
            ' Extraer los argumentos separados por coma
            Dim args As String() = e.CommandArgument.ToString().Split(","c)

            ' Asignar los valores de cada argumento
            Dim idPelicula As Integer = Convert.ToInt32(args(0))
            Dim idIdioma As Integer = Convert.ToInt32(args(1))
            Dim idFormato As Integer = Convert.ToInt32(args(2))
            Dim idPais As Integer = Convert.ToInt32(args(3))

            ' Llamar a la función EliminarFormato
            Try
                objFormato.EliminarFormato(idPelicula, idIdioma, idFormato, idPais)
                ' Recargar datos o actualizar vista después de eliminar
                CargarDatos()
                Response.Write("<script>alert('Formato eliminado con éxito.');</script>")
            Catch ex As Exception
                Response.Write("<script>alert('Error al eliminar el formato: " & ex.Message & "');</script>")
            End Try
        End If
    End Sub

End Class
