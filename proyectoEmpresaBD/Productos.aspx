<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="EmpresaWeb.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Productos</h2>

        <!-- Formulario -->
        <div class="card my-3">
            <div class="card-header bg-success text-white">Registrar / Editar Producto</div>
            <div class="card-body">
                <asp:HiddenField ID="hfProductoID" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-3 mb-2">
                        <label>Nombre del Producto (*):</label>
                        <asp:TextBox ID="txtNombreProducto" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Precio Unitario (*):</label>
                        <asp:TextBox ID="txtPrecioUnitario" runat="server" CssClass="form-control" placeholder="Ej: 15000.00" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Stock Disponible (*):</label>
                        <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Categoría (*):</label>
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control"
                            DataTextField="NombreCategoria" DataValueField="CategoriaID" AppendDataBoundItems="true">
                            <asp:ListItem Text="-- Seleccione --" Value="0" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Proveedor (*):</label>
                        <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="form-control"
                            DataTextField="NombreComercial" DataValueField="ProveedorID" AppendDataBoundItems="true">
                            <asp:ListItem Text="-- Seleccione --" Value="0" />
                        </asp:DropDownList>
                    </div>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Producto" CssClass="btn btn-success mt-2" OnClick="btnGuardar_Click" CausesValidation="false" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary mt-2 ms-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" formnovalidate="formnovalidate" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-2 font-weight-bold" />
            </div>
        </div>

        <!-- Tabla -->
        <div class="card my-3">
            <div class="card-header bg-dark text-white">Inventario de Productos</div>
            <div class="card-body">
                <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    DataKeyNames="ProductoID" OnRowCommand="gvProductos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="ProductoID" HeaderText="ID" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="Nombre" />
                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio" DataFormatString="{0:N2}" />
                        <asp:BoundField DataField="Stock" HeaderText="Stock" />
                        <asp:BoundField DataField="NombreCategoria" HeaderText="Categoría" />
                        <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="EditarProducto" 
                                            CommandArgument='<%# Eval("ProductoID") %>' 
                                            CssClass="btn btn-warning btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate" />
                                
                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="EliminarProducto" 
                                            CommandArgument='<%# Eval("ProductoID") %>' 
                                            CssClass="btn btn-danger btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate"
                                            OnClientClick="return confirm('¿Está seguro de eliminar este producto?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>