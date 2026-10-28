
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mycompany.sistema_inventario.ProductoDAO" %>
<%@ page import="com.mycompany.sistema_inventario.Producto" %>
<%@ page import="com.mycompany.sistema_inventario.Categoria" %>
<%@ page import="com.mycompany.sistema_inventario.CategoriaDAO" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    ProductoDAO dao = new ProductoDAO();
    Producto p = dao.buscarPorId(id);
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Producto</title>

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

    main {
      padding: 40px;
      display: flex;
      justify-content: center;
    }

    .card {
      width: 100%;
      max-width: 900px;
      background: #fff;
      border: 1px solid var(--borde);
      border-radius: 14px;
      padding: 30px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    }

    h2 {
      text-align: center;
      margin-bottom: 10px;
      font-size: 1.4rem;
    }

    .formulario {
      margin-top: 20px;
      background: #f9f9f9;
      padding: 20px;
      border-radius: 12px;
      border: 1px solid var(--borde);
    }

    label {
      font-weight: 600;
      margin-bottom: 8px;
      display: block;
    }

    input,
textarea,
select {
    width: 100%;
    padding: 12px;
    border: 1px solid var(--borde);
    border-radius: 8px;
    margin-bottom: 14px;
    font-size: 1rem;
    box-sizing: border-box;
}

    /* UNIFORMIDAD DE ALTURA */
    input,
select {
    height: 45px;
}

    textarea {
      height: 45px;
      padding-top: 10px;
      resize: none;
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
  </style>
</head>

<body>

<main>
  <div class="card">

    <h2>Editar Producto</h2>

    <div class="formulario">
      <form action="Controlador" method="post">
        <input type="hidden" name="accion" value="editarProducto">
        <input type="hidden" name="id" value="<%= p.getIdproducto() %>">

        <label>Código del producto</label>
        <input type="text" name="codigo" value="<%= p.getCodigo() %>" required>

        <label>Nombre del producto</label>
        <input type="text" name="nombre" value="<%= p.getNombre() %>" required>

        <label>Descripción</label>
        <textarea name="descripcion"><%= p.getDescripcion() %></textarea>

        <label>Estado</label>
<select name="estado" required>
    <option value="1"
        <%= p.getEstado() == 1 ? "selected" : "" %>>
        Activo
    </option>

    <option value="0"
        <%= p.getEstado() == 0 ? "selected" : "" %>>
        Inactivo
    </option>
</select>

        <label>Categoría</label>

<select name="idcategoria" required>

<%
    CategoriaDAO cdao = new CategoriaDAO();
    List<Categoria> categorias = cdao.listar();

    for(Categoria cat : categorias){
%>

<option value="<%= cat.getId_categoria() %>"
    <%= cat.getId_categoria() == p.getIdcategoria() ? "selected" : "" %>>
    <%= cat.getNombre() %>
</option>

<%
    }
%>

</select>

        <button class="boton">Guardar Cambios</button>
      </form>
    </div>

  </div>
</main>

</body>
</html>
