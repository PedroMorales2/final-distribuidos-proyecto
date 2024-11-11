Imports capaNegocio
Public Class FuncionesProgramadas
    Inherits System.Web.UI.Page

    Dim objFunciones As New clsFuncionesProgramadasPedro
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CargarDatos()
            cargarFormato()
            cargarIdioma()
            cargarPelicula()
            cargarSala()
            cargarCine()
        End If
    End Sub

    Private Sub CargarDatos()
        gvFuncionesProgramadas.DataSource = objFunciones.ListarFuncionesProgramadas()
        gvFuncionesProgramadas.DataBind()
    End Sub

    Private Sub cargarFormato()
        ddlFormato.DataSource = objFunciones.ObtenerFormatos()
        ddlFormato.DataTextField = "nombre_formato"
        ddlFormato.DataValueField = "id_formato"
        ddlFormato.DataBind()
    End Sub

    Private Sub cargarIdioma()
        ddlIdioma.DataSource = objFunciones.ObtenerIdiomas()
        ddlIdioma.DataTextField = "nombre_idioma"
        ddlIdioma.DataValueField = "id_idioma"
        ddlIdioma.DataBind()
    End Sub

    Private Sub cargarPelicula()
        ddlPelicula.DataSource = objFunciones.ObtenerPeliculas()
        ddlPelicula.DataTextField = "nombre_pelicula"
        ddlPelicula.DataValueField = "id_pelicula"
        ddlPelicula.DataBind()
    End Sub

    Private Sub cargarSala()
        ddlSala.DataSource = objFunciones.ObtenerSalas()
        ddlSala.DataTextField = "nombre"
        ddlSala.DataValueField = "id_sala"
        ddlSala.DataBind()
    End Sub

    Private Sub cargarCine()
        ddlCine.DataSource = objFunciones.ObtenerCines()
        ddlCine.DataTextField = "nombre"
        ddlCine.DataValueField = "id_cine"
        ddlCine.DataBind()
    End Sub


    Protected Sub btnGuardarFuncion_Click(sender As Object, e As EventArgs)
        Try
            ' Obtener y convertir los valores de los campos del formulario
            Dim fecha As DateTime = Convert.ToDateTime(txtFecha.Text)
            Dim horaInicio As TimeSpan = TimeSpan.Parse(txtHoraInicio.Text)
            Dim horaFin As TimeSpan = TimeSpan.Parse(txtHoraFin.Text)
            Dim monto As Decimal = Convert.ToDecimal(txtMonto.Text)

            Dim idFormato As Integer = Convert.ToInt32(ddlFormato.SelectedValue)
            Dim idIdioma As Integer = Convert.ToInt32(ddlIdioma.SelectedValue)
            Dim idPelicula As Integer = Convert.ToInt32(ddlPelicula.SelectedValue)
            Dim idSala As Integer = Convert.ToInt32(ddlSala.SelectedValue)
            Dim idCine As Integer = Convert.ToInt32(ddlCine.SelectedValue)

            ' Llamar al método de inserción en la capa de negocio
            Dim resultado As Boolean = objFunciones.InsertarFuncionProgramada(fecha, horaInicio, horaFin, monto, idFormato, idIdioma, idPelicula, idSala, idCine)

            ' Verificar el resultado y mostrar mensaje
            If resultado Then
                Response.Write("<script>alert('Función programada agregada exitosamente.');</script>")
                ' Actualizar datos en el GridView o realizar otras acciones necesarias
                CargarDatos()
            Else
                Response.Write("<script>alert('Error al agregar la función programada.');</script>")
            End If
        Catch ex As Exception
            ' Manejar excepciones y mostrar mensaje de error
            Response.Write("<script>alert('Error: " & ex.Message & "');</script>")
        End Try
    End Sub

End Class