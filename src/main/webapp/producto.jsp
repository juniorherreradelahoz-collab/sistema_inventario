    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.mycompany.sistema_inventario.Categoria" %>
    <%@ page import="com.mycompany.sistema_inventario.CategoriaDAO" %>
    <%@ page import="com.mycompany.sistema_inventario.Producto" %>
    <%@ page import="com.mycompany.sistema_inventario.ProductoDAO" %>
    <%@ page import="java.util.List" %>

    <!DOCTYPE html>
    <html lang="es">
    <head>
      <meta charset="UTF-8">
      <title>Productos - Sistema de Inventarios</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

      <style>   
        :root {
          --verde: #2ecc71;
          --verde-oscuro: #27ae60;
          --texto: #333;
          --borde: #ddd;
          --fondo: #fff;
        }

        body {
          background-color: var(--fondo);
          font-family: "Segoe UI", sans-serif;
          margin: 0;
          padding: 0;
          color: var(--texto);
        }

        header {
          padding: 20px 40px;
          border-bottom: 1px solid var(--borde);
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        main {
          padding: 40px;
          display: flex;
          justify-content: center;
        }

        .card {
          width: 100%;
          max-width: 1100px;
          background: #fff;
          border: 1px solid var(--borde);
          border-radius: 14px;
          padding: 30px;
          box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        }

        .icono {
          font-size: 3rem;
          color: var(--verde);
          text-align: center;
          margin-bottom: 15px;
        }

        h2 {
          text-align: center;
          margin-bottom: 10px;
          font-size: 1.4rem;
        }

        .descripcion {
          text-align: center;
          color: #666;
          margin-bottom: 25px;
        }

        .formulario {
          margin-bottom: 30px;
          background: #f9f9f9;
          padding: 20px;
          border-radius: 12px;
          border: 1px solid var(--borde);
        }

        label {
          font-weight: 600;
          margin-bottom: 6px;
          display: block;
        }

        input, select, textarea {
          width: 100%;
          padding: 12px;
          border: 1px solid var(--borde);
          border-radius: 8px;
          margin-bottom: 18px;
          font-size: 1rem;
        }

        textarea {
          resize: vertical;
          min-height: 80px;
        }

        .boton {
          width: 100%;
          padding: 15px;
          background-color: var(--verde);
          color: #fff;
          font-size: 1.1rem;
          font-weight: 600;
          border: none;
          border-radius: 999px;
          cursor: pointer;
          transition: background-color 0.15s ease, transform 0.1s ease;
        }

        .boton:hover {
          background-color: var(--verde-oscuro);
          transform: translateY(-2px);
        }

        table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 10px;
        }

        table th, table td {
          border: 1px solid var(--borde);
          padding: 10px;
          text-align: left;
        }

        table th {
          background-color: #f5f5f5;
        }

        .acciones i {
          font-size: 1.2rem;
          cursor: pointer;
          margin-right: 10px;
          color: var(--verde);
        }

        .acciones i:hover {
          color: var(--verde-oscuro);
        }
.filtros {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
    align-items: center;
}

.filtros input,
.filtros select {
    margin-bottom: 0;
}

.filtros input {
    flex: 2;
}

.filtros select {
    flex: 1;
}

.btn-buscar {
    background: #2ecc71;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    padding: 0 25px;
    height: 48px;
    align-self: center;
}

.btn-buscar:hover {
    background: #27ae60;
}
      </style>
    </head>

    <body>

    <header>
      <h1>Sistema de Inventarios</h1>
      <span>Usuario: Administrador</span>
    </header>

    <main>
      <div class="card">

        <div class="icono">
          <i class="fa-solid fa-boxes"></i>
        </div>

        <h2>Gestión de Productos</h2>
        <p class="descripcion">Administre el catálogo de productos del inventario.</p>

        <!-- FORMULARIO DE REGISTRO DE PRODUCTO -->
       <div class="formulario">
        <h3>Registrar Nuevo Producto</h3>

        <form action="Controlador" method="post">
            <input type="hidden" name="accion" value="agregarProducto">

            <!-- Código automático -->
            <label>Código del producto</label>
            <input type="text" name="codigo" 
                   value="<%= new ProductoDAO().generarCodigo() %>" 
                   readonly>

            <!-- Nombre -->
            <label>Nombre del producto</label>
            <input type="text" name="nombre" required>

            <!-- Categoría dinámica -->
            <label>Categoría</label>
            <select name="idcategoria" required>
                <%
                    CategoriaDAO cdao = new CategoriaDAO();
                    List<Categoria> categorias = cdao.listar();
                    for (Categoria cat : categorias) {
                %>
                    <option value="<%= cat.getId_categoria() %>">
                        <%= cat.getNombre() %>
                    </option>
                <%
                    }
                %>
            </select>

            <!-- Descripción -->
            <label>Descripción</label>
            <textarea name="descripcion"></textarea>

            <!-- Estado -->
            <label>Estado</label>
            <select name="estado" required>
                <option value="1">Activo</option>
                <option value="0">Inactivo</option>
                <option value="2">Agotado</option>
                <option value="3">Suspendido</option>
            </select>

            <!-- Botón -->
            <button class="boton">Registrar Producto</button>
        </form>
    </div>


        <!-- TABLA DE PRODUCTOS -->
        <h3 id="seccionProductos">
    Listado de Productos
</h3>
<form action="Controlador"
      method="get"
      onsubmit="guardarPosicion()">

    <input type="hidden"
           name="accion"
           value="buscarProducto">

    <div class="filtros">

        <input type="text"
       name="texto"
       value="<%= request.getAttribute("textoBuscado") != null ? request.getAttribute("textoBuscado") : "" %>"
       placeholder="Buscar por código o nombre">

        <select name="categoria">

        <option value="">
            Todas las categorías
        </option>

        <%
            for (Categoria cat : categorias) {
        %>

            <option value="<%= cat.getId_categoria() %>"
    <%= String.valueOf(cat.getId_categoria()).equals(String.valueOf(request.getAttribute("categoriaSeleccionada"))) ? "selected" : "" %>>
    <%= cat.getNombre() %>
</option>

        <%
            }
        %>

    </select>

    <button type="submit" class="btn-buscar">
        Buscar
    </button>
</div>
   </form>
        <table>
          <thead>
            <tr>
              <th>Código</th>
              <th>Producto</th>
              <th>Categoría</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>

          <%
            List<Producto> lista = (List<Producto>) request.getAttribute("listaProducto");
            if (lista != null) {
              for (Producto p : lista) {
          %>

            <tr>
              <td><%= p.getCodigo() %></td>
              <td><%= p.getNombre() %></td>
              <td><%= p.getNombreCategoria() %></td>
              <td class="acciones">
                <i class="fa-solid fa-pen-to-square"
                   onclick="window.location='editar_producto.jsp?id=<%= p.getIdproducto() %>'"></i>

                <i class="fa-solid fa-trash"
   onclick="if(confirm('¿Está seguro de eliminar este producto?')) {
       window.location='Controlador?accion=eliminarProducto&id=<%= p.getIdproducto() %>';
   }">
</i>
              </td>
            </tr>

          <%
              }
            }
          %>

          </tbody>
        </table>

      </div>
    </main>

    <footer>
      Sistema de Inventarios · Productos · © 2026
    </footer>
<script>
window.onload = function() {

    if(sessionStorage.getItem("volverProductos")) {

        const tabla = document.getElementById("seccionProductos");

        if(tabla){
            tabla.scrollIntoView({
                behavior: "smooth"
            });
        }

        sessionStorage.removeItem("volverProductos");
    }
};

function guardarPosicion(){
    sessionStorage.setItem("volverProductos", "si");
}
</script>
    </body>
    </html> 
