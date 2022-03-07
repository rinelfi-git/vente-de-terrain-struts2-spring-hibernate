package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.entites.Terrain;
import mg.ventedeterrain.service.ClientService;
import mg.ventedeterrain.service.TerrainService;
import mg.ventedeterrain.utils.PaginationConstraint;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

public class TerrainAction extends ActionSupport implements SessionAware {

    private Map<String, Object> session;
    private final String uploadDestination = "/var/www/html/vente_de_terrain/terrain/";
    private String defaultThumbnail = "default.jpg",
        keyword,
        apercuContentType,
        apercuFileName,
        uploadedFilename,
        namespace,
        adresse,
        relief,
        orderDirection,
        paginationFieldOrder,
        paginationSearchKeyword,
        paginationSearchField;
    private List<Terrain> terrains;
    private List<Client> clientForms;
    private File apercu;
    private String[] saveThumb,
        excludeThumb;
    private int proprietaire,
        prix,
        elementPerPage,
        pageCurrent,
        totalRecords,
        identity;
    private float surface,
        longitude,
        latitude;
    private boolean enVente,
        paginationOrdered,
        paginationSearchActivated,
        geolocated;

    @Autowired
    private TerrainService terrainService;
    @Autowired
    private ClientService clientService;

    @Override
    public String execute() {
        clientForms = clientService.select();
        return this.session.containsKey("username") ? SUCCESS : LOGIN;
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
        if (this.saveThumb != null) {
            Terrain terrain = this.terrainService.select(this.identity);
            terrain.setApercues(new HashSet<>());
            terrain.getApercues().addAll(Arrays.asList(this.saveThumb));
            terrainService.update(terrain);
        }
        if (this.excludeThumb != null) {
            for (String image : this.excludeThumb) {
                Path file = Paths.get(uploadDestination + image);
                if (Files.exists(file)) {
                    Files.delete(file);
                }
            }
        }
        return SUCCESS;
    }

    public String insert() {
        Terrain terrain = new Terrain();
        terrain.setAdresse(this.adresse);
        terrain.setGeolocated(this.geolocated);
        terrain.getCoordinates().setLongitude(this.longitude);
        terrain.getCoordinates().setLatitude(this.latitude);
        terrain.setProprietaire(this.clientService.select(this.proprietaire));
        terrain.setSurface(this.surface);
        terrain.setPrix(this.prix);
        terrain.setRelief(this.relief);
        terrain.setEnVente(this.enVente);
        this.terrainService.insert(terrain);
        return SUCCESS;
    }

    public String purge() {
        this.terrainService.delete(this.identity);
        return SUCCESS;
    }

    public String paginationList() {
        PaginationConstraint paginationConstraint = new PaginationConstraint();
        paginationConstraint.setOrdered(this.paginationOrdered);
        paginationConstraint.setOrderDirection(this.orderDirection);
        paginationConstraint.setOrderField(this.paginationFieldOrder);
        paginationConstraint.setLimit(this.elementPerPage);
        paginationConstraint.setOffset((this.pageCurrent - 1) * this.elementPerPage);
        paginationConstraint.setSearchActive(this.paginationSearchActivated);
        paginationConstraint.setKeywordSearch(this.paginationSearchKeyword);
        paginationConstraint.setSearchField(this.paginationSearchField);
        System.out.println("pagination");
        this.terrains = this.terrainService.select(paginationConstraint);
        return SUCCESS;
    }

    public String totalRecordPostRequest() {
        PaginationConstraint paginationConstraint = new PaginationConstraint();
        paginationConstraint.setLimit(this.elementPerPage);
        paginationConstraint.setOffset((this.pageCurrent - 1) * this.elementPerPage);
        paginationConstraint.setSearchActive(this.paginationSearchActivated);
        paginationConstraint.setKeywordSearch(this.paginationSearchKeyword);
        paginationConstraint.setSearchField(this.paginationSearchField);

        this.totalRecords = (int) this.terrainService.countSelection(paginationConstraint);
        return SUCCESS;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public Map<String, Object> getSession() {
        return session;
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

    public int getIdentity() {
        return identity;
    }

    public void setIdentity(int identity) {
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

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public int getProprietaire() {
        return proprietaire;
    }

    public void setProprietaire(int proprietaire) {
        this.proprietaire = proprietaire;
    }

    public float getSurface() {
        return surface;
    }

    public void setSurface(float surface) {
        this.surface = surface;
    }

    public int getPrix() {
        return prix;
    }

    public void setPrix(int prix) {
        this.prix = prix;
    }

    public boolean isEnVente() {
        return enVente;
    }

    public void setEnVente(boolean enVente) {
        this.enVente = enVente;
    }

    public String getRelief() {
        return relief;
    }

    public void setRelief(String relief) {
        this.relief = relief;
    }

    public String getOrderDirection() {
        return orderDirection;
    }

    public void setOrderDirection(String orderDirection) {
        this.orderDirection = orderDirection;
    }

    public String getPaginationFieldOrder() {
        return paginationFieldOrder;
    }

    public void setPaginationFieldOrder(String paginationFieldOrder) {
        this.paginationFieldOrder = paginationFieldOrder;
    }

    public String getPaginationSearchKeyword() {
        return paginationSearchKeyword;
    }

    public void setPaginationSearchKeyword(String paginationSearchKeyword) {
        this.paginationSearchKeyword = paginationSearchKeyword;
    }

    public String getPaginationSearchField() {
        return paginationSearchField;
    }

    public void setPaginationSearchField(String paginationSearchField) {
        this.paginationSearchField = paginationSearchField;
    }

    public int getElementPerPage() {
        return elementPerPage;
    }

    public void setElementPerPage(int elementPerPage) {
        this.elementPerPage = elementPerPage;
    }

    public int getPageCurrent() {
        return pageCurrent;
    }

    public void setPageCurrent(int pageCurrent) {
        this.pageCurrent = pageCurrent;
    }

    public int getTotalRecords() {
        return totalRecords;
    }

    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;
    }

    public boolean isPaginationOrdered() {
        return paginationOrdered;
    }

    public void setPaginationOrdered(boolean paginationOrdered) {
        this.paginationOrdered = paginationOrdered;
    }

    public boolean isPaginationSearchActivated() {
        return paginationSearchActivated;
    }

    public void setPaginationSearchActivated(boolean paginationSearchActivated) {
        this.paginationSearchActivated = paginationSearchActivated;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public boolean isGeolocated() {
        return geolocated;
    }

    public void setGeolocated(boolean geolocated) {
        this.geolocated = geolocated;
    }

}
