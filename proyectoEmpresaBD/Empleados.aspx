<%@ Page Title="Empleados" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="EmpresaWeb.Empleados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Empleados</h2>

        <!-- Formulario -->
        <div class="card my-3">
            <div class="card-header bg-success text-white">Registrar / Editar Empleado</div>
            <div class="card-body">
                <asp:HiddenField ID="hfEmpleadoID" runat="server" Value="0" />
                <div class="row">
                    <div class="col-md-2 mb-2">
                        <label>Nombre (*):</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Apellido (*):</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Cargo:</label>
                        <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Email (*):</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Salario (*):</label>
                        <asp:TextBox ID="txtSalario" runat="server" CssClass="form-control" placeholder="Ej: 2500000.00" />
                    </div>
                    <div class="col-md-2 mb-2">
                        <label>Fecha Contratación (*):</label>
                        <asp:TextBox ID="txtFechaContratacion" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Empleado" CssClass="btn btn-success mt-2" OnClick="btnGuardar_Click" CausesValidation="false" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary mt-2 ms-2" OnClick="btnCancelar_Click" Visible="false" CausesValidation="false" formnovalidate="formnovalidate" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-2 font-weight-bold" />
            </div>
        </div>

        <!-- Tabla -->
        <div class="card my-3">
            <div class="card-header bg-dark text-white">Listado de Empleados</div>
            <div class="card-body">
                <asp:GridView ID="gvEmpleados" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    DataKeyNames="EmpleadoID" OnRowCommand="gvEmpleados_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="EmpleadoID" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                        <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Salario" HeaderText="Salario" DataFormatString="{0:N2}" />
                        <asp:BoundField DataField="FechaContratacion" HeaderText="Contratación" DataFormatString="{0:dd/MM/yyyy}" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="EditarEmpleado" 
                                            CommandArgument='<%# Eval("EmpleadoID") %>' 
                                            CssClass="btn btn-warning btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate" />

                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="EliminarEmpleado" 
                                            CommandArgument='<%# Eval("EmpleadoID") %>' 
                                            CssClass="btn btn-danger btn-sm" 
                                            CausesValidation="false" formnovalidate="formnovalidate"
                                            OnClientClick="return confirm('¿Está seguro de eliminar este empleado?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>