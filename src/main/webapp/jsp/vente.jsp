<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Vente</title>
    <s:include value="fragments/links.jsp"/>
    <s:include value="fragments/scripts.jsp"/>
</head>
<body class="layout-top-nav">
<div class="wrapper">
    <%--    top nav--%>
    <s:include value="fragments/navs.jsp"/>
    <div class="content-wrapper">
        <div class="content-header">
            <div class="container">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark"><b><small>Vente</small></b></h1>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        
        <div class="content">
            <div class="row">
                <div class="col-md-4 col-sm-12 col-lg-3">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Critère</h3>
                            
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <form onsubmit="" autocomplete="off">
                                <input type="submit" hidden="hidden">
                                <div class="form-group">
                                    <label for="localisation">localisation:</label>
                                    <input type="text" class="form-control" id="localisation" name="localisation">
                                </div>
                                <div class="form-group">
                                    <label for="surface">surface (m²):</label>
                                    <input type="number" class="form-control" id="surface" name="surface" readonly>
                                </div>
                                <div class="form-group">
                                    <div class="form-check">
                                        <input class="form-check-input" id="surface-egale" type="radio" value="eq" name="contrainteSurface" onchange="handleChangeSurfaceConstraint(this)">
                                        <label class="form-check-label" for="surface-egale">égale</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="surface-superieur" type="radio" value="gt" name="contrainteSurface" onchange="handleChangeSurfaceConstraint(this)">
                                        <label class="form-check-label" for="surface-superieur">supérieur</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="surface-inferieur" type="radio" value=lt name="contrainteSurface" onchange="handleChangeSurfaceConstraint(this)">
                                        <label class="form-check-label" for="surface-inferieur">inférieur</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="surface-disabled" type="radio" value="not" name="contrainteSurface" checked="checked" onchange="handleChangeSurfaceConstraint(this)">
                                        <label class="form-check-label" for="surface-disabled">ne pas séléctionner</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="budget">budget (Ar):</label>
                                    <input type="number" class="form-control" id="budget" name="budget" readonly="readonly">
                                </div>
                                <div class="form-group">
                                    <div class="form-check">
                                        <input class="form-check-input" id="budget-egale" type="radio" value="eq" name="contrainteBudget" onchange="handleChangeBudgetConstraint(this)">
                                        <label class="form-check-label" for="budget-egale">égale</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="budget-superieur" type="radio" value="gt" name="contrainteBudget" onchange="handleChangeBudgetConstraint(this)">
                                        <label class="form-check-label" for="budget-superieur">supérieur</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="budget-inferieur" type="radio" value="lt" name="contrainteBudget" onchange="handleChangeBudgetConstraint(this)">
                                        <label class="form-check-label" for="budget-inferieur">inférieur</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" id="budget-disabled" type="radio" value="not" name="contrainteBudget" checked="checked" onchange="handleChangeBudgetConstraint(this)">
                                        <label class="form-check-label" for="budget-disabled">ne pas séléctionner</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="relief">relief:</label>
                                    <select id="relief" class="custom-select" name="relief">
                                        <option value="*">Tout</option>
                                        <option value="coline">Coline</option>
                                        <option value="montagne">Montagne</option>
                                        <option value="plateau">Plateau</option>
                                        <option value="plaine">Plaine</option>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <!-- /.card-body -->
                        <div class="card-footer">
                            <button class="btn btn-primary" type="button" onclick="">Appliquer</button>
                        </div>
                        <!-- /.card-footer-->
                    </div>
                </div>
                <div class="col-md-8 col-sm-12 col-lg-9">
                    <div class="row">
                        <div class="col-sm-12 col-md-6 col-lg-4 d-flex align-items-stretch"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
	const modality = {
		equal: 'eq',
		greater: 'gt',
		lower: 'lt',
		not: 'not',
	}
	
	function activeSurface(activate) {
		const element = document.getElementById('surface')
		if (!activate) {
			element.setAttribute('readonly', 'readonly')
			element.value = ''
		} else element.removeAttribute('readonly')
	}
	
	function activeBudget(activate) {
		const element = document.getElementById('budget')
		if (!activate) {
			element.setAttribute('readonly', 'readonly')
			element.value = ''
		} else element.removeAttribute('readonly')
	}
	
	function handleChangeSurfaceConstraint(element) {
		if (element.value === modality.not) activeSurface(false)
		else activeSurface(true)
	}
	
	function handleChangeBudgetConstraint(element) {
		if (element.value === modality.not) activeBudget(false)
		else activeBudget(true)
	}
</script>
</body>
</html>
