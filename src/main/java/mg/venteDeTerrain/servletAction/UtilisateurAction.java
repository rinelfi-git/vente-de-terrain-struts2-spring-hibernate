package mg.venteDeTerrain.servletAction;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import io.jsonwebtoken.Jwts;
import mg.venteDeTerrain.entites.Utilisateur;
import mg.venteDeTerrain.service.UserService;
import mg.venteDeTerrain.utils.JWTUtil;
import mg.venteDeTerrain.utils.token.Token;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.security.interfaces.RSAPrivateKey;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UtilisateurAction extends ActionSupport {
    @Autowired
    private UserService utilisateurService;
    private List<Utilisateur> utilisateurs;
    private Utilisateur utilisateur;
    private String nomUtilisateur, token, motDePasse;
    private boolean seSouvenirDeMoi;
    private Map<String, Object> json;
    
    public String list() {
        return SUCCESS;
    }
    
    public String get() {
        return SUCCESS;
    }
    
    public String login() {
        String motDePasseUtilisateur = this.utilisateurService.getMotDePasseDe(this.nomUtilisateur);
        String retourDeRequete;
        //  && motDePasseUtilisateur != null && BCrypt.checkpw(this.motDePasse, motDePasseUtilisateur)
        if (this.utilisateurService.utilisateurExiste(this.nomUtilisateur)) {
            Token tokenBuilder = new Token();
            this.utilisateur = this.utilisateurService.select(this.nomUtilisateur);
            JWTUtil.getInstance();
            RSAPrivateKey privateKey = (RSAPrivateKey) JWTUtil.getPrivateKey();
            Map<String, Object> payload = new HashMap<>();
            payload.put("username", this.utilisateur.getNomUtilisateur());
            payload.put("email", this.utilisateur.getEmail());
            payload.put("photo", this.utilisateur.getPhoto());
            String token = Jwts.builder().addClaims(payload).signWith(privateKey).compact();
            int dureeMillisecondes;
            if (isSeSouvenirDeMoi()) dureeMillisecondes = 1000 * 60 * 60 * 24;
            else dureeMillisecondes = 1000 * 60 * 20;
            
            this.token = tokenBuilder.generate();
            this.json = new HashMap<>();
            this.json.put("token", token);
            this.json.put("status", true);
            retourDeRequete = "token";
        } else {
            retourDeRequete = ERROR;
            this.json = new HashMap<>();
            json.put("status", false);
        }
        return retourDeRequete;
    }
    
    public String verifierToken() {
        this.json = new HashMap<>();
        this.json.put("verifier", Token.verifier(this.token));
        Token jsonToken = new Token(this.token);
        jsonToken.getHeader().extendDateExpiration();
        this.json.put("token", jsonToken.generate());
        return SUCCESS;
    }
    
    public String insert() {
        HttpServletRequest request = ServletActionContext.getRequest();
        this.json = new HashMap<>();
        try {
            Utilisateur utilisateur = new Gson().fromJson(request.getReader(), Utilisateur.class);
            this.utilisateurService.insert(utilisateur);
            this.json.put("status", true);
        } catch (IOException e) {
            e.printStackTrace();
            this.json.put("status", false);
        }
        return SUCCESS;
    }
    
    public String update() {
        HttpServletRequest request = ServletActionContext.getRequest();
        this.json = new HashMap<>();
        try {
            Utilisateur utilisateur = new Gson().fromJson(request.getReader(), Utilisateur.class);
            this.utilisateurService.update(utilisateur);
            this.json.put("status", true);
        } catch (IOException e) {
            e.printStackTrace();
            this.json.put("status", false);
        }
        return SUCCESS;
    }
    
    public String delete() {
        this.json = new HashMap<>();
        this.utilisateurService.delete(nomUtilisateur);
        this.json.put("status", true);
        return SUCCESS;
    }
    
    public UserService getUtilisateurService() {
        return utilisateurService;
    }
    
    public void setUtilisateurService(UserService userService) {
        this.utilisateurService = userService;
    }
    
    public List<Utilisateur> getUtilisateurs() {
        return utilisateurs;
    }
    
    public void setUtilisateurs(List<Utilisateur> utilisateurs) {
        this.utilisateurs = utilisateurs;
    }
    
    public Utilisateur getUtilisateur() {
        return utilisateur;
    }
    
    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }
    
    public String getNomUtilisateur() {
        return nomUtilisateur;
    }
    
    public void setNomUtilisateur(String nomUtilisateur) {
        this.nomUtilisateur = nomUtilisateur;
    }
    
    public Map<String, Object> getJson() {
        return json;
    }
    
    public void setJson(Map<String, Object> json) {
        this.json = json;
    }
    
    public String getToken() {
        return token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
    
    public boolean isSeSouvenirDeMoi() {
        return seSouvenirDeMoi;
    }
    
    public void setSeSouvenirDeMoi(boolean seSouvenirDeMoi) {
        this.seSouvenirDeMoi = seSouvenirDeMoi;
    }
    
    public String getMotDePasse() {
        return motDePasse;
    }
    
    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }
}
