package mg.venteDeTerrain.utils;

public class PaginationConstraint {
	private int limit, offset;
	private boolean ordered, searchActive;
	private String orderDirection, orderField, keywordSearch, searchField;
	
	public PaginationConstraint() {super();}
	
	public PaginationConstraint(int limit, int offset, boolean ordered, boolean searchActive, String orderDirection, String orderField, String keywordSearch, String searchField) {
		super();
		this.limit = limit;
		this.offset = offset;
		this.ordered = ordered;
		this.searchActive = searchActive;
		this.orderDirection = orderDirection;
		this.orderField = orderField;
		this.keywordSearch = keywordSearch;
		this.searchField = searchField;
	}
	
	public int getLimit() {
		return limit;
	}
	
	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	public int getOffset() {
		return offset;
	}
	
	public void setOffset(int offset) {
		this.offset = offset;
	}
	
	public boolean isOrdered() {
		return ordered;
	}
	
	public void setOrdered(boolean ordered) {
		this.ordered = ordered;
	}
	
	public boolean isSearchActive() {
		return searchActive;
	}
	
	public void setSearchActive(boolean searchActive) {
		this.searchActive = searchActive;
	}
	
	public String getOrderDirection() {
		return orderDirection;
	}
	
	public void setOrderDirection(String orderDirection) {
		this.orderDirection = orderDirection;
	}
	
	public String getOrderField() {
		return orderField;
	}
	
	public void setOrderField(String orderField) {
		this.orderField = orderField;
	}
	
	public String getKeywordSearch() {
		return keywordSearch;
	}
	
	public void setKeywordSearch(String keywordSearch) {
		this.keywordSearch = keywordSearch;
	}
	
	public String getSearchField() {
		return searchField;
	}
	
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
}
