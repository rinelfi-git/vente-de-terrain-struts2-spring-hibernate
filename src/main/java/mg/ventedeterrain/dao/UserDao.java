package mg.ventedeterrain.dao;

import mg.ventedeterrain.entites.Utilisateur;

import java.util.List;

public interface UserDao {
	List<Utilisateur> select();
	
	Utilisateur select(String nomUtilisateur);
	
	void insert(Utilisateur utilisateur);
	
	void update(Utilisateur utilisateur);
	
	void delete(String nomUtilisateur);
	
	String getPasswordOf(String login);
	
	boolean utilisateurExiste(String username);
}
