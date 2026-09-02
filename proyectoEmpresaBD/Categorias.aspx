<%@ Page Title="Categorías" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="EmpresaWeb.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Categorías</h2>

        <!-- Formulario -->
        <div class="card my-3">
            <div class="card-header bg-success text-white">Registrar / Editar Categoría</div>
            <div class="card-body">
                <asp:HiddenField ID="hfCategoriaID" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label>Nombre de la Categoría (*):</label>
                        <asp:TextBox ID="txtNombreCategoria" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6 mb-2">
                        <label>Descripción:</label>
                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Categoría" CssClass="btn btn-success mt-2" OnClick="btnGuardar_Click" CausesValidation="false" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary mt-2 ms-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" formnovalidate="formnovalidate" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-2 font-weight-bold" />
            </div>
        </div>

        <!-- Tabla -->
        <div class="card my-3">
            <div class="card-header bg-dark text-white">Listado de Categorías</div>
            <div class="card-body">
                <asp:GridView ID="gvCategorias" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    DataKeyNames="CategoriaID" OnRowCommand="gvCategorias_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="CategoriaID" HeaderText="ID" />
                        <asp:BoundField DataField="NombreCategoria" HeaderText="Nombre" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="EditarCategoria" 
                                            CommandArgument='<%# Eval("CategoriaID") %>' 
                                            CssClass="btn btn-warning btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate" />

                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="EliminarCategoria" 
                                            CommandArgument='<%# Eval("CategoriaID") %>' 
                                            CssClass="btn btn-danger btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate"
                                            OnClientClick="return confirm('¿Está seguro de eliminar esta categoría?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>