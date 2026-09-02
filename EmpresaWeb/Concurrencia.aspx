<%@ Page Title="Concurrencia" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Concurrencia.aspx.cs" Inherits="EmpresaWeb.Concurrencia" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Procesamiento Concurrente (Task / async-await)</h2>
        <p class="text-muted">Procesa en paralelo la validación de inventario utilizando hilos independientes seguros sin condiciones de carrera.</p>
        
        <asp:Button ID="btnProcesar" runat="server" Text="Ejecutar Validación en Paralelo" CssClass="btn btn-warning fw-bold mb-3" OnClick="btnProcesar_Click" />

        <div class="card">
            <div class="card-header bg-dark text-white">Log de Hilos Ejecutados</div>
            <div class="card-body">
                <asp:BulletedList ID="blResultados" runat="server" CssClass="list-group list-group-flush" />
            </div>
        </div>
    </div>
</asp:Content>