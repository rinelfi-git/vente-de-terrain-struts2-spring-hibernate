package mg.venteDeTerrain.entites;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "client")
public class Client implements Serializable {
	@Id
	@Column(name = "client_id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	@Column(name = "client_cin", unique = true)
	private String cin;
	@Column(name = "client_nom")
	private String nom;
	@Column(name = "client_prenom")
	private String prenom;
	@Column(name = "client_photo")
	private String photo;
	@Embedded
	@AttributeOverrides({
		@AttributeOverride(name = "ville", column = @Column(name = "client_ville")),
		@AttributeOverride(name = "lot", column = @Column(name = "client_lot")),
		@AttributeOverride(name = "codePostal", column = @Column(name = "client_code_postal"))
	})
	private Adresse adresse;
	@ElementCollection(fetch = FetchType.EAGER)
	@JoinTable(name = "telephone", joinColumns = @JoinColumn(name = "fk_client"))
	@Column(name = "telephone_numero")
	private Set<String> telephones;
	
	@OneToMany(mappedBy = "proprietaire", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	private Set<Terrain> terrains;
	@OneToMany(mappedBy = "client",fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	private Set<Vente> ventes;
	
	public Client() {
		super();
		this.telephones = new HashSet<>();
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getCin() {
		return cin;
	}
	
	public void setCin(String cin) {
		this.cin = cin;
	}
	
	public String getNom() {
		return nom;
	}
	
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	public String getPrenom() {
		return prenom;
	}
	
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	
	public String getPhoto() {
		return photo;
	}
	
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public Adresse getAdresse() {
		return adresse;
	}
	
	public void setAdresse(Adresse adresse) {
		this.adresse = adresse;
	}
	
	public Set<String> getTelephones() {
		return telephones;
	}
	
	public void setTelephones(Set<String> telephones) {
		this.telephones = telephones;
	}
}
