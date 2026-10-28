package com.mycompany.sistema_inventario;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {

    CategoriaDAO categoriaDAO = new CategoriaDAO();
    ProductoDAO productoDAO = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "home";
        }

        switch (accion) {

            // ============================
            // CATEGORÍA
            // ============================
            case "listarCategoria":
                List<Categoria> listaCat = categoriaDAO.listar();
                request.setAttribute("listaCategoria", listaCat);
                request.getRequestDispatcher("categoria.jsp").forward(request, response);
                break;

            case "agregarCategoria":
                String nombreCat = request.getParameter("nombre");
                Categoria c = new Categoria();
                c.setNombre(nombreCat);
                categoriaDAO.agregar(c);
                response.sendRedirect("Controlador?accion=listarCategoria");
                break;

            case "editarCategoria":
                int idCat = Integer.parseInt(request.getParameter("id"));
                String nombreNuevo = request.getParameter("nombre");
                Categoria cEdit = new Categoria(idCat, nombreNuevo);
                categoriaDAO.editar(cEdit);
                response.sendRedirect("Controlador?accion=listarCategoria");
                break;

            case "eliminarCategoria":

    int idEliminarCat = Integer.parseInt(request.getParameter("id"));

    if (categoriaDAO.tieneProductos(idEliminarCat)) {

        request.setAttribute(
            "mensaje",
            "No se puede eliminar la categoría porque tiene productos asociados."
        );

        List<Categoria> listaCategorias = categoriaDAO.listar();
        request.setAttribute("listaCategoria", listaCategorias);

        request.getRequestDispatcher("categoria.jsp")
               .forward(request, response);

    } else {

        categoriaDAO.eliminar(idEliminarCat);
        response.sendRedirect("Controlador?accion=listarCategoria");
    }

    break;

            // ============================
            // PRODUCTO
            // ============================
            case "listarProducto":
                List<Producto> listaProd = productoDAO.listar();
                request.setAttribute("listaProducto", listaProd);
                request.getRequestDispatcher("producto.jsp").forward(request, response);
                break;
case "buscarProducto":

    String texto = request.getParameter("texto");
    String categoria = request.getParameter("categoria");

    if (texto == null) {
        texto = "";
    }

    List<Producto> productosFiltrados =
            productoDAO.buscar(texto, categoria);

    request.setAttribute("textoBuscado", texto);
    request.setAttribute("categoriaSeleccionada", categoria);
    request.setAttribute("listaProducto", productosFiltrados);

    request.getRequestDispatcher("producto.jsp")
           .forward(request, response);
    break;
            case "agregarProducto":
                Producto p = new Producto();
                p.setCodigo(productoDAO.generarCodigo());
                p.setNombre(request.getParameter("nombre"));
                p.setDescripcion(request.getParameter("descripcion"));
                p.setEstado(Integer.parseInt(request.getParameter("estado")));
                p.setIdcategoria(Integer.parseInt(request.getParameter("idcategoria")));
                productoDAO.agregar(p);
                response.sendRedirect("Controlador?accion=listarProducto");
                break;

            case "editarProducto":
                Producto pEdit = new Producto();
                pEdit.setIdproducto(Integer.parseInt(request.getParameter("id")));
                pEdit.setCodigo(request.getParameter("codigo"));
                pEdit.setNombre(request.getParameter("nombre"));
                pEdit.setDescripcion(request.getParameter("descripcion"));
                pEdit.setEstado(Integer.parseInt(request.getParameter("estado")));
                pEdit.setIdcategoria(Integer.parseInt(request.getParameter("idcategoria")));
                productoDAO.editar(pEdit);
                response.sendRedirect("Controlador?accion=listarProducto");
                break;

            case "eliminarProducto":
                int idProd = Integer.parseInt(request.getParameter("id"));
                productoDAO.eliminar(idProd);
                response.sendRedirect("Controlador?accion=listarProducto");
                break;

            default:
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
