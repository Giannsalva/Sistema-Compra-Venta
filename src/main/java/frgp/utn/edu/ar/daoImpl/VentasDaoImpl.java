package frgp.utn.edu.ar.daoImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import frgp.utn.edu.ar.dao.VentasDao;
import frgp.utn.edu.ar.dominio.Ventas;
import frgp.utn.edu.ar.dtos.AVSFetch;

public class VentasDaoImpl  implements VentasDao{

	private HibernateTemplate hibernateTemplate = null;

	public void setSessionFactory(SessionFactory sessionFactory) {
        this.hibernateTemplate = new HibernateTemplate(sessionFactory);
    }

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public void insertar(Ventas a) {
		this.hibernateTemplate.save(a);		
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public Ventas obtenerPorId(int id) {
		return this.hibernateTemplate.get(Ventas.class, id);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public ArrayList<Ventas> obtenerTodos() {
		Query q = hibernateTemplate.getSessionFactory().getCurrentSession()
				.createQuery("FROM Ventas v WHERE v.estado=true");
	    List<Ventas> resultados = q.list();
	    return new ArrayList<>(resultados);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public List<Ventas> obtenerPorRangoFechas(Date fechaIni, Date fechaFin) {
		Query query = this.hibernateTemplate.getSessionFactory()
				.getCurrentSession()
				.createQuery("from Ventas " +
						"where estado=true and fecha between :fechaIni and :fechaFin");

		query.setParameter("fechaIni", fechaIni);
		query.setParameter("fechaFin", fechaFin);

		return (ArrayList<Ventas>)query.list();
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public double obtenerTotalPorRangoFechas(Date fechaIni, Date fechaFin) {
		Query query = this.hibernateTemplate.getSessionFactory()
				.getCurrentSession()
				.createQuery("select sum(montoTotal) from Ventas " +
						"where estado=true and fecha between :fechaIni and :fechaFin");

		query.setParameter("fechaIni", fechaIni);
		query.setParameter("fechaFin", fechaFin);
        query.setMaxResults(1);

		Object result = query.uniqueResult();
		if(result == null)
			return 0;
		return (double)result;
	}
	
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	public double obtenerGananciaTotalPorRangoFechas(Date fechaIni, Date fechaFin) {
		Query query = this.hibernateTemplate.getSessionFactory()
				.getCurrentSession()
				.createQuery("select sum(ganancia) from Ventas " +
						"where estado=true and fecha between :fechaIni and :fechaFin");

		query.setParameter("fechaIni", fechaIni);
		query.setParameter("fechaFin", fechaFin);
		query.setMaxResults(1);

		Object result = query.uniqueResult();
		if(result == null)
			return 0;
		return (double)result;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	public void eliminar(int id) {
		Ventas a = obtenerPorId(id);
		this.hibernateTemplate.delete(a);		
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public void actualizar(Ventas a) {
		this.hibernateTemplate.update(a);		
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public AVSFetch fetchVentaDetails(int id) {
		String hql = "SELECT h.cantidadDeducida, a.descripcion, a.precio FROM Historico h " +
	             "INNER JOIN h.venta v " +
	             "INNER JOIN h.stock s " +
	             "INNER JOIN s.articulo a " +
	             "WHERE h.id = :idH";	
		
		Query query = this.hibernateTemplate.getSessionFactory()
				.getCurrentSession()
				.createQuery(hql);

		query.setParameter("idH", id);

		Object result = query.uniqueResult();
		if (result == null) {
		    return null;
		}

		Object[] row = (Object[]) result;
		int cantidadDeducida = (int) row[0];
		String descripcion = (String) row[1];
		double precio = (double) row[2];

		AVSFetch avsFetch = new AVSFetch(descripcion, cantidadDeducida, precio);
		return avsFetch;
	}
	
}
