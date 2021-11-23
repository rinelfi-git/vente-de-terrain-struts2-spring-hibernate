package mg.ventedeterrain.service;

import mg.ventedeterrain.dao.UserDao;
import mg.ventedeterrain.entites.Utilisateur;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public class UserServiceModel implements UserService {
	private UserDao dao;
	
	@Override
	public void insert(Utilisateur utilisateur) {
		this.dao.insert(utilisateur);
	}
	
	@Override
	public void update(Utilisateur utilisateur) {
		this.dao.update(utilisateur);
	}
	
	@Override
	public void delete(String username) {
		this.dao.delete(username);
	}
	
	@Override
	public String getMotDePasseDe(String login) {
		return this.dao.getPasswordOf(login);
	}
	
	@Override
	public boolean utilisateurExiste(String username) {
		return this.dao.utilisateurExiste(username);
	}
	
	@Override
	public List<Utilisateur> select() {
		return this.dao.select();
	}
	
	@Override
	public Utilisateur select(String username) {
		return this.dao.select(username);
	}
	
	public void setDao(UserDao dao) {
		this.dao = dao;
	}
}
