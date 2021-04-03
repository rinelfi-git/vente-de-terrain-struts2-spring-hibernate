package mg.venteDeTerrain.servletAction;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import mg.venteDeTerrain.entites.Terrain;
import mg.venteDeTerrain.entites.Vente;
import mg.venteDeTerrain.service.TerrainService;
import mg.venteDeTerrain.service.VenteService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class VenteAction extends ActionSupport {
	@Autowired
	private VenteService venteService;
	@Autowired
	private TerrainService terrainService;
	private List<Vente> ventes;
	private Vente vente;
	private int id;
	private Map<String, Object> json;
	
	public String list() {
		return SUCCESS;
	}
	
	public String get() {
		return SUCCESS;
	}
	
	public String insert() {
		HttpServletRequest request = ServletActionContext.getRequest();
		this.json = new HashMap<>();
		try {
			Vente vente = new Gson().fromJson(request.getReader(), Vente.class);
			this.venteService.insert(vente);
			Terrain terrain = vente.getTerrain();
			terrain.setProprietaire(vente.getClient());
			this.terrainService.update(terrain);
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
			Vente vente = new Gson().fromJson(request.getReader(), Vente.class);
			this.venteService.update(vente);
			this.json.put("status", true);
		} catch (IOException e) {
			e.printStackTrace();
			this.json.put("status", false);
		}
		return SUCCESS;
	}
	
	public String delete() {
		this.json = new HashMap<>();
		this.venteService.delete(id);
		this.json.put("status", true);
		return SUCCESS;
	}
	
	public VenteService getVenteService() {
		return venteService;
	}
	
	public void setVenteService(VenteService venteService) {
		this.venteService = venteService;
	}
	
	public List<Vente> getVentes() {
		return ventes;
	}
	
	public void setVentes(List<Vente> ventes) {
		this.ventes = ventes;
	}
	
	public Vente getVente() {
		return vente;
	}
	
	public void setVente(Vente vente) {
		this.vente = vente;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public Map<String, Object> getJson() {
		return json;
	}
	
	public void setJson(Map<String, Object> json) {
		this.json = json;
	}
}
