package mg.ventedeterrain.entites;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import mg.ventedeterrain.entites.embedded.GeolocationEmbedded;

@Entity
@Table(name = "terrain")
public class Terrain implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    @JoinColumn(name = "client_id", nullable = false)
    private Client proprietaire;
    @Column(name = "en_vente")
    private boolean enVente;
    @Column(length = 255)
    private String adresse;
    private float surface;
    private int prix;
    private String relief;
    @ElementCollection(fetch = FetchType.EAGER)
    private Set<String> apercues;
    @Embedded
    private final GeolocationEmbedded coordinates;
    private boolean geolocated;
    @OneToMany(mappedBy = "terrain", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
    private Set<Vente> ventes;

    public Terrain() {
        super();
        this.apercues = new HashSet<>();
        this.coordinates = new GeolocationEmbedded();
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

    public String getAdresse() {
        return this.adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public float getSurface() {
        return surface;
    }

    public void setSurface(float surface) {
        this.surface = surface;
    }

    public int getPrix() {
        return prix;
    }

    public void setPrix(int prix) {
        this.prix = prix;
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

    public GeolocationEmbedded getCoordinates() {
        return coordinates;
    }

    public Set<Vente> getVentes() {
        return ventes;
    }

    public boolean isGeolocated() {
        return geolocated;
    }

    public void setGeolocated(boolean geolocated) {
        this.geolocated = geolocated;
    }

}
