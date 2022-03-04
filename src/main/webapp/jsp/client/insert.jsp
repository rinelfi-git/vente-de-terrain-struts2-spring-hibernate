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
                <h4 class="modal-title">Nouveau client</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form autocomplete="off" id="insert-personal-form">
                    <input type="submit" hidden="hidden" id="insert-information-submitters">
                    <div class="form-group">
                        <label for="insert-cin">cin:<span class="text-danger">*</span></label>
                        <input type="text" placeholder="xxx xx(1 ou 2) xxx xxx (Sans espace)" name="cin" id="insert-cin" class="form-control" required maxlength="12" pattern="[0-9]{5}(1|2){1}[0-9]{6}">
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
                                <input type="text" placeholder="ex: Fianarantsoa" class="form-control" id="insert-ville" name="ville" required>
                                <small class="form-text text-danger" id="insert-ville-error"></small>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-postal">code postal:<span class="text-danger">*</span></label>
                                <input type="number" placeholder="ex: 301" class="form-control" id="insert-postal" name="postal" required>
                                <small class="form-text text-danger" id="insert-postal-error"></small>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label for="insert-lot">lot:</label>
                            <textarea id="insert-lot" rows="3" class="form-control" name="lot"></textarea>
                            <small class="form-text text-danger" id="insert-lot-error"></small>
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
    let insertSteps = {}
    $(() => {
        currentForm = 1

        function activeForm(form) {
            $(insertSteps.personal.element).hide()
            $(insertSteps.telephones.element).hide()
            $(insertSteps.address.element).hide()
            $(insertSteps[form].element).show()
        }

        const buttons = {
            close: document.getElementById('insert-cancel'),
            previous: document.getElementById('insert-previous'),
            next: document.getElementById('insert-next'),
            save: document.getElementById('insert-save')
        }

        $(buttons.previous).hide()
        $(buttons.save).hide()
        $(buttons.next).on('click', () => {
            switch (currentForm) {
                case 1:
                    $(insertSteps.personal.element).trigger('submit')
                    break
                case 2:
                    $(insertSteps.telephones.element).trigger('submit')
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
        $(buttons.save).on('click', event => {
            event.preventDefault()
            $(insertSteps.address.element).trigger('submit')
        })

        insertSteps = {
            personal: {
                element: document.getElementById('insert-personal-form'),
                fields: [
                    document.getElementById('insert-cin'),
                    document.getElementById('insert-nom'),
                    document.getElementById('insert-prenom')
                ],
                invalids: [],
                validate: function () {
                    let output = true
                    this.invalids = []
                    $(this.element).find('.form-text').text('')
                    $(this.element).find('.is-invalid').removeClass('is-invalid')
                    for (let element of this.fields) {
                        if (element.pattern !== '' && (element.value === '' || element.value.match(element.pattern) == null)) {
                            output = false
                            this.invalids.push({field: element, error: 'pattern'})
                        }
                        if (element.maxLength > 0 && element.value.length > element.maxLength) {
                            output = false
                            this.invalids.push({field: element, error: 'maxLength'})
                        }
                        if (element.minLength > 0 && element.value.length < element.minLength) {
                            output = false
                            this.invalids.push({field: element, error: 'minLength'})
                        }
                        if (element.required && element.value === '') {
                            output = false
                            this.invalids.push({field: element, error: 'required'})
                        }
                    }
                    return output
                },
                isValid: function () {
                    return this.validate()
                }
            },
            telephones: {
                element: document.getElementById('insert-telephones-form'),
                fields: [],
                invalids: [],
                validate: function () {
                    let output = true
                    this.invalids = []
                    $(this.element).find('.form-text').text('')
                    $(this.element).find('.is-invalid').removeClass('is-invalid')
                    for (let element of this.fields) {
                        if (element.pattern !== '' && (element.value === '' || element.value.match(element.pattern) == null)) {
                            output = false
                            this.invalids.push({field: element, error: 'pattern'})
                        }
                        if (element.maxLength > 0 && element.value.length > element.maxLength) {
                            output = false
                            this.invalids.push({field: element, error: 'maxLength'})
                        }
                        if (element.minLength > 0 && element.value.length < element.minLength) {
                            output = false
                            this.invalids.push({field: element, error: 'minLength'})
                        }
                        if (element.required && element.value === '') {
                            output = false
                            this.invalids.push({field: element, error: 'required'})
                        }
                    }
                    return output
                },
                isValid: function () {
                    return this.validate()
                }
            },
            address: {
                element: document.getElementById('insert-address-form'),
                fields: [
                    document.getElementById('insert-ville'),
                    document.getElementById('insert-postal'),
                    document.getElementById('insert-lot'),
                ],
                invalids: [],
                validate: function () {
                    let output = true
                    this.invalids = []
                    $(this.element).find('.form-text').text('')
                    $(this.element).find('.is-invalid').removeClass('is-invalid')
                    for (let element of this.fields) {
                        if (element.pattern !== '' && (element.value === '' || element.value.match(element.pattern) == null)) {
                            output = false
                            this.invalids.push({field: element, error: 'pattern'})
                        }
                        if (element.maxLength > 0 && element.value.length > element.maxLength) {
                            output = false
                            this.invalids.push({field: element, error: 'maxLength'})
                        }
                        if (element.minLength > 0 && element.value.length < element.minLength) {
                            output = false
                            this.invalids.push({field: element, error: 'minLength'})
                        }
                        if (element.required && element.value === '') {
                            output = false
                            this.invalids.push({field: element, error: 'required'})
                        }
                    }
                    return output
                },
                isValid: function () {
                    return this.validate()
                }
            }
        }

        updateTelephoneField()

        activeForm('personal')

        $(insertSteps.personal.element).on('submit', event => {
            event.preventDefault()
            if (insertSteps.personal.isValid()) {
                currentForm++
                $(buttons.previous).show()
                $(buttons.close).hide()
                activeForm('telephones')
            } else {
                for (let invalid of insertSteps.personal.invalids) {
                    if (invalid.error === 'required') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'Ce champ est requis'
                            }
                        }
                    } else if (invalid.error === 'pattern') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'Le format n\'est pas correct'
                            }
                        }
                    } else if (invalid.error === 'maxLength') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'L\'entrée est trop longue'
                            }
                        }
                    } else if (invalid.error === 'minLength') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'L\'entrée est trop courte'
                            }
                        }
                    }
                }
            }
        })
        $(insertSteps.telephones.element).on('submit', event => {
            event.preventDefault()
            if (insertSteps.telephones.isValid()) {
                currentForm++
                $(buttons.next).hide()
                $(buttons.save).show()
                for (let telephone of telephones)
                    console.log(telephone)
                activeForm('address')
            } else {
                for (let invalid of insertSteps.telephones.invalids) {
                    if (invalid.error === 'required') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text'))
                                collections[collection].textContent = 'Ce champ est requis'
                        }
                    } else if (invalid.error === 'pattern') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text'))
                                collections[collection].textContent = 'Le format n\'est pas correct'
                        }
                    } else if (invalid.error === 'maxLength') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text'))
                                collections[collection].textContent = 'L\'entrée est trop longue'
                        }
                    } else if (invalid.error === 'minLength') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text'))
                                collections[collection].textContent = 'L\'entrée est trop courte'
                        }
                    }
                }
            }
        })

        $(insertSteps.address.element).on('submit', event => {
            event.preventDefault()
            if (insertSteps.address.isValid()) {
                const formData = {
                    cin: insertSteps.personal.fields[0].value,
                    nom: insertSteps.personal.fields[1].value,
                    prenom: insertSteps.personal.fields[2].value,
                    ville: insertSteps.address.fields[0].value,
                    codePostal: insertSteps.address.fields[1].value,
                    lot: insertSteps.address.fields[2].value,
                    telephones: []
                }
                telephones.forEach((telephone, iteration) => formData.telephones.push(telephone))
                submitInsertion(formData).then(response => {
                    getDataFromService()
                    $('#insert-modal').modal('hide')
                }).catch(errors => console.log(erros))
            } else {
                for (let invalid of insertSteps.address.invalids) {
                    if (invalid.error === 'required') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'Ce champ est requis'
                            }
                        }
                    } else if (invalid.error === 'pattern') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'Le format n\'est pas correct'
                            }
                        }
                    } else if (invalid.error === 'maxLength') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'L\'entrée est trop longue'
                            }
                        }
                    } else if (invalid.error === 'minLength') {
                        invalid.field.classList.add('is-invalid')
                        let collections = invalid.field.parentElement.children
                        for (let collection in collections) {
                            if (typeof collections[collection] === 'object' && collections[collection].classList.contains('form-text')) {
                                collections[collection].textContent = 'L\'entrée est trop courte'
                            }
                        }
                    }
                }
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
        insertSteps.telephones.fields = []
        telephones.forEach((telephone, iteration) => {
            if (insertSteps.telephones.fields)
                insertSteps.telephones.fields.push(document.getElementById('insert-telephone' + iteration))
        })
        console.log(insertSteps.telephones.fields)
    }

    function addTelephone() {
        telephones.push('')
        updateTelephoneField()
    }

    function createTelephoneField(iteration, content) {
        return `<div class="form-group">
            <label for="insert-telephone` + iteration + `">téléphone n° ` + (iteration + 1) + `:<span class="text-danger">*</span></label>
            <div class="input-group">
                <input type="text" placeholder="ex: 03x xx xxx xx (Sans éspace)" name="telephones[]" id="insert-telephone` + iteration + `" value="` + content + `" class="form-control" oninput="writeTelephone(` + iteration + `, this)" required="requires" maxlength="10" pattern="(03){1}[2-4]{1}[0-9]{7}">
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

    function submitInsertion(formData) {
        return new Promise((resolve, reject) => {
            $.ajax({
                method: 'post',
                data: formData,
                dataType: 'json',
                url: baseUrl('client/insert.action'),
                traditional: true,
                success: response => resolve(response),
                error: (error1, error2, error3) => reject([error1, error2, error3])
            })
        })
    }

    function initInsertForm() {

    }
</script>

