package mg.venteDeTerrain.utils;

import java.io.Serializable;

public class VenteConstraint implements Serializable {
	private String localisation, surfaceConstraint, budgetConstraint, relief;
	private float surface, budget;
	
	public String getLocalisation() {
		return localisation;
	}
	
	public void setLocalisation(String localisation) {
		this.localisation = localisation;
	}
	
	public String getSurfaceConstraint() {
		return surfaceConstraint;
	}
	
	public void setSurfaceConstraint(String surfaceConstraint) {
		this.surfaceConstraint = surfaceConstraint;
	}
	
	public String getBudgetConstraint() {
		return budgetConstraint;
	}
	
	public void setBudgetConstraint(String budgetConstraint) {
		this.budgetConstraint = budgetConstraint;
	}
	
	public String getRelief() {
		return relief;
	}
	
	public void setRelief(String relief) {
		this.relief = relief;
	}
	
	public float getSurface() {
		return surface;
	}
	
	public void setSurface(float surface) {
		this.surface = surface;
	}
	
	public float getBudget() {
		return budget;
	}
	
	public void setBudget(float budget) {
		this.budget = budget;
	}
}
