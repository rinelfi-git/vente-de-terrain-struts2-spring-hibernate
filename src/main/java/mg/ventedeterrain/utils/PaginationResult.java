package mg.ventedeterrain.utils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PaginationResult<E> implements Serializable {
	private static final long serialVersionUID = 2148313981700689429L;
	private int limit, offset;
	private long total;
	private List<E> elements;
	
	public PaginationResult() {
		this.elements = new ArrayList<>();
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
	
	public long getTotal() {
		return total;
	}
	
	public void setTotal(long total) {
		this.total = total;
	}
	
	public List<E> getElements() {
		return elements;
	}
	
	public void setElements(List<E> elements) {
		this.elements = elements;
	}
}
