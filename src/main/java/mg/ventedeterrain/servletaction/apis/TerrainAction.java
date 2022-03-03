package mg.ventedeterrain.servletaction.apis;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Terrain;
import mg.ventedeterrain.service.TerrainService;
import mg.ventedeterrain.utils.PaginationConstraint;
import mg.ventedeterrain.utils.PaginationResult;
import mg.ventedeterrain.utils.VenteConstraint;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class TerrainAction extends ActionSupport {
	@Autowired
	private TerrainService terrainService;
	private List<Terrain> terrains;
	private Terrain terrain;
	private int id;
	private Map<String, Object> json;
	
	// upload de fichier
	private final String UPLOAD_DESTINATION = "C:\\wamp64\\www\\localstorage\\vente-de-terrain\\images\\terrains\\";
	private final String DEFAULT_IMAGE = "default_field.jpg";
	private File uploadFichier;
	private String uploadFichierContentType;
	private String uploadFichierFileName;
	private String fichierTemporaire;
	private String apercues;
	
	private PaginationResult<Terrain> paginationTerrain;
	private PaginationConstraint constraint;
	private VenteConstraint venteConstraint;
	
	public String list_en_vente() {
		this.terrains = this.terrainService.select_en_vente();
		return SUCCESS;
	}
	
	public String list() {
		this.terrains = this.terrainService.select();
		return SUCCESS;
	}
	
	public String list_vente_constraint() {
		this.terrains = this.terrainService.select(this.venteConstraint);
		return SUCCESS;
	}
	
	public String list_pagination() {
		// this.paginationTerrain = this.terrainService.select(this.constraint);
		this.paginationTerrain.setTotal(this.terrainService.countAll());
		return SUCCESS;
	}
	
	public String get() {
		this.terrain = this.terrainService.select(id);
		return SUCCESS;
	}
	
	public String upload() {
		final Calendar calendar = Calendar.getInstance();
		int start = this.uploadFichierFileName.lastIndexOf('.'),
			end = this.uploadFichierFileName.length();
		String fichier_telecharge = String.format("terrain_img%d_%d_%dat%d_%d_%d_%d%s", calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.DATE), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE), calendar.get(Calendar.SECOND), calendar.get(Calendar.MILLISECOND), this.uploadFichierFileName.substring(start, end));
		File destination = new File(this.UPLOAD_DESTINATION + fichier_telecharge);
		this.json = new HashMap<>();
		try {
			Files.move(uploadFichier.toPath(), destination.toPath());
			destination.setReadable(true, false);
			destination.setExecutable(true, false);
			this.json.put("status", true);
			this.json.put("image", fichier_telecharge);
		} catch (IOException e) {
			e.printStackTrace();
			this.json.put("status", false);
		}
		return SUCCESS;
	}
	
	public String dropload() {
		this.json = new HashMap<>();
		try {
			if (!this.fichierTemporaire.equals(this.DEFAULT_IMAGE) && Files.exists(Paths.get(this.UPLOAD_DESTINATION + this.fichierTemporaire)))
				Files.delete(Paths.get(this.UPLOAD_DESTINATION + this.fichierTemporaire));
			this.json.put("status", true);
		} catch (IOException e) {
			e.printStackTrace();
			this.json.put("status", false);
		}
		return SUCCESS;
	}
	
	public String confirmUpload() {
		this.json = new HashMap<>();
		Terrain terrain = this.terrainService.select(id);
		Type stringArrayType = new TypeToken<String[]>(){}.getType();
		String[] apercuArray = new Gson().fromJson(this.apercues, stringArrayType);
		terrain.setApercues(new HashSet<>(Arrays.asList(apercuArray)));
		this.terrainService.update(terrain);
		this.json.put("status", true);
		return SUCCESS;
	}
	
	public String update() {
		HttpServletRequest request = ServletActionContext.getRequest();
		this.json = new HashMap<>();
		try {
			Terrain terrain = new Gson().fromJson(request.getReader(), Terrain.class);
			this.terrainService.update(terrain);
			this.json.put("status", true);
		} catch (IOException e) {
			e.printStackTrace();
			this.json.put("status", false);
		}
		return SUCCESS;
	}
	
	public String insert() {
		HttpServletRequest request = ServletActionContext.getRequest();
		this.json = new HashMap<>();
		try {
			Terrain terrain = new Gson().fromJson(request.getReader(), Terrain.class);
			this.terrainService.insert(terrain);
			this.json.put("status", true);
		} catch (IOException e) {
			e.printStackTrace();
			this.json.put("status", false);
		}
		return SUCCESS;
	}
	
	public String delete() {
		this.json = new HashMap<>();
		this.terrainService.delete(id);
		this.json.put("status", true);
		return SUCCESS;
	}
	
	public TerrainService getTerrainService() {
		return terrainService;
	}
	
	public void setTerrainService(TerrainService terrainService) {
		this.terrainService = terrainService;
	}
	
	public List<Terrain> getTerrains() {
		return terrains;
	}
	
	public void setTerrains(List<Terrain> terrains) {
		this.terrains = terrains;
	}
	
	public Terrain getTerrain() {
		return terrain;
	}
	
	public void setTerrain(Terrain terrain) {
		this.terrain = terrain;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public File getUploadFichier() {
		return uploadFichier;
	}
	
	public void setUploadFichier(File uploadFichier) {
		this.uploadFichier = uploadFichier;
	}
	
	public Map<String, Object> getJson() {
		return json;
	}
	
	public void setJson(Map<String, Object> json) {
		this.json = json;
	}
	
	public String getUploadFichierContentType() {
		return uploadFichierContentType;
	}
	
	public void setUploadFichierContentType(String uploadFichierContentType) {
		this.uploadFichierContentType = uploadFichierContentType;
	}
	
	public String getUploadFichierFileName() {
		return uploadFichierFileName;
	}
	
	public void setUploadFichierFileName(String uploadFichierFileName) {
		this.uploadFichierFileName = uploadFichierFileName;
	}
	
	public void setFichierTemporaire(String fichierTemporaire) {
		this.fichierTemporaire = fichierTemporaire;
	}
	
	public void setApercues(String apercues) {
		this.apercues = apercues;
	}
	
	public PaginationResult<Terrain> getPaginationTerrain() {
		return paginationTerrain;
	}
	
	public PaginationConstraint getConstraint() {
		return constraint;
	}
	
	public void setConstraint(PaginationConstraint constraint) {
		this.constraint = constraint;
	}
	
	public VenteConstraint getVenteConstraint() {
		return venteConstraint;
	}
	
	public void setVenteConstraint(VenteConstraint venteConstraint) {
		this.venteConstraint = venteConstraint;
	}
}
