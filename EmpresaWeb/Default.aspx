<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EmpresaWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Jumbotron / Encabezado Principal -->
    <div class="p-5 mb-4 bg-light rounded-3 shadow-sm border mt-3">
        <div class="container-fluid py-3">
            <h1 class="display-5 fw-bold text-primary">KaosTechnology</h1>
            <p class="col-md-10 fs-4 text-secondary">
                Plataforma integral de gestión empresarial diseñada para optimizar la administración de clientes, inventarios de productos y procesamiento masivo de pedidos en tiempo real.
            </p>
            <a href="Clientes.aspx" class="btn btn-primary btn-lg shadow-sm">
                <i class="bi bi-people"></i> Gestionar Clientes
            </a>
            <a href="ValidacionStock.aspx" class="btn btn-outline-secondary btn-lg shadow-sm ms-2">
                Validar Inventario en Paralelo
            </a>
        </div>
    </div>

    <!-- Sección de Funcionalidades Principales -->
    <div class="row align-items-md-stretch g-4 mb-4">
        
        <!-- Tarjeta 1: Para qué sirve -->
        <div class="col-md-4">
            <div class="h-100 p-4 bg-white border rounded-3 shadow-sm">
                <h3 class="text-dark fw-bold">¿Para qué sirve?</h3>
                <p class="text-muted">
                    Centraliza la operación comercial de la empresa bajo una arquitectura segura de Stored Procedures y bases de datos relacionales, garantizando alta disponibilidad y consistencia en cada transacción.
                </p>
            </div>
        </div>

        <!-- Tarjeta 2: Qué podemos hacer -->
        <div class="col-md-4">
            <div class="h-100 p-4 bg-white border rounded-3 shadow-sm">
                <h3 class="text-dark fw-bold">Módulos del Sistema</h3>
                <ul class="list-unstyled text-secondary">
                    <li class="mb-2"><strong>Clientes:</strong> Registro, edición y mantenimiento de datos.</li>
                    <li class="mb-2"><strong>Productos:</strong> Control de catálogo, categorías y existencias.</li>
                    <li class="mb-2"><strong>Pedidos:</strong> Emisión directa e integración de ventas.</li>
                </ul>
            </div>
        </div>

        <!-- Tarjeta 3: Procesamiento Avanzado -->
        <div class="col-md-4">
            <div class="h-100 p-4 bg-white border rounded-3 shadow-sm">
                <h3 class="text-dark fw-bold">Procesamiento Asíncrono</h3>
                <p class="text-muted">
                    Implementa algoritmos multitarea con <code>Task/async-await</code> que permiten validar simultáneamente grandes volúmenes de productos sin bloqueos de interfaz ni condiciones de carrera.
                </p>
            </div>
        </div>

    </div>

</asp:Content>