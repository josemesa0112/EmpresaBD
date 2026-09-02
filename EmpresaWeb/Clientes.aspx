<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="EmpresaWeb.Clientes" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Clientes</h2>
        <hr />

        <asp:HiddenField ID="hfClienteID" runat="server" Value="0" />

        <div class="card mb-4">
            <div class="card-header bg-primary text-white">Formulario de Cliente</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label>Nombre (*):</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label>Apellido:</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label>Documento Identidad (*):</label>
                        <asp:TextBox ID="txtDocumento" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label>Email (*):</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label>Teléfono:</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-2">
                        <label>Dirección:</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="mt-3">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cliente" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" Visible="false" />
                    <asp:Label ID="lblMensaje" runat="server" CssClass="ms-3 font-weight-bold"></asp:Label>
                </div>
            </div>
        </div>

        <h4>Listado de Clientes</h4>
        <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
            DataKeyNames="ClienteID" OnRowCommand="gvClientes_RowCommand">
            <Columns>
                <asp:BoundField DataField="ClienteID" HeaderText="ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                <asp:BoundField DataField="DocumentoIdentidad" HeaderText="Documento" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:Button ID="btnEditar" runat="server" CommandName="EditarCliente" CommandArgument='<%# Eval("ClienteID") %>' Text="Editar" CssClass="btn btn-warning btn-sm" />
                        <asp:Button ID="btnEliminar" runat="server" CommandName="EliminarCliente" CommandArgument='<%# Eval("ClienteID") %>' Text="Eliminar" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('¿Está seguro de eliminar este cliente?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
