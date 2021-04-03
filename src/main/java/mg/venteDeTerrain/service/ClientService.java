package mg.venteDeTerrain.service;

import mg.venteDeTerrain.entites.Client;
import mg.venteDeTerrain.utils.PaginationConstraint;
import mg.venteDeTerrain.utils.PaginationResult;

import java.util.List;

public interface ClientService {
	List<Client> select();
	
	Client select(int id);
	
	void insert(Client client);
	
	void update(Client client);
	
	void delete(int id);
	
	PaginationResult<Client> select(PaginationConstraint paginationConstraint);
	
	long countAll();
	
	long countSelection(PaginationConstraint constraint);
	
	List<Client> derniersClients();
}