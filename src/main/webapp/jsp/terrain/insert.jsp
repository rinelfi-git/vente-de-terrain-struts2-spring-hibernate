<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 07/12/2021
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="insert-modal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Nouveau Terrain</h4>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form autocomplete="off" onsubmit="return insert()">
                    <input type="submit" value="" hidden="hidden">
                    <div class="form-group">
                        <label for="insert-localisation">localisation:<span
                            class="text-danger">*</span></label>
                        <input type="text"
                               class="form-control" name="localisation" id="insert-localisation" required>
                    </div>
                    <div class="form-group">
                        <label for="insert-proprietaire">propriétaire:<span
                            class="text-danger">*</span></label>
                        <div class="input-group mb-2" id="client-search-input-insert">
                            <input type="text" class="form-control" placeholder="Recherche"
                                   oninput="search_for_client(this, clients)"/>
                            <div class="input-group-append">
								<span class="btn btn-default"
                                      id="client-search-result-number-insert">0</span>
                            </div>
                        </div>
                        <div class="input-group">
                            <select id="insert-proprietaire" class="custom-select">
                                <option selected="selected" hidden="hidden" disabled="disabled">(Sélectionner un propriétaire)</option>
                            </select>
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button" onclick="toggleClientSearch()">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-surface">surface:<span
                                    class="text-danger">*</span></label> <input type="number"
                                                                                class="form-control" id="insert-surface">
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-prix">prix par m²:<span
                                    class="text-danger">*</span></label> <input type="number"
                                                                                class="form-control" id="insert-prix">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="insert-relief">relief:<span
                            class="text-danger">*</span></label> <select id="insert-relief"
                                                                         class="custom-select">
                        <option value="Coline">Coline</option>
                        <option value="Montagne">Montagne</option>
                        <option value="Plateau">Plateau</option>
                        <option value="Plaine">Plaine</option>
                    </select>
                    </div>
                    <div class="row">
                        <div class="icheck-primary ml-2 mb-3">
                            <input type="checkbox" id="insert-en-vente" name="en-vente">
                            <label for="insert-en-vente">
                                En vente
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="insert()">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script>
	var clientSearchInputInsert = document.getElementById('client-search-input-insert')
	var clients = []
	
	function insert() {
		const localisationValidation = $formValidation(document.getElementById('insert-localisation'))
		const proprietaryValidation = $formValidation(document.getElementById('insert-proprietaire'))
		const surfaceValidation = $formValidation(document.getElementById('insert-surface'))
		const prixValidation = $formValidation(document.getElementById('insert-prix'))
		const reliefValidation = $formValidation(document.getElementById('insert-relief'))
		
		if (localisationValidation.isValid() && proprietaryValidation.isValid() && surfaceValidation.isValid() && prixValidation.isValid() && reliefValidation.isValid()) {
			$.ajax({
				url: baseUrl('/terrain/insert.action'),
				method: 'post',
				dataType: 'json',
				data: {
					localisation: $('#insert-localisation').val(),
					proprietaire: parseInt($('#insert-proprietaire').val(), 10),
					surface: parseFloat($('#insert-surface').val()),
					prix: parseInt($('#insert-prix').val(), 10),
					relief: $('#insert-relief').val(),
					enVente: $('#insert-en-vente').is(':checked')
				},
				success: function (response) {
				
				},
				error: function () {
					alert('error')
				}
			})
		}
		return false
	}
	
	function initSearchField() {
		$(clientSearchInputInsert).css({display: 'none'})
	}
	
	function toggleClientSearch() {
		if ($(clientSearchInputInsert).is(':hidden')) {
			$(clientSearchInputInsert).css({display: 'flex'})
			$(clientSearchInputInsert).find('input').val('')
			$(clientSearchInputInsert).find('span').text(0)
		} else initSearchField()
	}
	
	function getClients() {
		return new Promise(function (resolve) {
			$.ajax({
				url: baseUrl('client/list.action'),
				method: 'get',
				dataType: 'json',
				success: function (response) {
					resolve(response)
				},
				error: function (error1, error2, error3) {
					console.error(error1, error2, error3)
				}
			})
		})
	}
	
	function constructClientHtml(clients) {
		let client_html = '<option selected="selected" hidden="hidden" disabled="disabled">(Sélectionner un propriétaire)</option>';
		for (client of clients) {
			client_html += '<option value="' + client.id + '">(' + client.cin + ') ' + client.nom + ' ' + (client.prenom != null ? client.prenom : '') + '</option>'
		}
		$('#insert-proprietaire').html(client_html)
	}
	
	function search_for_client(element, clients) {
		var copy = clients.slice()
		if (element.value.length > 0) {
			copy = copy.filter(function (client) {
				if (client.cin.toString().indexOf(element.value) >= 0 || client.nom != null && client.nom.toUpperCase().indexOf(element.value.toUpperCase()) >= 0 || client.prenom != null && client.prenom.toUpperCase().indexOf(element.value.toUpperCase()) >= 0) return client
			})
			$('#client-search-result-number-insert').text(copy.length)
		} else $('#client-search-result-number-insert').text(0)
		console.log('result', copy)
		constructClientHtml(copy)
	}
	
	initSearchField()
	
	getClients().then(function (resolve) {
		clients = resolve
		constructClientHtml(clients)
	})


</script>

