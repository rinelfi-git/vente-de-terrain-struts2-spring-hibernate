package mg.ventedeterrain.dao;

import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.utils.PaginationConstraint;

import java.util.List;

public interface ClientDao {
	List<Client> select();
	
	Client select(int id);
	
	void insert(Client client);
	
	void update(Client client);
	
	void delete(int id);
	
	List<Client> select(PaginationConstraint paginationConstraint);
	
	long countAll();
	
	long countAll(PaginationConstraint paginationConstraint);
	
	long countSelection(PaginationConstraint constraint);
	
	List<Object[]> derniersClients();
}
