package mg.venteDeTerrain.entites;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "terrain")
public class Terrain implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "terrain_id")
	private int id;
	@OneToOne @JoinColumn(name = "terrain_proprietaire")
	private Client proprietaire;
	@Column(name = "terrain_en_vente")
	private boolean enVente;
	@Column(name = "terrain_localisation")
	private String localisation;
	@Column(name = "terrain_surface")
	private float surface;
	@Column(name = "terrain_prix_par_metre_carre")
	private int prixParMetreCarre;
	@Column(name = "terrain_relief")
	private String relief;
	@ElementCollection(fetch = FetchType.EAGER)
	@JoinTable(name = "apercue", joinColumns = @JoinColumn(name = "fk_terrain"))
	@Column(name = "image_url")
	private Set<String> apercues;
	
	@OneToMany(mappedBy = "terrain", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	private Set<Vente> ventes;
	
	public Terrain() {
		super();
		this.apercues = new HashSet<>();
		
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public Client getProprietaire() {
		return proprietaire;
	}
	
	public void setProprietaire(Client proprietaire) {
		this.proprietaire = proprietaire;
	}
	
	public boolean isEnVente() {
		return enVente;
	}
	
	public void setEnVente(boolean enVente) {
		this.enVente = enVente;
	}
	
	public String getLocalisation() {
		return localisation;
	}
	
	public void setLocalisation(String localisation) {
		this.localisation = localisation;
	}
	
	public float getSurface() {
		return surface;
	}
	
	public void setSurface(float surface) {
		this.surface = surface;
	}
	
	public int getPrixParMetreCarre() {
		return prixParMetreCarre;
	}
	
	public void setPrixParMetreCarre(int prixParMetreCarre) {
		this.prixParMetreCarre = prixParMetreCarre;
	}
	
	public String getRelief() {
		return relief;
	}
	
	public void setRelief(String relief) {
		this.relief = relief;
	}
	
	public Set<String> getApercues() {
		return apercues;
	}
	
	public void setApercues(Set<String> apercues) {
		this.apercues = apercues;
	}
}
