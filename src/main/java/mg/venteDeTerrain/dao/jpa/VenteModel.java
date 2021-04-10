package mg.venteDeTerrain.dao.jpa;

import mg.venteDeTerrain.dao.VenteDao;
import mg.venteDeTerrain.entites.Vente;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class VenteModel implements VenteDao {
	@PersistenceContext
	private EntityManager entityManager;
	
	@Override
	public List<Vente> select() {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Vente> criteriaQuery = criteriaBuilder.createQuery(Vente.class);
		Root<Vente> root = criteriaQuery.from(Vente.class);
		criteriaQuery.select(root);
		return entityManager.createQuery(criteriaQuery).getResultList();
	}
	
	@Override
	public Vente select(int id) {
		return this.entityManager.find(Vente.class, id);
	}
	
	@Override
	public void insert(Vente vente) {
		this.entityManager.persist(vente);
		this.entityManager.flush();
	}
	
	@Override
	public void update(Vente utilisateur) {
		this.entityManager.merge(utilisateur);
		this.entityManager.flush();
	}
	
	@Override
	public void delete(int id) {
		Vente utilisateur = this.entityManager.find(Vente.class, id);
		this.entityManager.remove(utilisateur);
		this.entityManager.flush();
	}
	
	@Override
	public List<Vente> derniersVentes() {
		TypedQuery<Vente> query = this.entityManager.createQuery("select vente.terrain, vente.client, operation from Vente as vente", Vente.class);
		query.setFirstResult(1);
		query.setMaxResults(10);
		return query.getResultList();
	}
	
	@Override
	public long countAll() {
		TypedQuery<Long> query = this.entityManager.createQuery("select count(id) from Vente", Long.class);
		return query.getSingleResult();
	}
}
