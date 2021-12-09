package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

public class DashboardAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private String redirection, namespace;
    
    public String execute() {
        setNamespace("dashboard");
        return this.session.containsKey("username") ? SUCCESS : LOGIN;
    }
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
    
    public Map<String, Object> getSession() {
        return session;
    }
    
    public String getRedirection() {
        return redirection;
    }
    
    public void setRedirection(String redirection) {
        this.redirection = redirection;
    }
    
    public String getNamespace() {
        return namespace;
    }
    
    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }
}
