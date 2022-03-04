/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function clientPhoneFormTemplate(index, scope, value) {
    return `
    <div class="form-group" id="${scope}-phone${index}-container">
        <label for="${scope}-phone${index}">Numéro de téléphone N°${index + 1}</label>
        <div class="input-group">
            <input class="form-control ${scope}-phone-input" placeholder="03X XX XXX XX" type="text" pattern="^03[2-9]{1}-[0-9]{2}-[0-9]{3}-[0-9]{2}$" id="${scope}-phone${index}" value="${value}" required oninput="checkInputPhone(this)" maxlength="13">
            <div class="input-group-append">
                <button class="btn btn-danger" ${index === 0 ? 'disabled' : `onclick="deletePhoneAt(${index}, '${scope}')"`}>
                    <i class="fa fa-minus"></i>
                </button>
            </div>
        </div>
        <small class="form-text text-danger" id="${scope}-phone${index}-error"></small>
    </div>
    `
}

function deletePhoneAt(index, scope) {
    document.getElementById(`${scope}-phone${index}-container`).remove()
    const phones = document.querySelectorAll(`.${scope}-phone-input`)
    let phoneHtml = ''
    for (let i = 0; i < phones.length; i++) {
        phoneHtml += clientPhoneFormTemplate(i, scope, phones[i].value)
    }
    document.getElementById(`${scope}-phones-iteration`).innerHTML = phoneHtml
}

function addPhoneForm(scope) {
    const phones = document.querySelectorAll(`.${scope}-phone-input`)
    let phoneHtml = ''
    for (let i = 0; i < phones.length; i++) {
        phoneHtml += clientPhoneFormTemplate(i, scope, phones[i].value)
    }
    phoneHtml += clientPhoneFormTemplate(phones.length, scope, '')
    document.getElementById(`${scope}-phones-iteration`).innerHTML = phoneHtml
}

function checkInputPhone(element) {
    const insertionNombre = !isNaN(parseInt(element.value.slice(-1)))
    if (insertionNombre) {
        const cassures = [3, 6, 10];
        const selectionStart = element.selectionStart;
        let correction = element.value.replaceAll('-', '')
        cassures.forEach(function (cassure) {
            if (correction.length > cassure)
                correction = correction.slice(0, cassure) + '-' + correction.slice(cassure, correction.length)
        })
        element.value = correction
        if(element.value.length -1 !== selectionStart || element.value.slice(-2, -1) !== '-') element.setSelectionRange(selectionStart, selectionStart)
    } else
        element.value = element.value.slice(0, -1)
}