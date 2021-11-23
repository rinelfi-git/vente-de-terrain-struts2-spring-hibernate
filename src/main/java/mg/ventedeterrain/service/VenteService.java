package mg.ventedeterrain.service;

import mg.ventedeterrain.entites.Vente;

import java.util.List;

public interface VenteService {
	List<Vente> select();
	
	Vente select(int id);
	
	void insert(Vente vente);
	
	void update(Vente vente);
	
	void delete(int id);
  
  long countAll();
}
