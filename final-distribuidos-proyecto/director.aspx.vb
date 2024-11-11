Imports capaNegocio

Public Class director
    Inherits System.Web.UI.Page
    Dim clsDirector As New clsDirector
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        listarDirectores()
        cargarPaises()
        cargarPaisesEdit()
    End Sub

    Protected Sub listarDirectores()
        ' Obtener la lista de directores desde la función retornar_director del backend
        gvDirectores.DataSource = clsDirector.retornar_director()
        gvDirectores.DataBind()
    End Sub


    Protected Sub cargarPaises()
        ' Suponiendo que tienes un método en `clsDirector` o similar para obtener la lista de países
        Dim dtPaises As DataTable = clsDirector.retornar_pais()
        ddlPais.DataSource = dtPaises
        ddlPais.DataTextField = "nombre_pais" ' Campo de texto a mostrar
        ddlPais.DataValueField = "id_pais" ' Valor que usaremos en el backend
        ddlPais.DataBind()
    End Sub

    Protected Sub cargarPaisesEdit()
        ' Suponiendo que tienes un método en `clsDirector` o similar para obtener la lista de países
        Dim dtPaises As DataTable = clsDirector.retornar_pais()
        ddlEditPais.DataSource = dtPaises
        ddlEditPais.DataTextField = "nombre_pais" ' Campo de texto a mostrar
        ddlEditPais.DataValueField = "id_pais" ' Valor que usaremos en el backend
        ddlEditPais.DataBind()
    End Sub



    Protected Sub GuardarDirector(ByVal sender As Object, ByVal e As EventArgs)
        ' Obtener los valores de los controles en el modal
        Dim nombreDirector As String = txtNombreDirector.Text
        Dim apellidosDirector As String = txtApellidosDirector.Text
        Dim idPais As Integer = Convert.ToInt32(ddlPais.SelectedValue)
        Dim biografia As String = txtBiografia.Text
        Dim premios As String = txtPremios.Text
        Dim vigencia As Char = If(chkVigencia.Checked, "A"c, "I"c) ' 'A' para activo, 'I' para inactivo

        ' Llamar al método de la capa de negocio para guardar el director
        Dim exito As Boolean = clsDirector.registrar_director(nombreDirector, apellidosDirector, biografia, premios, vigencia, idPais)

        ' Verificar si la operación fue exitosa
        If exito Then
            ' Limpiar los campos y actualizar la lista
            txtNombreDirector.Text = ""
            txtApellidosDirector.Text = ""
            ddlPais.SelectedIndex = 0
            txtBiografia.Text = ""
            txtPremios.Text = ""
            chkVigencia.Checked = False

            listarDirectores() ' Actualizar el GridView

        Else
            ' Mostrar un mensaje de error (puedes implementar un mensaje en el modal)
        End If
    End Sub



    Protected Sub ModificarDirector(ByVal sender As Object, ByVal e As EventArgs)
        Try
            ' Obtener los valores de los controles en el modal
            Dim idDirector As Integer = Convert.ToInt32(hiddenDirectorId.Value)
            Dim nombreDirector As String = txtEditNombreDirector.Text
            Dim apellidosDirector As String = txtEditApellidosDirector.Text
            Dim idPais As Integer = Convert.ToInt32(ddlEditPais.SelectedValue)
            Dim biografia As String = txtEditBiografia.Text
            Dim premios As String = txtEditPremios.Text
            Dim estado As Char = If(chkEditVigencia.Checked, "A"c, "I"c)


            Dim exito As Boolean = clsDirector.modificarDirector(idDirector, nombreDirector, apellidosDirector, biografia, premios, estado, idPais)


            If exito Then
                listarDirectores()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideEditModal", "$('#editDirectorModal').modal('hide');", True)
            Else

                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "EditError", "alert('No se pudo modificar el director.');", True)
            End If
        Catch ex As Exception

            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "EditError", $"alert('Error: {ex.Message}');", True)
        End Try
    End Sub






End Class