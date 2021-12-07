package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Adresse;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.entites.Terrain;
import org.apache.struts2.interceptor.SessionAware;

import java.util.*;

public class TerrainAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private String fileHost = "http://localhost/vente_de_terrain/terrain", defaultThumbnail="default.jpg", keyword;
    private List<Terrain> terrains;
    
    public String execute() {
        terrains = new ArrayList<>();
        Terrain terrain = new Terrain();
        Set<String> apercues = new HashSet<>();
        Client client = new Client();
        client.setNom("Rijaniaina");
        client.setPrenom("Elie Fidèle");
        terrain.setProprietaire(client);
        terrain.setEnVente(false);
        terrain.setLocalisation("localisation");
        terrain.setRelief("montagne");
        terrain.setEnVente(false);
        terrain.setApercues(apercues);
        terrains.add(terrain);
        terrains.add(terrain);
        terrains.add(terrain);
        terrains.add(terrain);
//return this.session.containsKey("username") ? SUCCESS : LOGIN;
        return SUCCESS;
    }
    
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
    
    public Map<String, Object> getSession() {
        return session;
    }
    
    public String getFileHost() {
        return fileHost;
    }
    
    public void setFileHost(String fileHost) {
        this.fileHost = fileHost;
    }
    
    public String getKeyword() {
        return keyword;
    }
    
    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
    
    public List<Terrain> getTerrains() {
        return terrains;
    }
    
    public void setTerrains(List<Terrain> terrains) {
        this.terrains = terrains;
    }
    
    public String getDefaultThumbnail() {
        return defaultThumbnail;
    }
    
    public void setDefaultThumbnail(String defaultThumbnail) {
        this.defaultThumbnail = defaultThumbnail;
    }
}
