package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Terrain;
import mg.ventedeterrain.service.VenteService;
import mg.ventedeterrain.utils.VenteConstraint;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

public class VenteAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private List<Terrain> terrains;
    private String namespace;
    private VenteConstraint constraint;
    @Autowired
    private VenteService service;
    
    public String execute() {
        setNamespace("vente");
        return SUCCESS;
    }
    
    public String search() {
        
        return SUCCESS;
    }
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
    
    public Map<String, Object> getSession() {
        return session;
    }
    
    public String getNamespace() {
        return namespace;
    }
    
    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }
    
    public VenteConstraint getConstraint() {
        return constraint;
    }
    
    public void setConstraint(VenteConstraint constraint) {
        this.constraint = constraint;
    }
    
    public List<Terrain> getTerrains() {
        return terrains;
    }
    
    public void setTerrains(List<Terrain> terrains) {
        this.terrains = terrains;
    }
}
