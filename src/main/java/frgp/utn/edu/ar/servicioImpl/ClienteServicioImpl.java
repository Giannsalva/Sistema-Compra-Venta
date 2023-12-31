package frgp.utn.edu.ar.servicioImpl;

import java.util.ArrayList;

import frgp.utn.edu.ar.dao.ClienteDao;
import frgp.utn.edu.ar.dominio.Cliente;
import frgp.utn.edu.ar.servicio.ClienteServicio;
import org.springframework.dao.DataAccessException;

public class ClienteServicioImpl implements ClienteServicio {

	private ClienteDao dataAccess = null;

	public void setDataAccess(ClienteDao dataAccess) {
		this.dataAccess = dataAccess;
	}
	
	@Override
	public ArrayList<Cliente> obtenerTodos() {
		return dataAccess.obtenerTodos();
	}

	@Override
	public Cliente obtenerPorDni(String dni) {
		return dataAccess.obtenerPorDni(dni);
	}

	@Override
	public Cliente obtenerPorId(int id) {
		return dataAccess.obtenerPorId(id);
	}

	@Override
	public void insertar(Cliente c) { dataAccess.insertar(c); }

	@Override
	public void eliminar(int id) { dataAccess.eliminar(id); }

	@Override
	public void actualizar(Cliente c) { dataAccess.actualizar(c); }

}
