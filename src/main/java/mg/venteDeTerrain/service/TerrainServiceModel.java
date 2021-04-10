package mg.venteDeTerrain.service;

import mg.venteDeTerrain.dao.TerrainDao;
import mg.venteDeTerrain.entites.Terrain;
import mg.venteDeTerrain.utils.PaginationConstraint;
import mg.venteDeTerrain.utils.PaginationResult;
import mg.venteDeTerrain.utils.VenteConstraint;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public class TerrainServiceModel implements TerrainService {
	private TerrainDao dao;
	
	@Override
	public void insert(Terrain terrain) {
		this.dao.insert(terrain);
	}
	
	@Override
	public void update(Terrain terrain) {
		this.dao.update(terrain);
	}
	
	@Override
	public void delete(int id) {
		this.dao.delete(id);
	}
	
	@Override
	public PaginationResult<Terrain> select(PaginationConstraint paginationConstraint) {
		return this.dao.select(paginationConstraint);
	}
	
	@Override
	public long countAll() {
		return this.dao.countAll();
	}
	
	@Override
	public List<Object[]> derniersTerrains() {
		return this.dao.derniersTerrains();
	}
	
	@Override
	public List<Terrain> select() {
		return this.dao.select();
	}
	
	@Override
	public List<Terrain> select(VenteConstraint constraint) {
		return this.dao.select(constraint);
	}
	
	@Override
	public List<Terrain> select_en_vente() {
		return this.dao.select_en_vente();
	}
	
	@Override
	public Terrain select(int id) {
		return this.dao.select(id);
	}
	
	public void setDao(TerrainDao dao) {
		this.dao = dao;
	}
}
