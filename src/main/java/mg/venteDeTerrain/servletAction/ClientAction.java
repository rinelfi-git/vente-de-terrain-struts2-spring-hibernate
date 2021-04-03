package mg.venteDeTerrain.servletAction;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import mg.venteDeTerrain.entites.Client;
import mg.venteDeTerrain.service.ClientService;
import mg.venteDeTerrain.utils.PaginationConstraint;
import mg.venteDeTerrain.utils.PaginationResult;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class ClientAction extends ActionSupport {
	@Autowired
	private ClientService clientService;
	private String content, name, photo, ancienPhoto;
	private int id;
	private List<Client> clients;
	private Client client;
	private Map<String, Object> json;
	
	private final String UPLOAD_DESTINATION = "/var/www/html/gestion-vente-terrain/images/clients/";
	private final String DEFAULT_IMAGE = "profile_par_defaut.png";
	
	private PaginationResult<Client> paginatedClientList;
	private PaginationConstraint constraint;
	
	public ClientAction() {
		super();
	}
	
	public String upload() {
		byte[] byteImage = Base64.getDecoder().decode(this.content);
		this.json = new HashMap<>();
		final Calendar calendar = Calendar.getInstance();
		final String filename = String.format("client_img%d-%d-%dat%d-%d-%d-%d", calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.DATE), calendar.get(Calendar.HOUR), calendar.get(Calendar.MINUTE), calendar.get(Calendar.SECOND), calendar.get(Calendar.MILLISECOND));
		File destinationFile = new File(this.UPLOAD_DESTINATION + filename + ".png");
		try {
			if (this.ancienPhoto != null && !this.ancienPhoto.equals(this.DEFAULT_IMAGE) && Files.exists(Paths.get(this.UPLOAD_DESTINATION + this.ancienPhoto))) Files.delete(Paths.get(this.UPLOAD_DESTINATION + this.ancienPhoto));
			BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(destinationFile));
			bufferedOutputStream.write(byteImage);
			bufferedOutputStream.flush();
			destinationFile.setExecutable(true, false);
			destinationFile.setReadable(true, false);
			Client client = this.clientService.select(id);
			client.setPhoto(filename + ".png");
			this.clientService.update(client);
			this.json.put("status", true);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			this.json.put("status", false);
		} catch (IOException e) {
			e.printStackTrace();
			this.json.put("status", false);
		}
		return SUCCESS;
	}
	
	public String dropload() {
		this.json = new HashMap<>();
		try {
			Files.delete(Paths.get(this.UPLOAD_DESTINATION));
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
			Client client = new Gson().fromJson(request.getReader(), Client.class);
			this.clientService.insert(client);
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
			Client client = new Gson().fromJson(request.getReader(), Client.class);
			this.clientService.update(client);
			this.json.put("status", true);
		} catch (IOException e) {
			e.printStackTrace();
			this.json.put("status", false);
		}
		return SUCCESS;
	}
	
	public String list() {
		this.clients = this.clientService.select();
		return SUCCESS;
	}
	
	public String listPagination() {
		this.paginatedClientList = this.clientService.select(this.constraint);
		if (this.constraint.isSearchActive()) this.paginatedClientList.setTotal(this.clientService.countSelection(this.constraint));
		else this.paginatedClientList.setTotal(this.clientService.countAll());
		return SUCCESS;
	}
	
	public String get() {
		this.client = this.clientService.select(id);
		return SUCCESS;
	}
	
	public String delete() {
		this.json = new HashMap<>();
		this.clientService.delete(id);
		this.json.put("status", true);
		return SUCCESS;
	}
	
	public String dernierClients() {
		this.clients = this.clientService.derniersClients();
		return SUCCESS;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Map<String, Object> getJson() {
		return json;
	}
	
	public void setJson(Map<String, Object> json) {
		this.json = json;
	}
	
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public void setClient(Client client) {
		this.client = client;
	}
	
	public Client getClient() {return this.client;}
	
	public void setClients(List<Client> clients) {
		this.clients = clients;
	}
	
	public List<Client> getClients() {
		return clients;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
	
	public void setAncienPhoto(String ancienPhoto) {
		this.ancienPhoto = ancienPhoto;
	}
	
	// Pagination
	public PaginationResult<Client> getPaginatedClientList() {
		return paginatedClientList;
	}
	
	public void setPaginatedClientList(PaginationResult<Client> paginatedClientList) {
		this.paginatedClientList = paginatedClientList;
	}
	
	public void setConstraint(PaginationConstraint constraint) {
		this.constraint = constraint;
	}
	
	public PaginationConstraint getConstraint() {
		return constraint;
	}
}
