package mg.venteDeTerrain.service;

import mg.venteDeTerrain.entites.Terrain;
import mg.venteDeTerrain.utils.PaginationConstraint;
import mg.venteDeTerrain.utils.PaginationResult;
import mg.venteDeTerrain.utils.VenteConstraint;

import java.util.List;

public interface TerrainService {
	List<Terrain> select();
	
	List<Terrain> select(VenteConstraint constraint);
	
	List<Terrain> select_en_vente();
	
	Terrain select(int id);
	
	void insert(Terrain terrain);
	
	void update(Terrain terrain);
	
	void delete(int id);
	
	PaginationResult<Terrain> select(PaginationConstraint paginationConstraint);
	
	long countAll();
  
  List<Object[]> derniersTerrains();
}
