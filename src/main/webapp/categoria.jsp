<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.sistema_inventario.Categoria" %>

<!DOCTYPE html>
<html>
<head>
      <meta charset="UTF-8">
      <title>Categorías - Sistema de Inventarios</title>
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
footer {
    text-align: center;
    padding: 20px;
    color: #666;
    margin-top: 20px;
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
            <i class="fa-solid fa-tags"></i>
        </div>

        <h2>Gestión de Categorías</h2>
<%
    if(request.getAttribute("mensaje") != null){
%>

<p style="color:red; font-weight:bold; text-align:center;">
    <%= request.getAttribute("mensaje") %>
</p>

<%
    }
%>
        <p class="descripcion">
            Administre las categorías de los productos del inventario.
        </p>

        <div class="formulario">

            <h3>Registrar Nueva Categoría</h3>

<form action="Controlador" method="post">

    <input type="hidden"
           name="accion"
           value="agregarCategoria">

    <label>Nombre de la categoría</label>

    <input type="text"
           name="nombre"
           required>

    <button type="submit" class="boton">
        Registrar Categoría
    </button>

</form>
</div>

        <hr>

<h3>Listado de Categorías</h3>

<table>

    <tr>
    <th>ID</th>
    <th>Nombre</th>
    <th>Acciones</th>
</tr>

    <%
        List<Categoria> lista =
                (List<Categoria>) request.getAttribute("listaCategoria");

        if (lista != null) {

            for (Categoria c : lista) {
    %>

    <tr>
    <td><%= c.getId_categoria() %></td>
    <td><%= c.getNombre() %></td>

    <td class="acciones">

    <i class="fa-solid fa-pen-to-square"
       onclick="window.location='editar_categoria.jsp?id=<%= c.getId_categoria() %>'">
    </i>

    <i class="fa-solid fa-trash"
       onclick="if(confirm('¿Está seguro de eliminar esta categoría?')) {
           window.location='Controlador?accion=eliminarCategoria&id=<%= c.getId_categoria() %>';
       }">
    </i>

</td>
</tr>

    <%
            }
        }
    %>

</table>
 </div>
</main>

<footer>
    Sistema de Inventarios · Categorías · © 2026
</footer>
</body>
</html>