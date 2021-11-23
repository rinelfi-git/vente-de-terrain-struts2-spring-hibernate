package mg.venteDeTerrain.dao.jpa;

import mg.venteDeTerrain.dao.ClientDao;
import mg.venteDeTerrain.entites.Client;
import mg.venteDeTerrain.utils.PaginationConstraint;
import mg.venteDeTerrain.utils.PaginationResult;

import javax.persistence.*;
import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

public class ClientModel implements ClientDao {
	
	@PersistenceContext
	private EntityManager entityManager;
	
	public ClientModel() { }
	
	@Override
	public List<Client> select() {
		TypedQuery<Client> query = entityManager.createQuery("from Client order by nom asc, prenom asc, cin asc", Client.class);
		return query.getResultList();
	}
	
	@Override
	public Client select(int id) {
		return this.entityManager.find(Client.class, id);
	}
	
	@Override
	public void insert(Client client) {
		this.entityManager.persist(client);
		this.entityManager.flush();
	}
	
	@Override
	public void update(Client client) {
		this.entityManager.merge(client);
		this.entityManager.flush();
	}
	
	@Override
	public void delete(int id) {
		Query query = this.entityManager.createQuery("delete from Client where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
		this.entityManager.flush();
	}
	
	@Override
	public PaginationResult<Client> select(PaginationConstraint constraint) {
		PaginationResult<Client> pagination = new PaginationResult<>();
		CriteriaBuilder criteria_builder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Client> criteria_query = criteria_builder.createQuery(Client.class);
		Root<Client> client_root = criteria_query.from(Client.class);
		
		if (constraint.isOrdered()) {
			if (constraint.getOrderField().equalsIgnoreCase("nom")) {
				List<Order> orders = new ArrayList<>();
				if (constraint.getOrderDirection().equalsIgnoreCase("asc")) {
					orders.add(criteria_builder.asc(client_root.get("nom")));
					orders.add(criteria_builder.asc(client_root.get("prenom")));
				} else {
					orders.add(criteria_builder.desc(client_root.get("nom")));
					orders.add(criteria_builder.desc(client_root.get("prenom")));
				}
				criteria_query.orderBy(orders);
			} else {
				if (constraint.getOrderDirection().equalsIgnoreCase("asc")) criteria_query.orderBy(criteria_builder.asc(client_root.get(constraint.getOrderField())));
				else criteria_query.orderBy(criteria_builder.desc(client_root.get(constraint.getOrderField())));
			}
		} else {
			List<Order> order_by_list = new ArrayList<>();
			order_by_list.add(criteria_builder.asc(client_root.get("nom")));
			order_by_list.add(criteria_builder.asc(client_root.get("prenom")));
			order_by_list.add(criteria_builder.asc(client_root.get("cin")));
			criteria_query.orderBy(order_by_list);
		}
		
		if (constraint.isSearchActive()) {
			switch (constraint.getSearchField()) {
				case "nom":
					String[] splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
					Predicate[] predicates = new Predicate[splits.length * 2];
					int index = 0;
					for (String split : splits) {
						predicates[index++] = criteria_builder.like(criteria_builder.upper(client_root.get("nom")), "%" + split + "%");
						predicates[index++] = criteria_builder.like(criteria_builder.upper(client_root.get("prenom")), "%" + split + "%");
					}
					criteria_query.where(criteria_builder.or(predicates));
					break;
				case "adresse":
					String[] adresse_splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
					Predicate[] adresse_predicates = new Predicate[adresse_splits.length * 3];
					int adresse_index = 0;
					for (String adresse_split : adresse_splits) {
						adresse_predicates[adresse_index++] = criteria_builder.like(client_root.get("adresse").get("codePostal").as(String.class), "%" + adresse_split + "%");
						adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("ville")), "%" + adresse_split + "%");
						adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("lot")), "%" + adresse_split + "%");
					}
					criteria_query.where(criteria_builder.or(adresse_predicates));
					break;
				default:
					Predicate where_predicate = criteria_builder.like(criteria_builder.upper(client_root.get(constraint.getSearchField())), "%" + constraint.getKeywordSearch().toUpperCase() + "%");
					criteria_query.where(where_predicate);
					break;
			}
		}
		
		TypedQuery<Client> query = entityManager.createQuery(criteria_query);
		query.setFirstResult(constraint.getLimit());
		query.setMaxResults(constraint.getOffset());
		pagination.setElements(query.getResultList());
		pagination.setLimit(constraint.getLimit());
		pagination.setOffset(constraint.getOffset());
		return pagination;
	}
	
	@Override
	public long countAll() {
		TypedQuery<Long> query = this.entityManager.createQuery("select count(id) from Client", Long.class);
		return query.getSingleResult();
	}
	
	@Override
	public long countSelection(PaginationConstraint constraint) {
		CriteriaBuilder criteria_builder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Long> criteria_query = criteria_builder.createQuery(Long.class);
		Root<Client> client_root = criteria_query.from(Client.class);
		switch (constraint.getSearchField()) {
			case "nom":
				String[] nom_splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
				Predicate[] nom_predicates = new Predicate[nom_splits.length * 2];
				int nom_index = 0;
				for (String split : nom_splits) {
					nom_predicates[nom_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("nom")), "%" + split + "%");
					nom_predicates[nom_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("prenom")), "%" + split + "%");
				}
				criteria_query.where(criteria_builder.or(nom_predicates));
				break;
			case "adresse":
				String[] adresse_splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
				Predicate[] adresse_predicates = new Predicate[adresse_splits.length * 3];
				int adresse_index = 0;
				for (String adresse_split : adresse_splits) {
					adresse_predicates[adresse_index++] = criteria_builder.like(client_root.get("adresse").get("codePostal").as(String.class), "%" + adresse_split + "%");
					adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("ville")), "%" + adresse_split + "%");
					adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("lot")), "%" + adresse_split + "%");
				}
				criteria_query.where(criteria_builder.or(adresse_predicates));
				break;
			default:
				Predicate where_predicate = criteria_builder.like(criteria_builder.upper(client_root.get(constraint.getSearchField())), "%" + constraint.getKeywordSearch().toUpperCase() + "%");
				criteria_query.where(where_predicate);
				break;
		}
		criteria_query.select(criteria_builder.count(client_root.get("cin")));
		return entityManager.createQuery(criteria_query).getSingleResult();
	}
	
	@Override
	public List<Object[]> derniersClients() {
		TypedQuery<Object[]> query = this.entityManager.createQuery("select nom, prenom, photo from Client as c order by id desc", Object[].class);
		query.setFirstResult(0);
		query.setMaxResults(7);
		return query.getResultList();
	}
}
