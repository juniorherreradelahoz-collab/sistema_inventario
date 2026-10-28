package com.mycompany.sistema_inventario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public List<Categoria> listar() {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM categoria";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId_categoria(rs.getInt("idcategoria"));
                c.setNombre(rs.getString("nombre"));
                lista.add(c);
            }

        } catch (Exception e) {
            System.out.println("Error al listar categorías: " + e.getMessage());
        }

        return lista;
    }

    public boolean agregar(Categoria c) {
        String sql = "INSERT INTO categoria(nombre) VALUES(?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, c.getNombre());
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error al agregar categoría: " + e.getMessage());
        }

        return false;
    }
public Categoria buscarPorId(int id) {

    Categoria c = null;
    String sql = "SELECT * FROM categoria WHERE idcategoria = ?";

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);

        ps.setInt(1, id);

        rs = ps.executeQuery();

        if (rs.next()) {

            c = new Categoria();

            c.setId_categoria(rs.getInt("idcategoria"));
            c.setNombre(rs.getString("nombre"));
        }

    } catch (Exception e) {
        System.out.println("Error al buscar categoría: " + e.getMessage());
    }

    return c;
}
    public boolean editar(Categoria c) {
        String sql = "UPDATE categoria SET nombre=? WHERE idcategoria=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, c.getNombre());
            ps.setInt(2, c.getId_categoria());
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error al editar categoría: " + e.getMessage());
        }

        return false;
    }
public boolean tieneProductos(int idCategoria) {

    String sql = "SELECT COUNT(*) FROM producto WHERE idCategoria = ?";

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);

        ps.setInt(1, idCategoria);

        rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt(1) > 0;
        }

    } catch (Exception e) {
        System.out.println("Error al validar productos asociados: " + e.getMessage());
    }

    return false;
}
    public boolean eliminar(int id) {
        String sql = "DELETE FROM categoria WHERE idcategoria=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.out.println("Error al eliminar categoría: " + e.getMessage());
        }

        return false;
    }
}
