<%@ Page Title="Validación de Stock" Language="C#" Async="true" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ValidacionStock.aspx.cs" Inherits="EmpresaWeb.ValidacionStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Validación de Stock (Procesamiento Concurrente)</h2>
        <p class="text-muted">Valida el stock de todos los productos activos en paralelo, usando Task/async-await.</p>

        <asp:Button ID="btnValidar" runat="server" Text="Validar Stock de Todos los Productos" CssClass="btn btn-primary mb-3" OnClick="btnValidar_Click" CausesValidation="false" />
        <asp:Label ID="lblTiempo" runat="server" CssClass="ms-2 fw-bold text-muted" />

        <asp:GridView ID="gvResultados" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered">
            <Columns>
                <asp:BoundField DataField="Resultado" HeaderText="Resultado" />
            </Columns>
            <EmptyDataTemplate>Presione el botón para ejecutar la validación.</EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>