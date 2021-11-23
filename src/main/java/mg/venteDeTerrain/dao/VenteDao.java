package mg.venteDeTerrain.dao;

import mg.venteDeTerrain.entites.Vente;

import java.util.List;

public interface VenteDao {
	List<Vente> select();
	
	Vente select(int id);
	
	void insert(Vente vente);
	
	void update(Vente vente);
	
	void delete(int id);
	
	List<Vente> derniersVentes();
  
  long countAll();
}
