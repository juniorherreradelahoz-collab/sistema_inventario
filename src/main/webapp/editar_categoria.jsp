<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.sistema_inventario.Categoria" %>
<%@ page import="com.mycompany.sistema_inventario.CategoriaDAO" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    CategoriaDAO dao = new CategoriaDAO();
    Categoria c = dao.buscarPorId(id);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Categoría</title>

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
            max-width: 700px;
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

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--borde);
            border-radius: 8px;
            margin-bottom: 14px;
            font-size: 1rem;
            box-sizing: border-box;
            height: 45px;
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
        .boton-cancelar {
    width: 100%;
    padding: 15px;
    background-color: #95a5a6;
    color: white;
    font-size: 1.1rem;
    font-weight: 600;
    border: none;
    border-radius: 999px;
    cursor: pointer;
    margin-top: 10px;
    transition: background-color 0.15s ease;
}

.boton-cancelar:hover {
    background-color: #7f8c8d;
}   
    </style>
</head>

<body>

<main>
    <div class="card">

        <h2>Editar Categoría</h2>

        <div class="formulario">

            <form action="Controlador" method="post">

                <input type="hidden"
                       name="accion"
                       value="editarCategoria">

                <input type="hidden"
                       name="id"
                       value="<%= c.getId_categoria() %>">

                <label>Nombre de la categoría</label>

                <input type="text"
                       name="nombre"
                       value="<%= c.getNombre() %>"
                       required>

                <button type="submit" class="boton">
    Guardar Cambios
</button>

<button type="button"
        class="boton-cancelar"
        onclick="window.location='Controlador?accion=listarCategoria'">
    Cancelar
</button>

            </form>

        </div>

    </div>
</main>

</body>
</html>