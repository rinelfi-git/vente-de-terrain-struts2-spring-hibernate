package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Utilisateur;
import mg.ventedeterrain.service.UserService;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

public class LoginAction extends ActionSupport implements SessionAware {
    @Autowired
    private UserService userService;
    private String username, password, message, redirection;
    private boolean remember, allowed;
    private Map<String, Object> session;
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
    
    public String authentication() {
        this.allowed = false;
        String password = this.userService.getMotDePasseDe(this.password);
        if(this.userService.utilisateurExiste(this.username) && password != null && BCrypt.checkpw(this.password, password)) {
            this.allowed = true;
        }
        return SUCCESS;
    }
    
    public String session() {
        Utilisateur utilisateur = this.userService.select(this.username);
        this.session.put("username", utilisateur.getNomUtilisateur());
        this.session.put("email", utilisateur.getEmail());
        this.session.put("photo", utilisateur.getPhoto());
        this.setRedirection(String.format("%s/terrain.action", ServletActionContext.getRequest().getContextPath()));
        return SUCCESS;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public boolean isRemember() {
        return remember;
    }
    
    public void setRemember(boolean remember) {
        this.remember = remember;
    }
    
    public String getRedirection() {
        return redirection;
    }
    
    public void setRedirection(String redirection) {
        this.redirection = redirection;
    }
    
    public boolean isAllowed() {
        return allowed;
    }
    
    public void setAllowed(boolean allowed) {
        this.allowed = allowed;
    }
}
