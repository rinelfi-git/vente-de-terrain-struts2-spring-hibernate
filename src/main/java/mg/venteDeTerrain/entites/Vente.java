package mg.venteDeTerrain.entites;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

@Entity @Table(name = "vente")
public class Vente implements Serializable {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY) @Column(name = "vente_id")
	private int id;
	@Column(name = "vente_operation")
	private Date operation;
	@OneToOne @JoinColumn(name = "fk_terrain")
	private Terrain terrain;
	@OneToOne @JoinColumn(name = "fk_client")
	private Client client;
	
	public Vente() {
		this.operation = Calendar.getInstance().getTime();
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public Date getOperation() {
		return operation;
	}
	
	public void setOperation(Date operation) {
		this.operation = operation;
	}
	
	public Terrain getTerrain() {
		return terrain;
	}
	
	public void setTerrain(Terrain terrain) {
		this.terrain = terrain;
	}
	
	public Client getClient() {
		return client;
	}
	
	public void setClient(Client client) {
		this.client = client;
	}
}
