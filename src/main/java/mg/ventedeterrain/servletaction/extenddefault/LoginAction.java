package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Utilisateur;
import mg.ventedeterrain.service.UserService;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

public class LoginAction extends ActionSupport implements SessionAware {
    @Autowired
    private UserService userService;
    private String username, password, message, redirection;
    private boolean remember;
    private Map<String, Object> session;
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
    
    public String execute() {
        String url = ServletActionContext.getRequest().getContextPath();
        if (url != null && url.charAt(url.length() - 1) == '/') url = url.substring(0, url.length() - 1);
        this.redirection = String.format("%s/dashboard.action", url);
        return this.session.containsKey("username") ? "redirect" : SUCCESS;
    }
    
    public String authentication() {
        String output;
        this.setMessage("");
        String password = this.userService.getMotDePasseDe(this.username);
        boolean userExists = this.userService.utilisateurExiste(this.username);
        if (userExists && password != null && BCrypt.checkpw(this.password, password)) {
            output = SUCCESS;
            String url = ServletActionContext.getRequest().getContextPath();
            if (url != null && url.charAt(url.length() - 1) == '/') url = url.substring(0, url.length() - 1);
            this.redirection = String.format("%s/login/session.action?username=%s", url, this.username);
            System.out.println("url : " + url);
        } else {
            this.setMessage("Le nom d'utilisateur ou le mot de passe est incorrect");
            output = ERROR;
        }
        return output;
    }
    
    public String session() {
        Utilisateur utilisateur = this.userService.select(this.username);
        this.session.put("username", utilisateur.getNomUtilisateur());
        this.session.put("email", utilisateur.getEmail());
        this.session.put("photo", utilisateur.getPhoto());
        return SUCCESS;
    }
    
    public String logout() {
        ((SessionMap) ActionContext.getContext().getSession()).invalidate();
        this.session.clear();
        return LOGIN;
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
}
