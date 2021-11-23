package mg.ventedeterrain.utils.token;

import java.io.Serializable;
import java.util.Calendar;

public class TokenHeader implements Serializable {
	private long dateExpiration, dureeSession;
	
	public long getDateExpiration() {
		return dateExpiration;
	}
	
	public void setDateExpiration(long dateExpiration) {
		this.dateExpiration = dateExpiration;
	}
	
	public long getDureeSession() {
		return dureeSession;
	}
	
	public void setDureeSession(long dureeSession) {
		this.dureeSession = dureeSession;
	}
	
	public void extendDateExpiration() {
		this.dateExpiration = Calendar.getInstance().getTimeInMillis() + this.dureeSession;
	}
}
