package mg.ventedeterrain.utils;

import java.io.Serializable;

public class VenteConstraint implements Serializable {
	private String adresse, surfaceConstraint, budgetConstraint, relief;
	private float surface, budget;
	
	public String getAdresse() {
		return adresse;
	}
	
	public void setAdresse(String adresse) {
		this.adresse = adresse;
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
