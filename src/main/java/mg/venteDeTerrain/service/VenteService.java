package mg.venteDeTerrain.service;

import mg.venteDeTerrain.entites.Vente;

import java.util.List;

public interface VenteService {
	List<Vente> select();
	
	Vente select(int id);
	
	void insert(Vente vente);
	
	void update(Vente vente);
	
	void delete(int id);
}
