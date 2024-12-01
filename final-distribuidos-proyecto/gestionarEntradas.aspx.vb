Imports capaNegocio

Public Class gestionarEntradas
    Inherits System.Web.UI.Page

    Dim objEntrada As New clssEntrada()
    Dim objSala As New clsSala()
    Dim objButaca As New clsButaca()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ListarEntradas()
        End If
    End Sub

    ' Método para cargar la tabla de entradas
    Private Sub ListarEntradas()
        gvEntradas.DataSource = objEntrada.listarEntradas()
        gvEntradas.DataBind()
    End Sub

    Protected Sub gvEntradas_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Ver" Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim idEntrada As Integer = Convert.ToInt32(gvEntradas.DataKeys(index).Value)

            Dim dt As DataTable = objEntrada.buscarEntradaPorId(idEntrada)


            If dt.Rows.Count > 0 Then
                txtIdEntrada.Text = dt.Rows(0)("id_entrada").ToString()
                txtButaca.Text = dt.Rows(0)("butaca").ToString()
                txtFuncion.Text = dt.Rows(0)("id_funcion").ToString()
                txtSala.Text = dt.Rows(0)("id_sala").ToString()
                txtNombreSala.Text = dt.Rows(0)("nombre").ToString()
                txtFecha.Text = dt.Rows(0)("fecha").ToString()
                txtHoraInicio.Text = dt.Rows(0)("hora_inicio").ToString()
                txtHoraFin.Text = dt.Rows(0)("hora_fin").ToString()
                txtMonto.Text = dt.Rows(0)("monto").ToString()
                txtPelicula.Text = dt.Rows(0)("nombre_pelicula").ToString()
                txtEstreno.Text = dt.Rows(0)("estreno").ToString()
                txtEstado.Text = dt.Rows(0)("estado").ToString()

                openModalV()
            End If
        ElseIf e.CommandName = "CambiarE" Then
            ' Obtener el índice de la fila y el ID de la entrada
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim idEntrada As Integer = Convert.ToInt32(gvEntradas.DataKeys(index).Value)
            Dim estado As Boolean = Convert.ToBoolean(gvEntradas.DataKeys(index).Values("estado"))
            objEntrada.cambiarEstadoEntrada(idEntrada, Not estado)
            ListarEntradas()
        End If
    End Sub


    Private Sub openModalV()
        ClientScript.RegisterStartupScript(Me.GetType(), "openModalV", "<script>document.getElementById('myModalV').style.display='flex';</script>", False)
    End Sub

    Private Sub closeModal()
        ClientScript.RegisterStartupScript(Me.GetType(), "closeModal", "<script>closeModal();</script>", False)
    End Sub

    Protected Sub gvEntradas_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub
End Class
