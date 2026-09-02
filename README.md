# EmpresaWeb — Prueba Técnica Analista de Sistemas (KaosTechnology)

Aplicación web ASP.NET (C#, Web Forms) para la administración de Clientes, Productos, Pedidos, Empleados, Proveedores y Categorías, sobre una base de datos SQL Server 2022. Toda operación contra la base de datos se realiza exclusivamente mediante procedimientos almacenados.

## Contenido del repositorio

- `/EmpresaWeb` — código fuente completo de la aplicación (Web Forms, DAL, Modelos, Servicios).
- `EmpresaDB_Script_Final.sql` — script consolidado de creación de base de datos, tablas y procedimientos almacenados (estado final).
- `Respuestas_Preguntas_Teoricas.docx` — respuestas a las preguntas teóricas de la prueba (migración SQL Server 2000/2005 → 2022).
- `README.md` — este documento.

## 1. Requisitos previos

- SQL Server 2022 (o superior) accesible desde el servidor de IIS.
- Windows Server con IIS habilitado (o Windows con IIS habilitado para pruebas locales).
- .NET Framework 4.8 instalado en el servidor.
- Visual Studio 2022 (para compilar/publicar).

## 2. Creación de la base de datos

1. Abrir `EmpresaDB_Script_Final.sql` en SQL Server Management Studio.
2. Ejecutar el script completo contra una instancia de SQL Server 2022. Esto crea la base `EmpresaDB`, las 8 tablas, los datos semilla iniciales y todos los procedimientos almacenados.
3. **Importante:** el script inicia con `DROP DATABASE EmpresaDB` si ya existe con ese nombre — no ejecutar sobre una base con datos que se quieran conservar sin hacer respaldo antes.

## 3. Configuración de la cadena de conexión

En `EmpresaWeb/web.config`, ajustar el `connectionString` con el servidor real:

```xml
<connectionStrings>
  <add name="EmpresaDBConnection"
       connectionString="Server=NOMBRE_O_IP_DEL_SERVIDOR;Database=EmpresaDB;Integrated Security=True;TrustServerCertificate=True;"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

Si se usa autenticación de Windows (`Integrated Security=True`), la identidad del Application Pool de IIS debe tener un login habilitado en SQL Server con permisos sobre `EmpresaDB` (ver sección 5).

## 4. Publicación en IIS

1. En Visual Studio: clic derecho sobre el proyecto `EmpresaWeb` → **Publicar**.
2. Elegir **Carpeta** (File System) como método de publicación, o **Web Deploy** si el servidor lo tiene habilitado.
3. Copiar el resultado de la publicación a una carpeta accesible por IIS en el servidor (por ejemplo `C:\inetpub\wwwroot\EmpresaWeb`).
4. En el **Administrador de IIS**:
   - Crear un nuevo **Application Pool** (ej. `EmpresaWebPool`) con **.NET CLR Version = v4.0** y **Modo de canalización = Integrado**.
   - Crear un nuevo **Sitio Web** (o Aplicación dentro de un sitio existente) apuntando a la carpeta publicada, y asignarle el Application Pool creado.
   - Configurar el binding (puerto/host) según se necesite.
5. Recomendado para producción, ajustar en `web.config`:
   - `<compilation debug="false" .../>`
   - `<customErrors mode="RemoteOnly" />` (o `On`, con una página de error personalizada).

## 5. Permisos de la identidad del Application Pool en SQL Server

Si se usa `Integrated Security=True`:

1. En SQL Server Management Studio → **Seguridad → Inicios de sesión**, crear un login para `IIS AppPool\<NombreDelPool>` (autenticación de Windows).
2. Asignarle permisos `db_datareader`, `db_datawriter` y `EXECUTE` sobre los procedimientos almacenados de `EmpresaDB` (o el rol equivalente que se prefiera).

Alternativa: usar autenticación SQL (usuario/contraseña) en el `connectionString` en vez de `Integrated Security`, si se prefiere no gestionar logins de Windows.

## 6. Verificación de funcionamiento

Una vez publicado, navegar el sitio desde el navegador (usando la URL/puerto configurado en IIS, no `localhost` de Visual Studio) y confirmar:

- **Clientes / Productos / Empleados / Proveedores / Categorías**: Crear, Editar y Eliminar (eliminación lógica) funcionan correctamente.
- **Pedidos**: creación de un pedido con uno o varios productos, edición y eliminación.
- **Reporte Consolidado**: el listado cruza Pedidos, Clientes, Empleados, EstadosPedido, DetallePedido, Productos y Categorías; el filtro por fechas funciona.
- **Validación de Stock (concurrencia)**: el botón ejecuta la validación en paralelo sobre todos los productos y muestra el tiempo total junto con el ID de hilo de cada resultado.

## 7. Enfoque de concurrencia

La validación de stock (`ConcurrenciaService.ValidarStockMasivoAsync`) dispara una tarea `async` por cada producto, cada una con su propia conexión a SQL Server y llamada asíncrona (`ExecuteReaderAsync`) al procedimiento `sp_Productos_SelectById`. `Task.WhenAll` espera a que todas terminen. Los resultados se acumulan en un `ConcurrentBag<string>`, una colección segura para concurrencia (thread-safe) que evita condiciones de carrera al escribir desde varios hilos simultáneamente; el contador de productos procesados se incrementa con `Interlocked.Increment` por la misma razón. Al usar E/S asíncrona real (no `Thread.Sleep` ni trabajo síncrono envuelto en `Task.Run`), los hilos del pool de ASP.NET no se bloquean mientras se espera la respuesta de la base de datos.

La pantalla `ValidacionStock.aspx` (menú "Validar Stock Masivo") permite disparar esta validación sobre todos los productos activos y ver, para cada uno, el hilo que lo procesó y su estado de stock (Óptimo / Crítico-Bajo), junto con el tiempo total de ejecución.

## 8. Notas técnicas relevantes

- **Eliminación lógica (soft delete)**: Productos, Clientes, Empleados, Proveedores y Categorías no se borran físicamente al "Eliminar" — se marcan con `Activo = 0`, preservando la integridad referencial con Pedidos/DetallePedido que ya los referencian. Los listados y combos filtran automáticamente por `Activo = 1`.
- **Sin SQL embebido en el código**: toda operación contra la base de datos se realiza a través de procedimientos almacenados (`CommandType.StoredProcedure`), sin sentencias `SELECT`/`INSERT`/`UPDATE`/`DELETE` escritas como texto en el código C#.
- **Pedidos con múltiples productos**: la pantalla de Pedidos permite agregar varios productos a un mismo pedido antes de guardarlo (aprovechando la tabla `DetallePedido`), con actualización y eliminación consistentes mediante transacciones (`SqlTransaction`).

## 9. Evidencia de funcionamiento

Ver capturas de pantalla adjuntas en la carpeta `evidencias/` (o el documento correspondiente), mostrando la aplicación funcionando publicada en IIS sobre Windows Server.
