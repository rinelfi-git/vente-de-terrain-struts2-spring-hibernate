package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Adresse;
import mg.ventedeterrain.entites.Client;
import org.apache.struts2.interceptor.SessionAware;

import java.util.*;

public class ClientAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private String redirection, profileHost = "http://localhost/vente_de_terrain/client/", keyword, namespace;
    private List<Client> clients;
    
    public String execute() {
        setNamespace("client");
        clients = new ArrayList<>();
        Adresse adresse = new Adresse();
        Set<String> telephones = new HashSet<>();
        Client client = new Client();
        client.setNom("Rijaniaina");
        client.setPrenom("Elie");
        client.setAdresse(adresse);
        client.setTelephones(telephones);
        client.setPhoto("default.png");
        telephones.add("0343912565");
        telephones.add("0343912566");
        adresse.setVille("Fianarantsoa");
        adresse.setCodePostal(301);
        adresse.setLot("Mitsinjosoa");
        clients.add(client);
        clients.add(client);
        clients.add(client);
        return this.session.containsKey("username") ? SUCCESS : LOGIN;
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
    
    public String getRedirection() {
        return redirection;
    }
    
    public void setRedirection(String redirection) {
        this.redirection = redirection;
    }
    
    public List<Client> getClients() {
        return clients;
    }
    
    public void setClients(List<Client> clients) {
        this.clients = clients;
    }
    
    public String getProfileHost() {
        return profileHost;
    }
    
    public void setProfileHost(String profileHost) {
        this.profileHost = profileHost;
    }
    
    public String getKeyword() {
        return keyword;
    }
    
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    
    public String getNamespace() {
        return namespace;
    }
    
    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }
}
