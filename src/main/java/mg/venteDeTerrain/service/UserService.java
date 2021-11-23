package mg.venteDeTerrain.service;

import mg.venteDeTerrain.entites.Utilisateur;

import java.util.List;

public interface UserService {
	List<Utilisateur> select();
	
	Utilisateur select(String nomUtilisateur);
	
	void insert(Utilisateur utilisateur);
	
	void update(Utilisateur utilisateur);
	
	void delete(String nomUtilisateur);
	
	String getMotDePasseDe(String login);
	
	boolean utilisateurExiste(String username);
}
