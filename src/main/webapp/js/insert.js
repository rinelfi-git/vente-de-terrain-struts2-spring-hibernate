/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

