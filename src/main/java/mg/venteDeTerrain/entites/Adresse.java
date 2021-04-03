package mg.venteDeTerrain.entites;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
public class Adresse implements Serializable {
	@Column(name = "adresse_ville")
	private String ville;
	@Column(name = "adresse_lot")
	private String lot;
	@Column(name = "adresse_code_postal")
	private int codePostal;
	
	public String getVille() {
		return ville;
	}
	
	public void setVille(String ville) {
		this.ville = ville;
	}
	
	public String getLot() {
		return lot;
	}
	
	public void setLot(String lot) {
		this.lot = lot;
	}
	
	public int getCodePostal() {
		return codePostal;
	}
	
	public void setCodePostal(int codePostal) {
		this.codePostal = codePostal;
	}
	
	@Override
	public String toString() {
		return "Adresse{" +
			       "ville='" + ville + '\'' +
			       ", lot='" + lot + '\'' +
			       ", codePostal=" + codePostal +
			       '}';
	}
}
