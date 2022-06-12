package mg.ventedeterrain.servletaction.extenddefault;

import com.opensymphony.xwork2.ActionSupport;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.entites.embedded.Adresse;
import mg.ventedeterrain.service.ClientService;
import mg.ventedeterrain.utils.PaginationConstraint;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClientAction extends ActionSupport implements SessionAware {
    
    private Map<String, Object> session;
    private String redirection, keyword, namespace;
    private List<Client> clients;
    private String[] telephones;
    private String cin,
        nom,
        prenom,
        ville,
        lot,
        orderDirection,
        paginationSearchKeyword,
        paginationSearchField,
        paginationFieldOrder,
        base64image;
    private int postal,
        pageCurrent,
        pageElementNumber,
        elementPerPage,
        totalRecords,
        identity;
    private boolean paginationOrdered, paginationSearchActivated;
    private Client select;
    @Autowired
    private ClientService clientService;
    
    @Override
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
        adresse.setCodePostal(postal);
        adresse.setVille(ville);
        client.setCin(cin);
        client.setNom(nom);
        client.setPrenom(prenom);
        client.setPhoto("default.png");
        client.setAdresse(adresse);
        if (this.telephones != null) {
            client.getTelephones().addAll(Arrays.asList(this.telephones));
        }
        this.clientService.insert(client);
        return SUCCESS;
    }
    
    public String update() {
        Client client = this.clientService.select(this.identity);
        Adresse adresse = new Adresse();
        adresse.setLot(lot);
        adresse.setCodePostal(postal);
        adresse.setVille(ville);
        client.setId(this.identity);
        client.setCin(cin);
        client.setNom(nom);
        client.setPrenom(prenom);
        client.setAdresse(adresse);
        client.getTelephones().clear();
        if (this.telephones != null) {
            client.getTelephones().addAll(Arrays.asList(this.telephones));
        }
        this.clientService.update(client);
        return SUCCESS;
    }
    
    public String select() {
        this.select = this.clientService.select(this.identity);
        return SUCCESS;
    }
    
    public String list() {
        clients = clientService.select();
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
        
        this.clients = this.clientService.select(paginationConstraint);
        return SUCCESS;
    }
    
    public String totalRecordPostRequest() {
        PaginationConstraint paginationConstraint = new PaginationConstraint();
        paginationConstraint.setLimit(this.elementPerPage);
        paginationConstraint.setOffset((this.pageCurrent - 1) * this.elementPerPage);
        paginationConstraint.setSearchActive(this.paginationSearchActivated);
        paginationConstraint.setKeywordSearch(this.paginationSearchKeyword);
        paginationConstraint.setSearchField(this.paginationSearchField);
        
        this.totalRecords = (int) this.clientService.countSelection(paginationConstraint);
        return SUCCESS;
    }
    
    public String profile() {
        try {
            long name = System.currentTimeMillis();
            byte[] decoded = Base64.getDecoder().decode(this.base64image);
            ServletContext context = ServletActionContext.getServletContext();
            File destination = new File(context.getRealPath("upload" + File.separator + "images" + File.separator + "client" + File.separator + name + ".png"));
            FileOutputStream fos = new FileOutputStream(destination);
            fos.write(decoded);
            destination.setReadable(true);
            destination.setExecutable(true);
            destination.setWritable(true);
            Client client = this.clientService.select(this.identity);
            client.setPhoto(destination.getName());
            this.clientService.update(client);
            return SUCCESS;
        } catch (IOException ex) {
            Logger.getLogger(ClientAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ERROR;
    }
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
    
    public String purge() {
        this.clientService.delete(this.identity);
        return SUCCESS;
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
    
    public int getPostal() {
        return postal;
    }
    
    public void setPostal(int postal) {
        this.postal = postal;
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
    
    public int getTotalRecords() {
        return totalRecords;
    }
    
    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;
    }
    
    public String getPaginationFieldOrder() {
        return paginationFieldOrder;
    }
    
    public void setPaginationFieldOrder(String paginationFieldOrder) {
        this.paginationFieldOrder = paginationFieldOrder;
    }
    
    public String getBase64image() {
        return base64image;
    }
    
    public void setBase64image(String base64image) {
        this.base64image = base64image;
    }
    
    public int getIdentity() {
        return identity;
    }
    
    public void setIdentity(int identity) {
        this.identity = identity;
    }
    
    public Client getSelect() {
        return select;
    }
    
    public void setSelect(Client select) {
        this.select = select;
    }
    
}
