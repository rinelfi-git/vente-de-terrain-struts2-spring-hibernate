package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.entites.Terrain;
import mg.ventedeterrain.service.ClientService;
import mg.ventedeterrain.service.TerrainService;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

public class TerrainAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private String fileHost = "http://localhost/vente_de_terrain/terrain", defaultThumbnail = "default.jpg", keyword, apercuContentType, apercuFileName, uploadedFilename, identity, namespace;
    private List<Terrain> terrains;
    private List<Client> clientForms;
    private File apercu;
    private String[] saveThumb, excludeThumb;
    private final String uploadDestination = "/var/www/html/vente_de_terrain/terrain/";
    @Autowired
    private TerrainService terrainService;
    @Autowired
    private ClientService clientService;
    
    // link parameters
    private int page, limit;
    
    public String execute() {
        setNamespace("terrain");
        terrains = terrainService.select(page, limit);
        clientForms = clientService.select();
        System.out.println("cleints : " + clientForms.size());
//return this.session.containsKey("username") ? SUCCESS : LOGIN;
        return SUCCESS;
    }
    
    public String uploadThumbnail() throws IOException {
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
    
    public String saveThumbnail() throws IOException {
        System.out.println(Arrays.toString(this.saveThumb));
        for (String image : this.excludeThumb) {
            Path file = Paths.get(uploadDestination + image);
            if (Files.exists(file)) Files.delete(file);
        }
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
    
    public String getIdentity() {
        return identity;
    }
    
    public void setIdentity(String identity) {
        this.identity = identity;
    }
    
    public String[] getSaveThumb() {
        return saveThumb;
    }
    
    public void setSaveThumb(String[] saveThumb) {
        this.saveThumb = saveThumb;
    }
    
    public String[] getExcludeThumb() {
        return excludeThumb;
    }
    
    public void setExcludeThumb(String[] excludeThumb) {
        this.excludeThumb = excludeThumb;
    }
    
    public String getNamespace() {
        return namespace;
    }
    
    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }
    
    public List<Client> getClientForms() {
        return clientForms;
    }
    
    public void setClientForms(List<Client> clientForms) {
        this.clientForms = clientForms;
    }
}
