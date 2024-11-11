Imports capaNegocio

Public Class gestionarEntradas
    Inherits System.Web.UI.Page

    Dim objEntrada As New clssEntrada()
    Dim objSala As New clsSala()
    Dim objButaca As New clsButaca()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ListarEntradas()
            CargarCombos()
        End If
    End Sub

    ' Método para cargar la tabla de entradas
    Private Sub ListarEntradas()
        gvEntradas.DataSource = objEntrada.listarEntradas()
        gvEntradas.DataBind()
    End Sub

    ' Método para cargar los combos
    Private Sub CargarCombos()
        ' Cargar Salas
        ddlSala.DataSource = objSala.ListarSalas()
        ddlSala.DataTextField = "nombre"
        ddlSala.DataValueField = "id_sala"
        ddlSala.DataBind()
        ddlSala.Items.Insert(0, New ListItem("Seleccionar Sala", ""))

        ' Cargar Butacas
        ddlButaca.DataSource = objButaca.listarButacas()
        ddlButaca.DataTextField = "nombre"
        ddlButaca.DataValueField = "id_butaca"
        ddlButaca.DataBind()
        ddlButaca.Items.Insert(0, New ListItem("Seleccionar Butaca", ""))

        ' Cargar Funciones Programadas
        ddlFuncion.DataSource = objEntrada.ListarFuncionesProgramadas()
        ddlFuncion.DataTextField = "id_funcion"
        ddlFuncion.DataValueField = "id_funcion"
        ddlFuncion.DataBind()
        ddlFuncion.Items.Insert(0, New ListItem("Seleccionar Función Programada", ""))
    End Sub

    ' Evento para el botón "Agregar Entrada"
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Dim idFuncion As Integer = Convert.ToInt32(ddlFuncion.SelectedValue)
            Dim idButaca As Integer = Convert.ToInt32(ddlButaca.SelectedValue)
            Dim idSala As Integer = Convert.ToInt32(ddlSala.SelectedValue)
            Dim estado As Boolean = chkEstado.Checked

            ' Llamar a la función para guardar la entrada
            objEntrada.guardarEntrada(idFuncion, idButaca, idSala, estado)
            ListarEntradas()
            closeModal()
        Catch ex As Exception
            ' Mostrar mensaje de error
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al guardar la entrada.');", True)
        End Try
    End Sub

    ' Evento para el botón "Modificar Entrada"
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Try
            Dim idEntrada As Integer = Convert.ToInt32(TextBox1.Text)
            Dim idFuncion As Integer = Convert.ToInt32(DropDownList1.SelectedValue)
            Dim idButaca As Integer = Convert.ToInt32(DropDownList2.SelectedValue)
            Dim idSala As Integer = Convert.ToInt32(DropDownList3.SelectedValue)
            Dim estado As Boolean = CheckBox1.Checked

            ' Llamar a la función para modificar la entrada
            objEntrada.modificarEntrada(idEntrada, idFuncion, idButaca, idSala, estado)
            ListarEntradas()
            closeModal()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Error al modificar la entrada.');", True)
        End Try
    End Sub

    ' Evento para el botón "Eliminar Entrada" y "Ver Entrada"
    Protected Sub gvEntradas_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Eliminar" Or e.CommandName = "Ver" Or e.CommandName = "Modificar" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim idEntrada As Integer = Convert.ToInt32(gvEntradas.DataKeys(index).Value)

            Select Case e.CommandName
                Case "Eliminar"
                    Try
                        objEntrada.eliminarEntrada(idEntrada)
                        ListarEntradas()
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", "alert('Entrada eliminada exitosamente');", True)
                    Catch ex As Exception
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "alert", $"alert('Error al eliminar la entrada: {ex.Message}');", True)
                    End Try

                Case "Ver"
                    ' Llenar el modal con los detalles de la entrada
                    Dim dt As DataTable = objEntrada.buscarEntradaPorFuncionYButaca(idEntrada, index)
                    If dt.Rows.Count > 0 Then
                        TextBox2.Text = dt.Rows(0)("id_entrada").ToString()
                        DropDownList4.SelectedValue = dt.Rows(0)("id_funcionprogramada").ToString()
                        DropDownList5.SelectedValue = dt.Rows(0)("id_butaca").ToString()
                        DropDownList6.SelectedValue = dt.Rows(0)("id_sala").ToString()
                        CheckBox2.Checked = Convert.ToBoolean(dt.Rows(0)("estado"))
                        openModalV()
                    End If

                Case "Modificar"
                    ' Llenar el modal para modificar con los detalles de la entrada
                    Dim dt As DataTable = objEntrada.buscarEntradaPorFuncionYButaca(idEntrada, index)
                    If dt.Rows.Count > 0 Then
                        TextBox1.Text = dt.Rows(0)("id_entrada").ToString()
                        DropDownList1.SelectedValue = dt.Rows(0)("id_funcionprogramada").ToString()
                        DropDownList2.SelectedValue = dt.Rows(0)("id_butaca").ToString()
                        DropDownList3.SelectedValue = dt.Rows(0)("id_sala").ToString()
                        CheckBox1.Checked = Convert.ToBoolean(dt.Rows(0)("estado"))
                        openModalM()
                    End If
            End Select
        End If
    End Sub
    Private Sub openModalV()
        ClientScript.RegisterStartupScript(Me.GetType(), "openModalV", "<script>document.getElementById('myModalV').style.display='flex';</script>", False)
    End Sub

    Private Sub openModalM()
        ClientScript.RegisterStartupScript(Me.GetType(), "openModalM", "<script>document.getElementById('myModalModificar').style.display='flex';</script>", False)
    End Sub

    Private Sub openModal()
        ClientScript.RegisterStartupScript(Me.GetType(), "openModal", "<script>document.getElementById('myModalAgregar').style.display='flex';</script>", False)
    End Sub

    Private Sub closeModal()
        ClientScript.RegisterStartupScript(Me.GetType(), "closeModal", "<script>closeModal();</script>", False)
    End Sub

End Class
