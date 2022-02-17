package mg.ventedeterrain.dao;

import mg.ventedeterrain.entites.Terrain;
import mg.ventedeterrain.utils.PaginationConstraint;
import mg.ventedeterrain.utils.PaginationResult;
import mg.ventedeterrain.utils.VenteConstraint;

import java.util.List;

public interface TerrainDao {
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

	List<Terrain> select(int page, int limit);
}
