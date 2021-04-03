package mg.venteDeTerrain.service;

import mg.venteDeTerrain.dao.ClientDao;
import mg.venteDeTerrain.entites.Client;
import mg.venteDeTerrain.utils.PaginationConstraint;
import mg.venteDeTerrain.utils.PaginationResult;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public class ClientServiceModel implements ClientService {
	private ClientDao dao;
	
	@Override
	public void insert(Client client) {
		this.dao.insert(client);
	}
	
	@Override
	public void update(Client client) {
		this.dao.update(client);
	}
	
	@Override
	public void delete(int id) {
		this.dao.delete(id);
	}
	
	@Override
	public PaginationResult<Client> select(PaginationConstraint paginationConstraint) {
		return this.dao.select(paginationConstraint);
	}
	
	@Override
	public long countAll() {
		return this.dao.countAll();
	}
	
	@Override
	public long countSelection(PaginationConstraint constraint) {
		return this.dao.countSelection(constraint);
	}
	
	@Override
	public List<Client> derniersClients() {
		return this.dao.derniersClients();
	}
	
	@Override
	public List<Client> select() {
		return this.dao.select();
	}
	
	@Override
	public Client select(int id) {
		return this.dao.select(id);
	}
	
	public void setDao(ClientDao dao) {
		this.dao = dao;
	}
}
