package mg.venteDeTerrain.entites;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "utilisateur")
public class Utilisateur implements Serializable {
	@Id
	@Column(name = "user_name")
	private String nomUtilisateur;
	@Column(name = "user_email")
	private String email;
	@Column(name = "user_password")
	private String motDePasse;
	@Column(name = "user_photo")
	private String photo;
	
	public String getNomUtilisateur() {
		return nomUtilisateur;
	}
	
	public void setNomUtilisateur(String nomUtilisateur) {
		this.nomUtilisateur = nomUtilisateur;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getMotDePasse() {
		return motDePasse;
	}
	
	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}
	
	public String getPhoto() {
		return photo;
	}
	
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	/*
	default amin user
	insert into utilisateur(user_name, user_email, user_password, user_photo) values
	('Rinelfi',
		'elierijaniaina@gmail.com',
		'$2a$10$g40yPZYlu17cqCJOMxj5.OjlBms8iMzHWPNlXQrJMKtWr.Dq1v1q6',
		'rinelfi.jpg')
	 */
}
