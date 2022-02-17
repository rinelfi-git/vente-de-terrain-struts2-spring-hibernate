package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Adresse;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.service.ClientService;
import mg.ventedeterrain.utils.PaginationConstraint;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

public class ClientAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private String redirection, profileHost = "http://localhost/vente_de_terrain/client/", keyword, namespace;
    private List<Client> clients;
    private String[] telephones;
    private String cin, nom, prenom, ville, lot, orderDirection, paginationSearchKeyword, paginationSearchField;
    private int codePostal, pageCurrent, pageElementNumber, elementPerPage;
    private boolean paginationOrdered, paginationSearchActivated;
    @Autowired
    private ClientService clientService;
    
    public String execute() {
        setNamespace("client");
        return this.session.containsKey("username") ? SUCCESS : LOGIN;
    }
    
    public String search() {
        return SUCCESS;
    }
    
    public String insert() {
        Client client = new Client();
        Adresse adresse = new Adresse();
        adresse.setLot(lot);
        adresse.setCodePostal(codePostal);
        adresse.setVille(ville);
        client.setCin(cin);
        client.setNom(nom);
        client.setPhoto(prenom);
        client.setAdresse(adresse);
        for (String telephone : telephones) client.getTelephones().add(telephone);
        clientService.insert(client);
        return SUCCESS;
    }
    
    public String list() {
        clients = clientService.select();
        return SUCCESS;
    }
    
    public String paginationList() {
    	PaginationConstraint paginationConstraint = new PaginationConstraint();
    	paginationConstraint.setOrderDirection(this.orderDirection);
    	paginationConstraint.setLimit(this.elementPerPage);
    	paginationConstraint.setOffset((this.pageCurrent - 1) * this.elementPerPage);
    	paginationConstraint.setOrdered(this.paginationOrdered);
    	paginationConstraint.setSearchActive(this.paginationSearchActivated);
    	paginationConstraint.setKeywordSearch(this.paginationSearchKeyword);
    	paginationConstraint.setSearchField(this.paginationSearchField);
    	
    	System.out.println(this.pageCurrent);
    	this.clients = this.clientService.select(paginationConstraint); 
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
    
    public String[] getTelephones() {
        return telephones;
    }
    
    public void setTelephones(String[] telephones) {
        this.telephones = telephones;
    }
    
    public String getCin() {
        return cin;
    }
    
    public void setCin(String cin) {
        this.cin = cin;
    }
    
    public String getNom() {
        return nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public String getPrenom() {
        return prenom;
    }
    
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }
    
    public String getVille() {
        return ville;
    }
    
    public void setVille(String ville) {
        this.ville = ville;
    }
    
    public String getLot() {
        return lot;
    }
    
    public void setLot(String lot) {
        this.lot = lot;
    }
    
    public int getCodePostal() {
        return codePostal;
    }
    
    public void setCodePostal(int codePostal) {
        this.codePostal = codePostal;
    }

	public String getOrderDirection() {
		return orderDirection;
	}

	public void setOrderDirection(String orderDirection) {
		this.orderDirection = orderDirection;
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

	public int getPageCurrent() {
		return pageCurrent;
	}

	public void setPageCurrent(int pageCurrent) {
		this.pageCurrent = pageCurrent;
	}

	public int getPageElementNumber() {
		return pageElementNumber;
	}

	public void setPageElementNumber(int pageElementNumber) {
		this.pageElementNumber = pageElementNumber;
	}

	public int getElementPerPage() {
		return elementPerPage;
	}

	public void setElementPerPage(int elementPerPage) {
		this.elementPerPage = elementPerPage;
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
}
