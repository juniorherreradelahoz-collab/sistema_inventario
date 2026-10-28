package com.mycompany.sistema_inventario;
    
public class Producto {

    private int idproducto;
    private String codigo;
    private String nombre;
    private String descripcion;
    private int estado;
    private int idcategoria;
    private String nombreCategoria;

    public Producto() {
    }

    public Producto(int idproducto, String codigo, String nombre, String descripcion, int estado, int idcategoria) {
        this.idproducto = idproducto;
        this.codigo = codigo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.estado = estado;
        this.idcategoria = idcategoria;
    }

    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getIdcategoria() {
        return idcategoria;
    }
    public void setIdcategoria(int idcategoria) {
        this.idcategoria = idcategoria;
    }
    public String getNombreCategoria() {
    return nombreCategoria;
}

public void setNombreCategoria(String nombreCategoria) {
    this.nombreCategoria = nombreCategoria;
}
}
