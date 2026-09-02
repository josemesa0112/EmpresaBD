<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="EmpresaWeb.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Clientes</h2>

        <!-- Formulario -->
        <div class="card my-3">
            <div class="card-header bg-primary text-white">Registrar / Editar Cliente</div>
            <div class="card-body">
                <asp:HiddenField ID="hfClienteID" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-3 mb-2">
                        <label>Nombre (*):</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Apellido (*):</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Numero de Documento (*)</label>
                        <asp:TextBox ID="txtDocumento" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Email (*):</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Teléfono:</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Dirección:</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cliente" CssClass="btn btn-success mt-2" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary mt-2 ms-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" formnovalidate="formnovalidate" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-2 font-weight-bold" />
            </div>
        </div>

        <!-- Tabla -->
        <div class="card my-3">
            <div class="card-header bg-dark text-white">Listado de Clientes</div>
            <div class="card-body">
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
                                <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="Editar" 
                                            CommandArgument='<%# Container.DataItemIndex %>' 
                                            CssClass="btn btn-warning btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate" />
                                
                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" 
                                            CommandArgument='<%# Eval("ClienteID") %>' 
                                            CssClass="btn btn-danger btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate"
                                            OnClientClick="return confirm('¿Está seguro de eliminar este cliente?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>