<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container mb-2">
    <div class="card">
        <div class="card-body">
            <!-- SEARCH FORM -->
            <form autocomplete="off" onsubmit="return getDataFromService()">
                <div class="input-group input-group-lg">
                    <input class="form-control form-control-navbar" name="keyword" type="search" placeholder="Recherche" aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="btn-group mt-2">
                    <button type="button" class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#element-per-page"><span class="material-icons">format_list_numbered</span></button>
                    <button type="button" class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#module-recherche"><span class="material-icons">view_module</span></button>
                    <button type="button" class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#tri"><span class="material-icons">sort</span></button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal" id="element-per-page">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Nombre d'élément par page</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form onsubmit="return false">
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="element-per-page" id="element-per-page-1" value="1" onchange="updatePaginationPerPage(this)">
			  <label class="form-check-label" for="element-per-page-1">
			    1 éléments
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="element-per-page" id="element-per-page-3" value="3" onchange="updatePaginationPerPage(this)">
			  <label class="form-check-label" for="element-per-page-3">
			    3 éléments
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="element-per-page" id="element-per-page-6" value="6" checked onchange="updatePaginationPerPage(this)">
			  <label class="form-check-label" for="element-per-page-6">
			    6 éléments
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="element-per-page" id="element-per-page-9" value="9" onchange="updatePaginationPerPage(this)">
			  <label class="form-check-label" for="element-per-page-9">
			    9 éléments
			  </label>
			</div>
        </form>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>


<div class="modal" id="module-recherche">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Champ à rechercher</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form onsubmit="return false">
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="search-field" id="search-field-cin" value="cin" checked>
			  <label class="form-check-label" for="search-field-cin">
			    CIN
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="search-field" id="search-field-nom" value="nom">
			  <label class="form-check-label" for="search-field-nom">
			    Nom et prénoms
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="search-field" id="search-field-telephone" value="telephone">
			  <label class="form-check-label" for="search-field-telephone">
			    Numéro de téléphone
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="search-field" id="search-field-adresse" value="adresse">
			  <label class="form-check-label" for="search-field-adresse">
			    Adresse
			  </label>
			</div>
        </form>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>


<div class="modal" id="tri">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Trier par</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form onsubmit="return false">
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="sort-field" id="sort-field-cin" value="cin" checked>
			  <label class="form-check-label" for="sort-field-cin">
			    CIN
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="sort-field" id="sort-field-nom" value="nom">
			  <label class="form-check-label" for="sort-field-nom">
			    Nom et prénoms
			  </label>
			</div>
        	<div class="form-check">
			  <input class="form-check-input" type="radio" name="sort-field" id="sort-field-adresse" value="adresse">
			  <label class="form-check-label" for="sort-field-adresse">
			    Adresse
			  </label>
			</div>
			<fieldset>
				<legend>Par ordre</legend>
	        	<div class="form-check">
				  <input class="form-check-input" type="radio" name="sort-order" id="sort-order-az" value="asc" checked>
				  <label class="form-check-label" for="sort-order-az">
				    Croissant
				  </label>
				</div>
	        	<div class="form-check">
				  <input class="form-check-input" type="radio" name="sort-order" id="sort-order-za" value="desc">
				  <label class="form-check-label" for="sort-order-za">
				    Decroissant
				  </label>
				</div>
			</fieldset>
        </form>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>


<script>
	function updatePaginationPerPage(element) {
		paginationElementPerPage = parseInt(element.value)
	}
</script>
