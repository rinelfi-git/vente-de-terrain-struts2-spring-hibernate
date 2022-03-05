package mg.ventedeterrain.entites;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "vente")
public class Vente implements Serializable {

    @Id
    @GenericGenerator(name = "key_generator", strategy = "increment")
    @GeneratedValue(generator = "key_generator")
    private int id;
    private Date operation;
    @OneToOne
    @JoinColumn(name = "fk_terrain")
    private Terrain terrain;
    @OneToOne
    @JoinColumn(name = "fk_client")
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
