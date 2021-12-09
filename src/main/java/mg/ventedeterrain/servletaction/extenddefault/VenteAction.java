package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.utils.VenteConstraint;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

public class VenteAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private String namespace;
    private VenteConstraint constraint;
    
    public String execute() {
        setNamespace("vente");
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
}
