<%@ Page Title="Pedidos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pedidos.aspx.cs" Inherits="EmpresaWeb.Pedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Registro de Pedidos</h2>

        <!-- Cabecera del Pedido -->
        <div class="card my-3">
            <div class="card-header bg-success text-white">Nuevo / Editar Pedido</div>
            <div class="card-body">
                <asp:HiddenField ID="hfPedidoID" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label>Cliente (*):</label>
                        <asp:DropDownList ID="ddlCliente" runat="server" CssClass="form-select" />
                    </div>
                    <div class="col-md-4 mb-2">
                        <label>Empleado Atiende (*):</label>
                        <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="form-select" />
                    </div>
                </div>

                <hr />
                <h5>Agregar Producto</h5>
                <div class="row align-items-end">
                    <div class="col-md-4 mb-2">
                        <label>Producto:</label>
                        <asp:DropDownList ID="ddlProducto" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Cantidad:</label>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number" Text="1" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Precio Unitario:</label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar" CssClass="btn btn-primary" OnClick="btnAgregarProducto_Click" CausesValidation="false" />
                    </div>
                </div>

                <!-- Renglones agregados al pedido actual -->
                <asp:GridView ID="gvDetalleTemp" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered mt-2"
                    OnRowCommand="gvDetalleTemp_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="NombreProducto" HeaderText="Producto" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio U." DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnQuitar" runat="server" Text="Quitar" CommandName="Quitar"
                                            CommandArgument='<%# Container.DataItemIndex %>'
                                            CssClass="btn btn-outline-danger btn-sm" CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>Aún no ha agregado productos a este pedido.</EmptyDataTemplate>
                </asp:GridView>

                <p class="fw-bold">Total: <asp:Label ID="lblTotalTemp" runat="server" Text="$0.00" /></p>

                <asp:Button ID="btnGuardarPedido" runat="server" Text="Registrar Pedido" CssClass="btn btn-success mt-2" OnClick="btnGuardarPedido_Click" CausesValidation="false" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary mt-2 ms-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-2 fw-bold" />
            </div>
        </div>

        <!-- Listado general de Pedidos -->
        <div class="card my-3">
            <div class="card-header bg-dark text-white">Listado de Pedidos</div>
            <div class="card-body">
                <asp:GridView ID="gvPedidos" runat="server" AutoGenerateColumns="False"
                              CssClass="table table-striped table-bordered"
                              DataKeyNames="PedidoID" OnRowCommand="gvPedidos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="PedidoID" HeaderText="ID" />
                        <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                        <asp:BoundField DataField="Empleado" HeaderText="Empleado" />
                        <asp:BoundField DataField="CantidadProductos" HeaderText="# Productos" />
                        <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="FechaPedido" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="Editar"
                                            CommandArgument='<%# Eval("PedidoID") %>'
                                            CssClass="btn btn-warning btn-sm" CausesValidation="false" formnovalidate="formnovalidate" />

                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar"
                                            CommandArgument='<%# Eval("PedidoID") %>'
                                            CssClass="btn btn-danger btn-sm" CausesValidation="false" formnovalidate="formnovalidate"
                                            OnClientClick="return confirm('¿Está seguro de eliminar este pedido completo?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>