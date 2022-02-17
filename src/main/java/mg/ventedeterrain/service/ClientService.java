package mg.ventedeterrain.service;

import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.utils.PaginationConstraint;
import mg.ventedeterrain.utils.PaginationResult;

import java.util.List;

public interface ClientService {
	List<Client> select();
	
	Client select(int id);
	
	void insert(Client client);
	
	void update(Client client);
	
	void delete(int id);
	
	List<Client> select(PaginationConstraint paginationConstraint);
	
	long countAll();
	
	long countSelection(PaginationConstraint constraint);
	
	List<Object[]> derniersClients();
}
