package mg.ventedeterrain.dao.jpa;

import mg.ventedeterrain.dao.ClientDao;
import mg.ventedeterrain.entites.embedded.Adresse;
import mg.ventedeterrain.entites.Client;
import mg.ventedeterrain.utils.PaginationConstraint;
import mg.ventedeterrain.utils.PaginationResult;

import javax.persistence.*;
import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;
import mg.ventedeterrain.entites.Terrain;

public class ClientModel implements ClientDao {

    @PersistenceContext
    private EntityManager entityManager;

    public ClientModel() {
    }

    @Override
    public List<Client> select() {
        TypedQuery<Client> query = entityManager.createQuery("from Client c order by c.nom asc, c.prenom asc, c.cin asc", Client.class);
        List<Client> output = query.getResultList();
        System.out.println("selection : " + output.size());
        return output;
    }

    @Override
    public Client select(int id) {
        return this.entityManager.find(Client.class, id);
    }

    @Override
    public void insert(Client client) {
        this.entityManager.persist(client);
        this.entityManager.flush();
    }

    @Override
    public void update(Client client) {
        this.entityManager.merge(client);
        this.entityManager.flush();
    }

    @Override
    public void delete(int id) {
        Client client = this.entityManager.find(Client.class, id);
        this.entityManager.remove(client);
        this.entityManager.flush();
    }

    @Override
    public List<Client> select(PaginationConstraint constraint) {
        CriteriaBuilder criteria_builder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Client> criteria_query = criteria_builder.createQuery(Client.class);
        Root<Client> client_root = criteria_query.from(Client.class);

        if (constraint.isOrdered()) {
            List<Order> orders = new ArrayList<>();
            switch (constraint.getOrderField()) {
                case "nom":
                    if (constraint.getOrderDirection().equalsIgnoreCase("asc")) {
                        orders.add(criteria_builder.asc(client_root.get("nom")));
                        orders.add(criteria_builder.asc(client_root.get("prenom")));
                    } else {
                        orders.add(criteria_builder.desc(client_root.get("nom")));
                        orders.add(criteria_builder.desc(client_root.get("prenom")));
                    }
                    break;
                case "adresse":
                    if (constraint.getOrderDirection().equalsIgnoreCase("asc")) {
                        orders.add(criteria_builder.asc(client_root.get("adresse").get("codePostal")));
                        orders.add(criteria_builder.asc(client_root.get("adresse").get("ville")));
                        orders.add(criteria_builder.asc(client_root.get("adresse").get("lot")));
                    } else {
                        orders.add(criteria_builder.desc(client_root.get("adresse").get("codePostal")));
                        orders.add(criteria_builder.desc(client_root.get("adresse").get("ville")));
                        orders.add(criteria_builder.desc(client_root.get("adresse").get("lot")));
                    }
                default:
                    if (constraint.getOrderDirection().equalsIgnoreCase("asc")) {
                        orders.add(criteria_builder.asc(client_root.get(constraint.getOrderField())));
                    } else {
                        orders.add(criteria_builder.desc(client_root.get(constraint.getOrderField())));
                    }
                    break;
            }
            criteria_query.orderBy(orders);
        } else {
            List<Order> order_by_list = new ArrayList<>();
            order_by_list.add(criteria_builder.asc(client_root.get("cin")));
            order_by_list.add(criteria_builder.asc(client_root.get("nom")));
            order_by_list.add(criteria_builder.asc(client_root.get("prenom")));
            criteria_query.orderBy(order_by_list);
        }

        if (constraint.isSearchActive()) {
            switch (constraint.getSearchField()) {
                case "cin":
                    criteria_query.where(criteria_builder.like(criteria_builder.upper(client_root.get("cin")), "%" + constraint.getKeywordSearch() + "%"));
                    break;
                case "nom":
                    String[] splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
                    Predicate[] predicates = new Predicate[splits.length * 2];
                    int index = 0;
                    for (String split : splits) {
                        predicates[index++] = criteria_builder.like(criteria_builder.upper(client_root.get("nom")), "%" + split + "%");
                        predicates[index++] = criteria_builder.like(criteria_builder.upper(client_root.get("prenom")), "%" + split + "%");
                    }
                    criteria_query.where(criteria_builder.or(predicates));
                    break;
                case "telephone":
                    criteria_query.where(criteria_builder.isMember(constraint.getKeywordSearch(), client_root.get("telephones")));
                    break;
                case "adresse":
                    String[] adresse_splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
                    Predicate[] adresse_predicates = new Predicate[adresse_splits.length * 3];
                    int adresse_index = 0;
                    for (String adresse_split : adresse_splits) {
                        adresse_predicates[adresse_index++] = criteria_builder.like(client_root.get("adresse").get("codePostal").as(String.class), "%" + adresse_split + "%");
                        adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("ville")), "%" + adresse_split + "%");
                        adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("lot")), "%" + adresse_split + "%");
                    }
                    criteria_query.where(criteria_builder.or(adresse_predicates));
                    break;
                default:
                    Predicate where_predicate = criteria_builder.like(criteria_builder.upper(client_root.get(constraint.getSearchField())), "%" + constraint.getKeywordSearch().toUpperCase() + "%");
                    criteria_query.where(where_predicate);
                    break;
            }
        }

        TypedQuery<Client> query = entityManager.createQuery(criteria_query);
        query.setFirstResult(constraint.getOffset());
        query.setMaxResults(constraint.getLimit());
        List<Client> select = query.getResultList();
        return select;
    }

    @Override
    public long countAll() {
        TypedQuery<Long> query = this.entityManager.createQuery("select count(id) from Client", Long.class);
        return query.getSingleResult();
    }

    @Override
    public long countAll(PaginationConstraint paginationConstraint) {
        TypedQuery<Long> query = this.entityManager.createQuery("select count(id) from Client", Long.class);
        return query.getSingleResult();
    }

    @Override
    public long countSelection(PaginationConstraint constraint) {
        CriteriaBuilder criteria_builder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Long> criteria_query = criteria_builder.createQuery(Long.class);
        Root<Client> client_root = criteria_query.from(Client.class);
        if (constraint.isSearchActive()) {
            switch (constraint.getSearchField()) {
                case "nom":
                    String[] nom_splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
                    Predicate[] nom_predicates = new Predicate[nom_splits.length * 2];
                    int nom_index = 0;
                    for (String split : nom_splits) {
                        nom_predicates[nom_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("nom")), "%" + split + "%");
                        nom_predicates[nom_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("prenom")), "%" + split + "%");
                    }
                    criteria_query.where(criteria_builder.or(nom_predicates));
                    break;
                case "adresse":
                    String[] adresse_splits = constraint.getKeywordSearch().toUpperCase().trim().split(" ");
                    Predicate[] adresse_predicates = new Predicate[adresse_splits.length * 3];
                    int adresse_index = 0;
                    for (String adresse_split : adresse_splits) {
                        adresse_predicates[adresse_index++] = criteria_builder.like(client_root.get("adresse").get("codePostal").as(String.class), "%" + adresse_split + "%");
                        adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("ville")), "%" + adresse_split + "%");
                        adresse_predicates[adresse_index++] = criteria_builder.like(criteria_builder.upper(client_root.get("adresse").get("lot")), "%" + adresse_split + "%");
                    }
                    criteria_query.where(criteria_builder.or(adresse_predicates));
                    break;
                default:
                    Predicate where_predicate = criteria_builder.like(criteria_builder.upper(client_root.get(constraint.getSearchField())), "%" + constraint.getKeywordSearch().toUpperCase() + "%");
                    criteria_query.where(where_predicate);
                    break;
            }
        }
        criteria_query.select(criteria_builder.count(client_root.get("cin")));
        long countSelection = entityManager.createQuery(criteria_query).getSingleResult();
        return countSelection;
    }

    @Override
    public List<Object[]> derniersClients() {
        TypedQuery<Object[]> query = this.entityManager.createQuery("select nom, prenom, photo from Client as c order by id desc", Object[].class);
        query.setFirstResult(0);
        query.setMaxResults(7);
        return query.getResultList();
    }
}
