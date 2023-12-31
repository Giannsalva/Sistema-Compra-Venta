package frgp.utn.edu.ar.servicio;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import frgp.utn.edu.ar.dominio.Ventas;
import frgp.utn.edu.ar.dtos.ConsultaVentasResponse;

public interface VentasService {
	
	ArrayList<Ventas> obtenerTodos();
	List<ConsultaVentasResponse> obtenerPorRangoDeFechas(Date fechaIni, Date fechaFin);

	void crearVenta(List<String> idsArticulos,
					List<String> idsCantidades,
					String fechaVenta,
					int clienteId);

    void eliminar(int id) ;
    
    void actualizar (Ventas id);

	Ventas getbyID(int id);

	public double obtenerTotalPorRangoFechas(Date fechaIni, Date fechaFin);
	public double obtenerGananciaTotalPorRangoFechas(Date fechaIni, Date fechaFin);
	public ModelAndView buildDetalle(int id, String view);
}
