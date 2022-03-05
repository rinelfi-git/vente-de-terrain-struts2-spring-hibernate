let paginationCurrentPage = 1;
let paginationElementPerPage = 12;
let pageLength = 1;
let identity = -1;

function udpateClientProfileImage(id) {
    identity = id;
    $('#update-profile-image').modal('show');
}

function getDataFromService() {
    var keyword = $('[name=keyword]').val();
    $.ajax({
        method: 'post',
        url: baseUrl('client/pagination.action'),
        data: {
            pageCurrent: paginationCurrentPage,
            elementPerPage: paginationElementPerPage,
            paginationSearchActivated: keyword.length > 0,
            paginationSearchKeyword: keyword,
            paginationSearchField: $('[name=search-field]').filter(':checked').val(),
            paginationOrdered: true,
            orderDirection: $('[name=sort-order]').filter(':checked').val(),
            paginationFieldOrder: $('[name=sort-field]').filter(':checked').val()
        },
        dataType: 'json',
        success: function (response) {
            clientsHtml = '';
            for (const client of response) {
                clientsHtml += clientCardTemplate(client.id, client.nom, client.prenom, client.cin, client.adresse, client.telephones, client.photo);
            }
            $('#client-card-view').html(clientsHtml);
            getPagesList();
        }
    });
    return false;
}

function navigatePaginationTo(target) {
    var min = Math.min(target, pageLength), max = Math.max(1, target);
    paginationCurrentPage = min == pageLength ? min : max;
    getDataFromService();
}

function getPagesList() {
    var keyword = $('[name=keyword]').val();
    $.ajax({
        method: 'post',
        url: baseUrl('client/records.action'),
        data: {
            pageCurrent: paginationCurrentPage,
            elementPerPage: paginationElementPerPage,
            paginationSearchActivated: keyword.length > 0,
            paginationSearchKeyword: keyword,
            paginationSearchField: $('[name=search-field]').filter(':checked').val()
        },
        dataType: 'json',
        success: function (response) {
            pageLength = Math.ceil(response / paginationElementPerPage);
            $('#client-pagination').html(paginationTemplate(1, pageLength, paginationCurrentPage));
        }
    });
}

function checkInputCin(element) {
    const insertionNombre = !isNaN(parseInt(element.value.slice(-1)));
    if (insertionNombre) {
        const cassures = [3, 7, 11];
        const selectionStart = element.selectionStart;
        let correction = element.value.replaceAll('-', '');
        cassures.forEach(function (cassure) {
            if (correction.length > cassure)
                correction = correction.slice(0, cassure) + '-' + correction.slice(cassure, correction.length);
        });
        element.value = correction;
        if (element.value.length - 1 !== selectionStart || element.value.slice(-2, -1) !== '-') element.setSelectionRange(selectionStart, selectionStart);
    } else
        element.value = element.value.slice(0, -1);
}

function validateStepForm(step, scope) {
    $('.is-invalid').removeClass('is-invalid');
    $('.form-text').css({
        display: 'none'
    });

    let validators = [];
    let validatorValid = null;

    switch (parseInt(step)) {
        case 1:
            validators = [
                $formValidation(`${scope}-cin`),
                $formValidation(`${scope}-nom`),
                $formValidation(`${scope}-prenom`)
            ];
            validatorValid = validators.find(function (validator) {
                if (!validator.isValid()) return validator;
            });
            if (typeof validatorValid === 'undefined') {
                loadStepForm(2, scope);
            } else {
                validators.forEach(function (validator) {
                    if (!validator.isValid()) {
                        validator.field.classList.add('is-invalid');
                        validator.putError(`${validator.field.getAttribute('id')}-error`);
                    }
                });
            }
            break;
        case 2:
            validators = [];

            const phones = document.querySelectorAll(`.${scope}-phone-input`);
            for (let i = 0; i < phones.length; i++) {
                validators.push($formValidation(`${scope}-phone${i}`));
            }

            validatorValid = validators.find(function (validator) {
                if (!validator.isValid()) {
                    return validator;
                }
            });

            if (typeof validatorValid === 'undefined') {
                loadStepForm(3, scope);
            } else {
                validators.forEach(function (validator) {
                    if (!validator.isValid()) {
                        validator.field.classList.add('is-invalid');
                        validator.putError(`${validator.field.getAttribute('id')}-error`);
                    }
                });
            }
            break;
        case 3:
            validators = [
                $formValidation(`${scope}-ville`),
                $formValidation(`${scope}-postal`),
                $formValidation(`${scope}-lot`)
            ];
            validatorValid = validators.find(function (validator) {
                if (!validator.isValid()) {
                    return validator;
                }
            });
            if (typeof validatorValid === 'undefined') {
                // envoi des données vers le serveur
                const data = {
                    cin: document.getElementById(`${scope}-cin`).value.replaceAll('-', ''),
                    nom: document.getElementById(`${scope}-nom`).value,
                    prenom: document.getElementById(`${scope}-prenom`).value,
                    ville: document.getElementById(`${scope}-ville`).value,
                    postal: document.getElementById(`${scope}-postal`).value,
                    lot: document.getElementById(`${scope}-lot`).value,
                    telephones: []
                };
                const phones = document.querySelectorAll(`.${scope}-phone-input`);
                
                for (const phone of phones) data.telephones.push(phone.value.replaceAll('-', ''));
                
                if (scope === 'update') data.identity = identity;
                
                $.ajax({
                    url: baseUrl(`client/${scope}.action`),
                    method: 'post',
                    data,
                    dataType: 'json',
                    traditional: true,
                    success: function (response) {
                        $(`#${scope}-modal`).modal('hide');
                        getDataFromService();
                    }
                });
            } else {
                validators.forEach(function (validator) {
                    if (!validator.isValid()) {
                        validator.field.classList.add('is-invalid');
                        validator.putError(`${validator.field.getAttribute('id')}-error`);
                    }
                });
            }
            break;
    }
    return false;
}

function recheckStepForm(step, scope) {
    switch (parseInt(step)) {
        case 2:
            loadStepForm(1, scope);
            break;
        case 3:
            loadStepForm(2, scope);
            break;
    }
    return false;
}

function loadStepForm(step, scope) {
    const scopes = [
        `${scope}-personal-form`,
        `${scope}-phones-form`,
        `${scope}-address-form`
    ];
    scopes.forEach(function (current) {
        document.getElementById(current).style.display = 'none';
    });
    document.getElementById(scopes[step - 1]).style.display = 'block';
    switch (step) {
        case 1:
            document.getElementById(`${scope}-cancel`).style.display = 'block';
            document.getElementById(`${scope}-previous`).style.display = 'none';
            document.getElementById(`${scope}-next`).style.display = 'block';
            document.getElementById(`${scope}-next`).dataset.target = 1;
            document.getElementById(`${scope}-save`).style.display = 'none';
            break;
        case 2:
            document.getElementById(`${scope}-cancel`).style.display = 'none';
            document.getElementById(`${scope}-previous`).style.display = 'block';
            document.getElementById(`${scope}-previous`).dataset.target = 2;
            document.getElementById(`${scope}-next`).style.display = 'block';
            document.getElementById(`${scope}-next`).dataset.target = 2;
            document.getElementById(`${scope}-save`).style.display = 'none';
            break;
        case 3:
            document.getElementById(`${scope}-cancel`).style.display = 'none';
            document.getElementById(`${scope}-previous`).style.display = 'block';
            document.getElementById(`${scope}-previous`).dataset.target = 3;
            document.getElementById(`${scope}-next`).style.display = 'none';
            document.getElementById(`${scope}-save`).style.display = 'block';
            break;
    }
}

$(document).ready(function () {
    $('.modal').on('closeModal', e => {
        $(e.currentTarget).modal('hide');
    });
    $(document).on('mouseover', '.custom-class-image-edit-overlay-foreground', e => {
        var icon = $(e.currentTarget).prev('.fa');
        var background = icon.prev('.custom-class-image-edit-overlay-background');
        var animationDuration = 200;
        icon.stop();
        background.stop();
        icon.css({
            position: 'absolute',
            top: ($(e.currentTarget).height() / 2 - icon.height() / 2) + 'px',
            left: (7 + $(e.currentTarget).width() / 2 - icon.width() / 2) + 'px'
        });
        icon.fadeIn(animationDuration);
        background.addClass('overlay-active');
        $(e.currentTarget).on('mouseout', e => {
            var icon = $(e.currentTarget).prev('.fa');
            var background = icon.prev('.custom-class-image-edit-overlay-background');
            icon.stop();
            icon.fadeOut(animationDuration);
            background.removeClass('overlay-active');
        });
    });

    $(document).on('mouseover', '.custom-class-image-edit-overlay-foreground', e => {
        var icon = $(e.currentTarget).prev('.fa');
        var background = icon.prev('.custom-class-image-edit-overlay-background');
        var animationDuration = 200;
        icon.stop();
        background.stop();
        icon.css({
            position: 'absolute',
            top: ($(e.currentTarget).height() / 2 - icon.height() / 2) + 'px',
            left: (7 + $(e.currentTarget).width() / 2 - icon.width() / 2) + 'px'
        });
        icon.fadeIn(animationDuration);
        background.addClass('overlay-active');
        $(e.currentTarget).on('mouseout', e => {
            var icon = $(e.currentTarget).prev('.fa');
            var background = icon.prev('.custom-class-image-edit-overlay-background');
            icon.stop();
            icon.fadeOut(animationDuration);
            background.removeClass('overlay-active');
        });
    });
    getDataFromService();
});
