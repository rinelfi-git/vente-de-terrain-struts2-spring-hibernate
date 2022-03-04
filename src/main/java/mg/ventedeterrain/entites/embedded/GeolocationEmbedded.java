/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.ventedeterrain.entites.embedded;

import java.io.Serializable;
import javax.persistence.Embeddable;

/**
 *
 * @author rinelfi
 */
@Embeddable
public class GeolocationEmbedded implements Serializable {
    private float longitude, latitude;

    public GeolocationEmbedded() {
        this.longitude = 0f;
        this.latitude = 0f;
    }
    
    public float getLongitude() {
        return longitude;
    }
    
    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }
    
}
