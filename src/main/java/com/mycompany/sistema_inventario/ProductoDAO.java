package com.mycompany.sistema_inventario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // LISTAR PRODUCTOS
    public List<Producto> listar() 
    
    {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT p.*, c.nombre AS nombreCategoria "
           + "FROM producto p "
           + "INNER JOIN categoria c "
           + "ON p.idCategoria = c.idCategoria";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
    Producto p = new Producto();
    p.setIdproducto(rs.getInt("idProducto"));
    p.setCodigo(rs.getString("codigo"));
    p.setNombre(rs.getString("nombre"));
    p.setDescripcion(rs.getString("descripcion"));
    p.setEstado(rs.getInt("estado"));
    p.setIdcategoria(rs.getInt("idCategoria"));
    p.setNombreCategoria(rs.getString("nombreCategoria"));
    lista.add(p);
}

        } catch (Exception e) {
            System.out.println("Error al listar productos: " + e.getMessage());
        }

        return lista;
    }
    public List<Producto> buscar(String texto, String categoria) {

    List<Producto> lista = new ArrayList<>();

    String sql = "SELECT p.*, c.nombre AS nombreCategoria "
            + "FROM producto p "
            + "INNER JOIN categoria c ON p.idCategoria = c.idCategoria "
            + "WHERE (p.codigo LIKE ? OR p.nombre LIKE ?)";

    if (categoria != null && !categoria.isEmpty()) {
        sql += " AND p.idCategoria = ?";
    }

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);

        ps.setString(1, "%" + texto + "%");
        ps.setString(2, "%" + texto + "%");

        if (categoria != null && !categoria.isEmpty()) {
            ps.setInt(3, Integer.parseInt(categoria));
        }

        rs = ps.executeQuery();

        while (rs.next()) {

            Producto p = new Producto();

            p.setIdproducto(rs.getInt("idProducto"));
            p.setCodigo(rs.getString("codigo"));
            p.setNombre(rs.getString("nombre"));
            p.setDescripcion(rs.getString("descripcion"));
            p.setEstado(rs.getInt("estado"));
            p.setIdcategoria(rs.getInt("idCategoria"));
            p.setNombreCategoria(rs.getString("nombreCategoria"));

            lista.add(p);
        }

    } catch (Exception e) {
        System.out.println("Error al buscar productos: " + e.getMessage());
    }

    return lista;
}

    // AGREGAR PRODUCTO
    public boolean agregar(Producto p) {
        String sql = "INSERT INTO producto(codigo, nombre, descripcion, estado, idCategoria) VALUES(?,?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, p.getCodigo());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getDescripcion());
            ps.setInt(4, p.getEstado());
            ps.setInt(5, p.getIdcategoria());
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error al agregar producto: " + e.getMessage());
        }

        return false;
    }

    // EDITAR PRODUCTO
    public boolean editar(Producto p) {
        String sql = "UPDATE producto SET codigo=?, nombre=?, descripcion=?, estado=?, idcategoria=? WHERE idproducto=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, p.getCodigo());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getDescripcion());
            ps.setInt(4, p.getEstado());
            ps.setInt(5, p.getIdcategoria());
            ps.setInt(6, p.getIdproducto());
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error al editar producto: " + e.getMessage());
        }

        return false;
    }
    public Producto buscarPorId(int id) {
    Producto p = null;
    String sql = "SELECT * FROM producto WHERE idProducto = ?";

    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
            p = new Producto();
            p.setIdproducto(rs.getInt("idProducto"));
            p.setCodigo(rs.getString("codigo"));
            p.setNombre(rs.getString("nombre"));
            p.setDescripcion(rs.getString("descripcion"));
            p.setEstado(rs.getInt("estado"));
            p.setIdcategoria(rs.getInt("idCategoria"));
        }

    } catch (Exception e) {
        System.out.println("Error al buscar producto: " + e.getMessage());
    }

    return p;
}


    // ELIMINAR PRODUCTO
    public boolean eliminar(int id) {
        String sql = "DELETE FROM producto WHERE idproducto=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error al eliminar producto: " + e.getMessage());
        }

        return false;
    }
    // GENERAR CÓDIGO AUTOMÁTICO
    public String generarCodigo() {
        String codigo = "00001"; // valor inicial si no hay productos
        String sql = "SELECT codigo FROM producto ORDER BY idProducto DESC LIMIT 1";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                String ultimo = rs.getString("codigo"); // ejemplo: "00015"
                int num = Integer.parseInt(ultimo);     // 15
                num++;                                  // 16
                codigo = String.format("%05d", num);    // "00016"
            }

        } catch (Exception e) {
            System.out.println("Error al generar código: " + e.getMessage());
        }

        return codigo;
    }
}
