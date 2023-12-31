package frgp.utn.edu.ar.servicio;

import java.util.ArrayList;
import java.util.List;

import frgp.utn.edu.ar.dominio.Articulo;
import frgp.utn.edu.ar.dominio.Stock;

public interface StockServicio {
	
	ArrayList<Stock> obtenerTodos();
	Stock obtenerPorNombre(String nombre);
	void insertar(Stock a);
    void eliminar(int id) ;
	void actualizar(Stock a);
	Stock getbyID(int id);	
	long artByID(int id);
	Stock obtenerStockPorIdArticulo(int id);
	List<Stock> obtenerStocksDeArticulo(int idArt);
}
