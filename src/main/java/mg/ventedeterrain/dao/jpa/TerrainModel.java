package mg.ventedeterrain.dao.jpa;

import mg.ventedeterrain.dao.TerrainDao;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.entites.Terrain;
import mg.ventedeterrain.utils.AppConst;
import mg.ventedeterrain.utils.PaginationConstraint;
import mg.ventedeterrain.utils.PaginationResult;
import mg.ventedeterrain.utils.VenteConstraint;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

public class TerrainModel implements TerrainDao {
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Override
	public List<Terrain> select() {
		return entityManager.createQuery("select t from Terrain as t inner join Client as c on c = t.proprietaire order by t.localisation asc, c.nom asc, c.prenom asc", Terrain.class).getResultList();
	}
	
	@Override
	public List<Terrain> select(VenteConstraint constraint) {
		CriteriaBuilder criteria_builder = this.entityManager.getCriteriaBuilder();
		CriteriaQuery<Terrain> criteria_query = criteria_builder.createQuery(Terrain.class);
		Root<Terrain> terrain_root = criteria_query.from(Terrain.class);
		List<Predicate> where_predicate = new ArrayList<>();
		
		if(!constraint.getLocalisation().equals("")) {
			where_predicate.add(criteria_builder.like(criteria_builder.upper(terrain_root.get("localisation")), "%" + constraint.getLocalisation().toUpperCase() + "%"));
		}
		
		if(!constraint.getSurfaceConstraint().equals(AppConst.NOT)) {
			switch (constraint.getSurfaceConstraint()) {
				case AppConst.GREATER_THAN:
					where_predicate.add(criteria_builder.gt(terrain_root.get("surface"), constraint.getSurface()));
					break;
				case AppConst.LOWER_THAN:
					where_predicate.add(criteria_builder.lt(terrain_root.get("surface"), constraint.getSurface()));
					break;
				case AppConst.EQUAL:
					where_predicate.add(criteria_builder.equal(terrain_root.get("surface"), constraint.getSurface()));
					break;
			}
		}
		
		if(!constraint.getBudgetConstraint().equals(AppConst.NOT)) {
			switch (constraint.getBudgetConstraint()) {
				case AppConst.GREATER_THAN:
					where_predicate.add(criteria_builder.gt(terrain_root.get("surface"), constraint.getBudget()));
					break;
				case AppConst.LOWER_THAN:
					where_predicate.add(criteria_builder.lt(terrain_root.get("surface"), constraint.getBudget()));
					break;
				case AppConst.EQUAL:
					where_predicate.add(criteria_builder.equal(terrain_root.get("surface"), constraint.getBudget()));
					break;
			}
		}
		
		if(!constraint.getRelief().equals(AppConst.REQUEST_ALL)) {
			where_predicate.add(criteria_builder.equal(criteria_builder.upper(terrain_root.get("relief")), constraint.getRelief().toUpperCase()));
		}
		
		where_predicate.add(criteria_builder.equal(terrain_root.get("enVente"), true));
		
		Predicate[] array_where_predicate = new Predicate[where_predicate.size()];
		
		for(int index = 0; index < array_where_predicate.length; index++) {
			array_where_predicate[index] = where_predicate.get(index);
		}
		
		if(where_predicate.size() > 0) { criteria_query.where(array_where_predicate); }
		return this.entityManager.createQuery(criteria_query).getResultList();
	}
	
	@Override
	public List<Terrain> select_en_vente() {
		Query query = entityManager.createQuery("select terrain from Terrain terrain where terrain.enVente = :en_vente", Terrain.class);
		query.setParameter("en_vente", true);
		return query.getResultList();
	}
	
	@Override
	public Terrain select(int id) {
		return this.entityManager.find(Terrain.class, id);
	}
	
	@Override
	public void insert(Terrain terrain) {
		this.entityManager.persist(terrain);
		this.entityManager.flush();
	}
	
	@Override
	public void update(Terrain terrain) {
		this.entityManager.merge(terrain);
		this.entityManager.flush();
	}
	
	@Override
	public void delete(int id) {
		Terrain terrain = this.entityManager.find(Terrain.class, id);
		this.entityManager.remove(terrain);
		this.entityManager.flush();
	}
	
	@Override
	public PaginationResult<Terrain> select(PaginationConstraint constraint) {
		PaginationResult<Terrain> pagination = new PaginationResult<>();
		CriteriaBuilder criteria_builder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Terrain> criteria_query = criteria_builder.createQuery(Terrain.class);
		Root<Terrain> terrain_root = criteria_query.from(Terrain.class);
		Join<Terrain, Client> client_join = terrain_root.join("proprietaire", JoinType.INNER);
		
		if (constraint.isOrdered()) {
			if (constraint.getOrderField().equalsIgnoreCase("proprietaire")) {
				List<Order> orders = new ArrayList<>();
				if (constraint.getOrderDirection().equalsIgnoreCase("asc")){
					orders.add(criteria_builder.asc(client_join.get("nom")));
					orders.add(criteria_builder.asc(client_join.get("prenom")));
				}else{
					orders.add(criteria_builder.desc(client_join.get("nom")));
					orders.add(criteria_builder.desc(client_join.get("prenom")));
				}
				criteria_query.orderBy(orders);
			} else {
				if (constraint.getOrderDirection().equalsIgnoreCase("asc"))
					criteria_query.orderBy(criteria_builder.asc(client_join.get(constraint.getOrderDirection())));
				else
					criteria_query.orderBy(criteria_builder.desc(client_join.get(constraint.getOrderDirection())));
			}
		} else {
			List<Order> orders = new ArrayList<>();
			orders.add(criteria_builder.asc(terrain_root.get("localisation")));
			orders.add(criteria_builder.asc(client_join.get("nom")));
			orders.add(criteria_builder.asc(client_join.get("prenom")));
			criteria_query.orderBy(orders);
		}
		
		if (constraint.isSearchActive()) {
			Predicate predicate_field;
			if (constraint.getOrderField().equalsIgnoreCase("proprietaire")) {
				Predicate proprietaire_nom = criteria_builder.like(criteria_builder.upper(client_join.get("nom")), String.format("%%s%", constraint.getKeywordSearch().toUpperCase()));
				Predicate proprietaire_prenom = criteria_builder.like(criteria_builder.upper(client_join.get("prenom")), String.format("%%s%", constraint.getKeywordSearch().toUpperCase()));
				predicate_field = criteria_builder.or(proprietaire_nom, proprietaire_prenom);
			} else {
				predicate_field = criteria_builder.like(criteria_builder.upper(client_join.get(constraint.getSearchField())), String.format("%%s%", constraint.getKeywordSearch().toUpperCase()));
			}
			criteria_query.where(predicate_field);
		}
		
		Query query = entityManager.createQuery(criteria_query);
		query.setFirstResult(constraint.getLimit());
		query.setMaxResults(constraint.getOffset());
		pagination.setElements(query.getResultList());
		pagination.setLimit(constraint.getLimit());
		pagination.setOffset(constraint.getOffset());
		return pagination;
	}
	
	@Override
	public long countAll() {
		TypedQuery<Long> query = this.entityManager.createQuery("select count(id) from Terrain", Long.class);
		return query.getSingleResult();
	}
	
	@Override
	public List<Object[]> derniersTerrains() {
		TypedQuery<Object[]> query = this.entityManager.createQuery("select c.nom, c.prenom, t.localisation, (t.prixParMetreCarre * t.surface) as prix, t.surface as surface from Terrain as t join Client as c on c = t.proprietaire", Object[].class);
		query.setFirstResult(0);
		query.setMaxResults(7);
		return query.getResultList();
	}
}
