Imports System.Data
Imports System.Data.SqlClient
Imports capaNegocio

Public Class cines
    Inherits System.Web.UI.Page

    Dim ubigeo As New clsUbigeo()
    Dim cine As New clsCine()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlProvincia.Items.Insert(0, New ListItem("--Seleccione Provincia--", ""))
            ddlDistrito.Items.Insert(0, New ListItem("--Seleccione Distrito--", ""))
            CargarDepartamentos()
            CargarCines()
        End If
    End Sub

    Private Sub CargarDepartamentos()
        Try
            Dim dt As DataTable = ubigeo.ObtenerDepartamentos()
            ddlDepartamento.DataSource = dt
            ddlDepartamento.DataTextField = "departamento"
            ddlDepartamento.DataValueField = "departamento"
            ddlDepartamento.DataBind()
            ddlDepartamento.Items.Insert(0, New ListItem("--Seleccione Departamento--", ""))

            ' Aseguramos que Provincia y Distrito tengan sus opciones predeterminadas
            ddlProvincia.Items.Clear()
            ddlProvincia.Items.Insert(0, New ListItem("--Seleccione Provincia--", ""))
            ddlDistrito.Items.Clear()
            ddlDistrito.Items.Insert(0, New ListItem("--Seleccione Distrito--", ""))
        Catch ex As Exception
            ' Manejo de errores
        End Try
    End Sub


    Private Sub CargarProvincias(departamento As String)
        Try
            Dim dt As DataTable = ubigeo.ObtenerProvinciasPorDepartamento(departamento)
            ddlProvincia.DataSource = dt
            ddlProvincia.DataTextField = "provincia"
            ddlProvincia.DataValueField = "provincia"
            ddlProvincia.DataBind()
            ddlProvincia.Items.Insert(0, New ListItem("--Seleccione Provincia--", "")) ' Añadir opción predeterminada
            ddlDistrito.Items.Clear()
            ddlDistrito.Items.Insert(0, New ListItem("--Seleccione Distrito--", "")) ' Limpia el DropDownList de Distrito y añade opción predeterminada
        Catch ex As Exception
            ' Manejo de errores
        End Try
    End Sub

    Private Sub CargarDistritos(provincia As String)
        Try
            Dim dt As DataTable = ubigeo.ObtenerDistritosPorProvincia(provincia)
            ddlDistrito.DataSource = dt
            ddlDistrito.DataTextField = "distrito"
            ddlDistrito.DataValueField = "distrito"
            ddlDistrito.DataBind()
            ddlDistrito.Items.Insert(0, New ListItem("--Seleccione Distrito--", ""))
        Catch ex As Exception
            ' Manejo de errores
        End Try
    End Sub

    Protected Sub ddlDepartamento_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDepartamento.SelectedIndexChanged
        If ddlDepartamento.SelectedIndex > 0 Then

            CargarProvincias(ddlDepartamento.SelectedValue)
            upProvincia.Update() ' Actualiza el UpdatePanel de provincia
            upDistrito.Update()  ' Limpia el UpdatePanel de distrito

        Else
            ddlProvincia.Items.Clear()
            ddlProvincia.Items.Insert(0, New ListItem("--Seleccione Provincia--", ""))
            ddlDistrito.Items.Clear()
            ddlDistrito.Items.Insert(0, New ListItem("--Seleccione Distrito--", ""))
            upProvincia.Update() ' Actualiza el UpdatePanel de provincia
            upDistrito.Update()  ' Actualiza el UpdatePanel de distrito
        End If
    End Sub

    Protected Sub ddlProvincia_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlProvincia.SelectedIndexChanged
        If ddlProvincia.SelectedIndex > 0 Then
            CargarDistritos(ddlProvincia.SelectedValue)
            upDistrito.Update() ' Actualiza el UpdatePanel de distrito
        Else
            ddlDistrito.Items.Clear()
            ddlDistrito.Items.Insert(0, New ListItem("--Seleccione Distrito--", ""))
            upDistrito.Update() ' Actualiza el UpdatePanel de distrito
        End If
    End Sub



    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            ' Obtener valores del formulario
            Dim nombre As String = txtNombreCine.Text
            Dim cantSalas As Integer = Convert.ToInt32(txtCantSalas.Text)
            Dim direccion As String = txtDireccion.Text
            Dim departamento As String = ddlDepartamento.SelectedValue
            Dim provincia As String = ddlProvincia.SelectedValue
            Dim distrito As String = ddlDistrito.SelectedValue
            Dim enlaceImagen As String = ""

            ' Verificar si los combos de Ubigeo están seleccionados
            If ddlDepartamento.SelectedIndex = 0 OrElse ddlProvincia.SelectedIndex = 0 OrElse ddlDistrito.SelectedIndex = 0 Then
                ' Mostrar mensaje de error si no están seleccionados todos los campos de Ubigeo
                ShowAlert("Por favor, seleccione el Departamento, Provincia y Distrito.")
                Return
            End If

            ' Obtener idUbigeo
            Dim idUbigeo As Integer = ubigeo.ObtenerIdUbigeo(departamento, provincia, distrito)

            ' Guardar la imagen si se seleccionó un archivo
            If fuImagen.HasFile Then
                enlaceImagen = fuImagen.FileName
                Dim rutaDestino As String = Server.MapPath("~/recursos/" & enlaceImagen)

                ' Crear la carpeta si no existe
                Dim directorio As String = Server.MapPath("~/recursos/")
                If Not IO.Directory.Exists(directorio) Then
                    IO.Directory.CreateDirectory(directorio)
                End If

                ' Guardar el archivo en la carpeta especificada
                fuImagen.SaveAs(rutaDestino)
            Else
                ShowAlert("Por favor, seleccione una imagen antes de guardar.")
                Return
            End If

            ' Verificar si estamos en modo de agregar o editar
            If ViewState("idCine") Is Nothing Then
                ' Modo agregar
                Dim resultado As Boolean = cine.RegistrarCine(nombre, cantSalas, direccion, enlaceImagen, idUbigeo)
                If resultado Then
                    ShowAlert("Cine registrado correctamente.", "success")
                Else
                    ShowAlert("Error al registrar el cine.", "danger")
                End If
            Else
                ' Modo edición
                Dim idCine As Integer = Convert.ToInt32(ViewState("idCine"))
                Dim resultado As Boolean = cine.ModificarCine(idCine, nombre, cantSalas, direccion, enlaceImagen, idUbigeo)
                If resultado Then
                    ShowAlert("Cine modificado correctamente.", "success")
                Else
                    ShowAlert("Error al modificar el cine.", "danger")
                End If

                ' Limpiar el ViewState después de editar
                ViewState.Remove("idCine")
            End If

            ' Ocultar panel de edición y recargar el GridView
            panelEditar.Visible = False
            CargarCines()
        Catch ex As Exception
            ShowAlert("Error: " & ex.Message, "danger")
        End Try
    End Sub


    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        ' Mostrar el panel de edición y limpiar los campos del formulario
        panelEditar.Visible = True
        txtNombreCine.Text = ""
        txtCantSalas.Text = ""
        txtDireccion.Text = ""
        ddlDepartamento.SelectedIndex = 0
        ddlProvincia.Items.Clear()
        ddlDistrito.Items.Clear()
    End Sub

    Protected Sub gvCines_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvCines.RowEditing
        ' Obtén el ID del cine de la fila seleccionada
        Dim idCine As Integer = Convert.ToInt32(gvCines.DataKeys(e.NewEditIndex).Value)

        ' Llama a una función que carga los datos del cine en los controles del panelEditar
        CargarDatosCine(idCine)

        ' Muestra el panel de edición
        panelEditar.Visible = True
    End Sub

    Private Sub CargarDatosCine(idCine As Integer)

    End Sub



    Private Sub CargarCines()
        gvCines.DataSource = cine.ObtenerCines()
        gvCines.DataBind()
    End Sub

    Protected Sub gvCines_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvCines.RowUpdating
        ' Obtener el ID del cine que se está editando
        Dim idCine As Integer = Convert.ToInt32(gvCines.DataKeys(e.RowIndex).Value)

        ' Obtener los nuevos valores de los controles en la fila en edición
        Dim row As GridViewRow = gvCines.Rows(e.RowIndex)
        Dim nombre As String = CType(row.FindControl("txtNombre"), TextBox).Text
        Dim cantSalas As Integer = Convert.ToInt32(CType(row.FindControl("txtCantSalas"), TextBox).Text)
        Dim direccion As String = CType(row.FindControl("txtDireccion"), TextBox).Text
        Dim enlaceImagen As String = CType(row.FindControl("txtEnlaceImagen"), TextBox).Text
        Dim idUbigeo As Integer = Convert.ToInt32(CType(row.FindControl("txtIdUbigeo"), TextBox).Text)

        ' Actualizar los datos en la base de datos
        Dim objCine As New clsCine()
        If objCine.ModificarCine(idCine, nombre, cantSalas, direccion, enlaceImagen, idUbigeo) Then
            ' Cancelar el modo de edición
            gvCines.EditIndex = -1
            ' Recargar el GridView con los datos actualizados
            CargarCines()
        Else
            ' Mostrar un mensaje de error si la actualización falla
            ' Asegúrate de tener un control de etiqueta para mostrar mensajes en el archivo ASPX si deseas implementar esto
        End If
    End Sub

    Protected Sub gvCines_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles gvCines.RowCancelingEdit
        ' Cancelar el modo de edición
        gvCines.EditIndex = -1
        ' Volver a cargar el GridView para mostrar los datos sin cambios
        CargarCines()
    End Sub

    Protected Sub gvCines_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCines.RowCommand
        ' Verifica el nombre del comando para saber qué acción ejecutar
        If e.CommandName = "Eliminar" Then
            ' Convertir el argumento del comando a un Integer que representa el ID del cine
            Dim idCine As Integer = Convert.ToInt32(e.CommandArgument)

            ' Lógica para eliminar el cine
            EliminarCine(idCine)
            ' Recargar el GridView después de eliminar
            CargarCines()

        ElseIf e.CommandName = "Ver" Then
            ' Aquí puedes agregar la lógica para ver detalles del cine
            Dim idCine As Integer = Convert.ToInt32(e.CommandArgument)
            VerDetallesCine(idCine)
        End If
    End Sub

    ' Método auxiliar para eliminar cine
    Private Sub EliminarCine(idCine As Integer)
        Try
            ' Supongamos que tienes una función en tu clase `clsCine` para eliminar el cine por su ID
            Dim objCine As New clsCine()
            If objCine.EliminarCine(idCine) Then
                ' Opcional: mensaje de éxito
            End If
        Catch ex As Exception
            ' Opcional: manejo del error
        End Try
    End Sub

    ' Método auxiliar para ver detalles de cine (Ejemplo)
    Private Sub VerDetallesCine(idCine As Integer)
        ' Aquí puedes agregar la lógica para mostrar los detalles del cine
        ' Ejemplo: mostrar en un panel o en un modal
    End Sub

    Protected Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        ' Oculta el panel de edición
        panelEditar.Visible = False

        ' Limpia los campos de texto si es necesario
        LimpiarCampos()
    End Sub

    ' Método auxiliar para limpiar los campos del formulario
    Private Sub LimpiarCampos()
        txtNombreCine.Text = ""
        txtCantSalas.Text = ""
        txtDireccion.Text = ""
        ddlDepartamento.SelectedIndex = 0
        ddlProvincia.Items.Clear()
        ddlDistrito.Items.Clear()
    End Sub
    Private Sub ShowAlert(mensaje As String, Optional tipo As String = "warning")
        alertContainer.Attributes("class") = "alert alert-" & tipo & " alert-dismissible fade show"
        alertMessage.InnerText = mensaje
        alertContainer.Style("display") = "block"
    End Sub


End Class
