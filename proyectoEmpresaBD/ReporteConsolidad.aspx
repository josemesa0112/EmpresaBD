<%@ Page Title="Reporte Consolidado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReporteConsolidado.aspx.cs" Inherits="EmpresaWeb.ReporteConsolidado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Reporte Consolidado de Pedidos</h2>
        <p class="text-muted">Cruce de las tablas Pedidos, Clientes, Empleados, EstadosPedido, DetallePedido, Productos y Categorías.</p>

        <div class="card my-3">
            <div class="card-body">
                <div class="row align-items-end">
                    <div class="col-md-3 mb-2">
                        <label>Fecha Inicio:</label>
                        <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Fecha Fin:</label>
                        <asp:TextBox ID="txtFechaFin" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="col-md-4 mb-2">
                        <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn btn-primary" OnClick="btnFiltrar_Click" CausesValidation="false" />
                        <asp:Button ID="btnLimpiar" runat="server" Text="Ver Todo" CssClass="btn btn-secondary ms-2" OnClick="btnLimpiar_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </div>

        <div class="card my-3">
            <div class="card-header bg-dark text-white">Resultado</div>
            <div class="card-body">
                <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm">
                    <Columns>
                        <asp:BoundField DataField="PedidoID" HeaderText="Pedido" />
                        <asp:BoundField DataField="FechaPedido" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:BoundField DataField="NombreCliente" HeaderText="Cliente" />
                        <asp:BoundField DataField="DocumentoCliente" HeaderText="Documento" />
                        <asp:BoundField DataField="NombreEmpleado" HeaderText="Empleado" />
                        <asp:BoundField DataField="EstadoPedido" HeaderText="Estado" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="Producto" />
                        <asp:BoundField DataField="NombreCategoria" HeaderText="Categoría" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cant." />
                        <asp:BoundField DataField="PrecioVentaUnitario" HeaderText="Precio U." DataFormatString="{0:C}" />
                        <asp:BoundField DataField="SubtotalProducto" HeaderText="Subtotal" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="TotalPedido" HeaderText="Total Pedido" DataFormatString="{0:C}" />
                    </Columns>
                    <EmptyDataTemplate>No hay datos para mostrar.</EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>