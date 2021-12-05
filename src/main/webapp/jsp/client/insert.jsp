<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 20:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="insert-modal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{this.states.titreEtape}}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form autocomplete="off" id="insert-personal-form">
                    <input type="submit" hidden="hidden" id="insert-information-submitters">
                    <div class="form-group">
                        <label for="insert-cin">cin:<span class="text-danger">*</span></label>
                        <input type="text" placeholder="xxx xx(1 ou 2) xxx xxx (Sans espace)" name="cin" id="insert-cin" class="form-control" required maxlength="12">
                        <small class="form-text text-danger" id="insert-cin-error"></small>
                    </div>
                    <div class="form-group">
                        <label for="insert-nom">nom:<span class="text-danger">*</span></label>
                        <input type="text" placeholder="ex: Rakotoarivelo" name="nom" id="insert-nom" class="form-control" required>
                        <small class="form-text text-danger" id="insert-nom-error"></small>
                    </div>
                    <div class="form-group">
                        <label for="insert-prenom">prénom:</label>
                        <input type="text" placeholder="ex: Benjamina" class="form-control" id="insert-prenom" name="prenom">
                    </div>
                </form>
                <form autocomplete="off" id="insert-telephones-form">
                    <input type="submit" hidden="hidden" id="insert-telephones-submitters">
                    <div id="insert-telephones-iteration">
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button class="btn btn-primary btn-flat w-100" type="button" onclick="addTelephone()"><i class="fa fa-plus"></i></button>
                        </div>
                    </div>
                </form>
                <form autocomplete="off" id="insert-address-form">
                    <input type="submit" hidden="hidden" id="insert-address-submitter">
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-ville">ville:<span class="text-danger">*</span></label>
                                <input type="text" placeholder="ex: Fianarantsoa" class="form-control" id="insert-ville" name="ville">
                                <small class="form-text text-danger" id="insert-ville-error"></small>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-postal">code postal:<span class="text-danger">*</span></label>
                                <input type="number" placeholder="ex: 301" class="form-control" id="insert-postal" name="postal">
                                <small class="form-text text-danger" id="insert-postal-error"></small>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label for="insert-lot">lot:</label>
                            <textarea id="insert-lot" rows="3" class="form-control" name="lot"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="insert-cancel">Annuler</button>
                <button type="button" class="btn btn-default" id="insert-previous"><i class="fa fa-angle-left"></i> Précédent</button>
                <button type="button" class="btn btn-primary" id="insert-next">Suivant <i class="fa fa-angle-right"></i></button>
                <button type="button" class="btn btn-primary" id="insert-save">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script>
	$(() => {
		currentForm = 1
		const formData = new FormData()
		
		function activeForm(form) {
			$(steps.personal).hide()
			$(steps.telephones).hide()
			$(steps.address).hide()
			$(steps[form]).show()
		}
		
		const buttons = {
			close: document.getElementById('insert-cancel'),
			previous: document.getElementById('insert-previous'),
			next: document.getElementById('insert-next'),
			save: document.getElementById('insert-save')
		}
		
		$(buttons.previous).hide()
		$(buttons.save).hide()
		$(buttons.next).on('click', event => {
			switch (currentForm) {
				case 1:
					$(steps.personal).trigger('submit')
					break
				case 2:
					$(steps.telephones).trigger('submit')
					break
				case 3:
					$(steps.address).trigger('submit')
					break
			}
		})
		$(buttons.previous).on('click', event => {
			switch (currentForm) {
				case 2:
					currentForm--
					$(buttons.previous).hide()
					$(buttons.close).show()
					activeForm('personal')
					break
				case 3:
					currentForm--
					$(buttons.save).hide()
					$(buttons.next).show()
					activeForm('telephones')
					break
			}
		})
		
		const steps = {
			personal: document.getElementById('insert-personal-form'),
			telephones: document.getElementById('insert-telephones-form'),
			address: document.getElementById('insert-address-form')
		}
		$(steps.personal).validate()
		$(steps.address).validate()
		
		updateTelephoneField()
		
		activeForm('personal')
		
		$(steps.personal).on('submit', event => {
			event.preventDefault()
			formData.append('cin', document.querySelector('[name=cin]').value)
			formData.append('nom', document.querySelector('[name=nom]').value)
			formData.append('prenom', document.querySelector('[name=prenom]').value)
			if ($(event.target).valid()) {
				currentForm++
				$(buttons.previous).show()
				$(buttons.close).hide()
				activeForm('telephones')
			}
		})
		$(steps.telephones).on('submit', event => {
			event.preventDefault()
			if ($(steps.telephones).valid()) {
				alert('valide')
				currentForm++
				$(buttons.next).hide()
				$(buttons.save).show()
				activeForm('address')
			}
		})
	})
	let currentForm = 1
	const telephones = ['']
	let insertForm = {}
	
	function updateTelephoneField() {
		let html = ''
		telephones.forEach((telephone, iteration) => html += createTelephoneField(iteration, telephone))
		document.getElementById('insert-telephones-iteration').innerHTML = html
		$(document.getElementById('insert-telephones-form')).validate({
			errorPlacement: (error, element) => {
				$(element).parents('.form-group').find('.form-text').text(error.text())
			}
		})
	}
	
	function addTelephone() {
		telephones.push('')
		updateTelephoneField()
	}
	
	function createTelephoneField(iteration, content) {
		return `<div class="form-group">
            <label for="insert-telephone` + iteration + `">téléphone n° ` + (iteration + 1) + `:<span class="text-danger">*</span></label>
            <div class="input-group">
                <input type="text" placeholder="ex: 03x xx xxx xx (Sans éspace)" name="telephones[]" id="insert-telehone` + iteration + `" value="` + content + `" class="form-control" oninput="writeTelephone(` + iteration + `, this)" required="requires" maxlength="10">
                <div class="input-group-append">
                    <button class="btn btn-danger" type="button" ` + (iteration <= 0 && 'disabled="disabled"') + ` onclick="deleteTelephone(` + iteration + `)"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <small class="form-text text-danger" id="insert-telephone` + iteration + `-error"></small>
        </div>`
	}
	
	function writeTelephone(iteration, element) {
		telephones[iteration] = element.value
	}
	
	function deleteTelephone(iteration) {
		telephones.splice(iteration, 1)
		updateTelephoneField()
	}
	
	function submitInsertion(order, element) {
	
	}
	
	function initInsertForm() {
	
	}
</script>

