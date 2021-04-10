package mg.venteDeTerrain.servletAction;

import java.util.HashMap;
import java.util.Map;

import com.opensymphony.xwork2.ActionSupport;
import mg.venteDeTerrain.service.ClientService;
import mg.venteDeTerrain.service.TerrainService;
import mg.venteDeTerrain.service.VenteService;
import org.springframework.beans.factory.annotation.Autowired;

public class DashboardAction extends ActionSupport {
  private Map<String, Object> json;
  @Autowired
  private TerrainService terrainService;
  @Autowired
  private ClientService clientService;
  @Autowired
  private VenteService venteService;
  
  public String execute() {
    this.json = new HashMap<>();
    this.json.put("totalTerrain", this.terrainService.countAll());
    this.json.put("totalVente", this.venteService.countAll());
    this.json.put("totalClient", this.clientService.countAll());
    this.json.put("dernierClient", this.clientService.derniersClients());
    this.json.put("dernierTerrain", this.terrainService.derniersTerrains());
    return SUCCESS;
  }
  
  public Map<String, Object> getJson() {
    return json;
  }
  
  public void setJson(Map<String, Object> json) {
    this.json = json;
  }
}
