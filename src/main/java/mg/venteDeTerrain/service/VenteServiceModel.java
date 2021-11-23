package mg.venteDeTerrain.service;

import mg.venteDeTerrain.dao.VenteDao;
import mg.venteDeTerrain.entites.Vente;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public class VenteServiceModel implements VenteService {
	private VenteDao dao;
	
	@Override
	public void insert(Vente vente) {
		this.dao.insert(vente);
	}
	
	@Override
	public void update(Vente vente) {
		this.dao.update(vente);
	}
	
	@Override
	public void delete(int id) {
		this.dao.delete(id);
	}
	
	@Override
	public long countAll() {
		return this.dao.countAll();
	}
	
	@Override
	public List<Vente> select() {
		return this.dao.select();
	}
	
	@Override
	public Vente select(int id) {
		return this.dao.select(id);
	}
	
	public void setDao(VenteDao dao) {
		this.dao = dao;
	}
}
