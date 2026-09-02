<%@ Page Title="Empleados" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="EmpresaWeb.Empleados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Empleados</h2>
        <div class="card my-3">
            <div class="card-header bg-dark text-white">Registrar Empleado</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3 mb-2">
                        <label>Nombre (*):</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Required="true" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Apellido (*):</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" Required="true" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Cargo (*):</label>
                        <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" Required="true" />
                    </div>
                    <div class="col-md-3 mb-2">
                        <label>Salario (*):</label>
                        <asp:TextBox ID="txtSalario" runat="server" CssClass="form-control" TextMode="Number" step="0.01" Required="true" />
                    </div>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Empleado" CssClass="btn btn-primary mt-2" OnClick="btnGuardar_Click" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="ms-2 font-weight-bold" />
            </div>
        </div>

        <h4>Nómina de Empleados</h4>
        <asp:GridView ID="gvEmpleados" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered mt-2">
            <Columns>
                <asp:BoundField DataField="EmpleadoID" HeaderText="ID" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                <asp:BoundField DataField="Salario" HeaderText="Salario" DataFormatString="{0:C}" />
                <asp:BoundField DataField="FechaContratacion" HeaderText="Fecha Contratación" DataFormatString="{0:dd/MM/yyyy}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>