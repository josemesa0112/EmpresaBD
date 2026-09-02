<%@ Page Title="Proveedores" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="EmpresaWeb.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Proveedores</h2>

        <!-- Formulario -->
        <div class="card my-3">
            <div class="card-header bg-success text-white">Registrar / Editar Proveedor</div>
            <div class="card-body">
                <asp:HiddenField ID="hfProveedorID" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-3 mb-2">
                        <label>Nombre Comercial (*):</label>
                        <asp:TextBox ID="txtNombreComercial" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Nombre de Contacto:</label>
                        <asp:TextBox ID="txtContacto" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Teléfono:</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Email:</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                    </div>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Proveedor" CssClass="btn btn-success mt-2" OnClick="btnGuardar_Click" CausesValidation="false" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary mt-2 ms-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" formnovalidate="formnovalidate" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-2 font-weight-bold" />
            </div>
        </div>

        <!-- Tabla -->
        <div class="card my-3">
            <div class="card-header bg-dark text-white">Listado de Proveedores</div>
            <div class="card-body">
                <asp:GridView ID="gvProveedores" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    DataKeyNames="ProveedorID" OnRowCommand="gvProveedores_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="ProveedorID" HeaderText="ID" />
                        <asp:BoundField DataField="NombreComercial" HeaderText="Nombre Comercial" />
                        <asp:BoundField DataField="ContactoNombre" HeaderText="Contacto" />
                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="EditarProveedor" 
                                            CommandArgument='<%# Eval("ProveedorID") %>' 
                                            CssClass="btn btn-warning btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate" />

                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="EliminarProveedor" 
                                            CommandArgument='<%# Eval("ProveedorID") %>' 
                                            CssClass="btn btn-danger btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate"
                                            OnClientClick="return confirm('¿Está seguro de eliminar este proveedor?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>