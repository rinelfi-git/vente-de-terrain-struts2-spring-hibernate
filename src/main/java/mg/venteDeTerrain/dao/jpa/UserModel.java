package mg.venteDeTerrain.dao.jpa;

import mg.venteDeTerrain.dao.UserDao;
import mg.venteDeTerrain.entites.Utilisateur;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.*;
import java.util.List;

public class UserModel implements UserDao {
	@PersistenceContext
	private EntityManager entityManager;
	
	@Override
	public List<Utilisateur> select() {
		CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Utilisateur> criteriaQuery = criteriaBuilder.createQuery(Utilisateur.class);
		Root<Utilisateur> root = criteriaQuery.from(Utilisateur.class);
		criteriaQuery.select(root);
		return entityManager.createQuery(criteriaQuery).getResultList();
	}
	
	@Override
	public Utilisateur select(String login) {
		TypedQuery<Utilisateur> query = this.entityManager.createQuery("from Utilisateur as u where u.nomUtilisateur = :login or u.email = :login", Utilisateur.class);
		query.setParameter("login", login);
		return query.getSingleResult();
	}
	
	@Override
	public void insert(Utilisateur utilisateur) {
		this.entityManager.persist(utilisateur);
		this.entityManager.flush();
	}
	
	@Override
	public void update(Utilisateur utilisateur) {
		this.entityManager.merge(utilisateur);
		this.entityManager.flush();
	}
	
	@Override
	public void delete(String nomUtilisateur) {
		Utilisateur utilisateur = this.entityManager.find(Utilisateur.class, nomUtilisateur);
		this.entityManager.remove(utilisateur);
		this.entityManager.flush();
	}
	
	@Override
	public String getPasswordOf(String login) {
		TypedQuery<String> query = this.entityManager.createQuery("select u.motDePasse from Utilisateur u where u.nomUtilisateur = :login or u.email = :login", String.class);
		query.setParameter("login", login);
		List<String> resulats = query.getResultList();
		if (resulats.isEmpty()) return null;
		else return resulats.get(0);
	}
	
	@Override
	public boolean utilisateurExiste(String login) {
		TypedQuery<Long> query = this.entityManager.createQuery("select count(u.id) from Utilisateur u where u.nomUtilisateur = :login or u.email = :login", Long.class);
		query.setParameter("login", login);
		/*
		CriteriaBuilder criteria_builder = entityManager.getCriteriaBuilder();
		CriteriaQuery<Long> criteria_query = criteria_builder.createQuery(Long.class);
		Root<Utilisateur> user_root = criteria_query.from(Utilisateur.class);
		
		Predicate username_predicate = criteria_builder.equal(user_root.get("login"), login);
		Predicate email_predicate = criteria_builder.equal(user_root.get("email"), login);
		Predicate login_predicate = criteria_builder.or(username_predicate, email_predicate);
		criteria_builder.count(user_root);
		criteria_query.where(login_predicate);
		 */
		return query.getSingleResult() > 0;
	}
}
