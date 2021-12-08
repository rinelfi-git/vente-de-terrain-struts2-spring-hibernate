package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.entites.Terrain;
import org.apache.struts2.interceptor.SessionAware;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.*;

public class TerrainAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private String fileHost = "http://localhost/vente_de_terrain/terrain", defaultThumbnail = "default.jpg", keyword, apercuContentType, apercuFileName, uploadedFilename;
    private List<Terrain> terrains;
    private File apercu;
    
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
    
    public String uploadThumbnail() throws IOException {
        String uploadDestination = "/var/www/html/vente_de_terrain/terrain/";
        final Calendar calendar = Calendar.getInstance();
        int start = this.apercuFileName.lastIndexOf('.'),
            end = this.apercuFileName.length();
        String filename = String.format("terrain_img_%d_%d_%dat%d_%d_%d_%d%s", calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.DATE), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE), calendar.get(Calendar.SECOND), calendar.get(Calendar.MILLISECOND), this.apercuFileName.substring(start, end));
        File destination = new File(uploadDestination + filename);
        Files.move(apercu.toPath(), destination.toPath());
        destination.setReadable(true, false);
        destination.setExecutable(true, false);
        this.uploadedFilename = filename;
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
    
    public File getApercu() {
        return apercu;
    }
    
    public void setApercu(File apercu) {
        this.apercu = apercu;
    }
    
    public String getApercuContentType() {
        return apercuContentType;
    }
    
    public void setApercuContentType(String apercuContentType) {
        this.apercuContentType = apercuContentType;
    }
    
    public String getApercuFileName() {
        return apercuFileName;
    }
    
    public void setApercuFileName(String apercuFileName) {
        this.apercuFileName = apercuFileName;
    }
    
    
    public String getUploadedFilename() {
        return uploadedFilename;
    }
    
    public void setUploadedFilename(String uploadedFilename) {
        this.uploadedFilename = uploadedFilename;
    }
}
