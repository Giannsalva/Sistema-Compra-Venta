package frgp.utn.edu.ar.dtos;

import frgp.utn.edu.ar.dominio.Articulo;
import frgp.utn.edu.ar.dominio.Marcas;
import frgp.utn.edu.ar.dominio.TipoArticulo;
import frgp.utn.edu.ar.helpers.ArticulosHelper;

public class ArticuloRequest {
	
	private int id;
	private String nombre;
	private String descripcion;
	private Marcas marca;
	private TipoArticulo tipo;
	private double precio;
	private boolean estado;
	
	@Override
	public String toString() {
		return "Nombre: " + nombre + ", Descripcion: " + descripcion + ", Marca: " + marca.toString()
				+ ", Tipo: " + tipo.toString() + ", Precio: " + precio + "";
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Marcas getMarca() {
		return marca;
	}

	public void setMarca(Marcas m) {
		this.marca = m;
	}
	
	public TipoArticulo getTipo() {
		return tipo;
	}

	public void setTipo(TipoArticulo ta) {
		this.tipo = ta;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}
	
	public boolean isEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	public Articulo construirArticulo(){
        Articulo  a = new Articulo(nombre, descripcion, marca, tipo, precio, true);

        if(id != 0){
            a.setId(id);
        }

        return a;
    }
	
	

}
