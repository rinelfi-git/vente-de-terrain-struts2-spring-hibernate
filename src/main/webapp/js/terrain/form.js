/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global formMap, identity, mapboxgl, markerMap, toastr */

let clients = [];
let proprietaire_id = -1;
const views = {
    global: 5,
    centered: 17
};

function initClientSearchField(scope) {
    document.getElementById(`${scope}-client-search-container`).style.display = 'none';
}

function toggleClientSearch(scope) {
    const container = document.getElementById(`${scope}-client-search-container`);
    if ($(container).is(':hidden')) {
        $(container).css({
            display: 'flex'
        });
        $(container).find('input').val('');
        $(container).find('span').text(0);
    } else initClientSearchField(scope);
}

function getClients() {
    return new Promise(function (resolve) {
        $.ajax({
            url: baseUrl('client/list.action'),
            method: 'get',
            dataType: 'json',
            success: function (response) {
                resolve(response);
            },
            error: function (error1, error2, error3) {
                console.error(error1, error2, error3);
            }
        });
    });
}

function constructClientHtml(clients, scope) {
    let clientHtml = '<option selected="selected" hidden="hidden" disabled="disabled" value="">(Sélectionner un propriétaire)</option>';
    for (const client of clients) {
        clientHtml += '<option value="' + client.id + '">(' + client.cin + ') ' + client.nom + ' ' + (client.prenom !== null ? client.prenom : '') + '</option>';
    }
    document.getElementById(`${scope}-proprietaire`).innerHTML = clientHtml;
    console.log(identity, 'identity');
    if(proprietaire_id > 0) document.getElementById(`${scope}-proprietaire`).value = proprietaire_id;
}

function searchForClient(element, clients, scope) {
    var copy = clients.slice();
    if (element.value.length > 0) {
        copy = copy.filter(function (client) {
            if (client.cin.toString().indexOf(element.value) >= 0 || client.nom !== null && client.nom.toUpperCase().indexOf(element.value.toUpperCase()) >= 0 || client.prenom !== null && client.prenom.toUpperCase().indexOf(element.value.toUpperCase()) >= 0)
                return client;
        });
        document.getElementById(`${scope}-client-search-result-number`).textContent = copy.length;
    } else {
        document.getElementById(`${scope}-client-search-result-number`).textContent = 0;
    }
    constructClientHtml(copy, scope);
}

function switchGeolocationMode(element, scope) {
    console.log(element, 'with scope', scope);
    if ($(element).is(':checked')) {
        $(`#${scope}-coordinates`).css({
            display: 'flex'
        });
        $(`#${scope}-map-selection`).css({
            display: 'flex'
        });
        $(`#${scope}-coordinates`).find('input[type=number]').trigger('input');
        $(`#${scope}-map-view`).css({
            display: 'block'
        });
        formMap[scope].resize();
    } else {
        $(`#${scope}-coordinates`).css({
            display: 'none'
        });
        $(`#${scope}-map-selection`).css({
            display: 'none'
        });
        $(`#${scope}-longitude`).find('input[type=number]').val('47.0908595');
        $(`#${scope}-latitude`).find('input[type=number]').val('-21.4560529');
        $(`#${scope}-coordinates`).find('input[type=number]').trigger('input');
        $(`#${scope}-map-view`).css({
            display: 'none'
        });
        $(`#${scope}-map-view`).find('input').prop('checked', false);
        $(`#${scope}-map-view`).find('input').trigger('change');
    }
}

function updateMapViewMode(element, scope) {
    const outdoor = 'mapbox://styles/mapbox/outdoors-v11';
    const satellite = 'mapbox://styles/mapbox/satellite-v9';
    formMap[scope].setStyle(element.checked ? satellite : outdoor);
}

function updateCurrentLocationInput(scope) {
    const long = document.getElementById(`${scope}-longitude`);
    const lat = document.getElementById(`${scope}-latitude`);
    const longlat = [long.value === '' ? 0 : parseFloat(long.value), lat.value === '' ? 0 : parseFloat(lat.value)];
    markerMap[scope].remove();
    markerMap[scope] = new mapboxgl.Marker().setLngLat(longlat).addTo(formMap[scope]);
    formMap[scope].flyTo({
        zoom: 18,
        center: longlat
    });
}

function submit(scope) {
    $('.is-invalid').removeClass('is-invalid');
    $('.form-text').css({
        display: 'none'
    });

    const validators = [
        $formValidation(`${scope}-adresse`),
        $formValidation(`${scope}-proprietaire`),
        $formValidation(`${scope}-surface`),
        $formValidation(`${scope}-prix`)
    ];
    const validatorValid = validators.find(function (validator) {
        if (!validator.isValid()) return validator;
    });
    if (typeof validatorValid === 'undefined') {
        const data = {
            adresse: document.getElementById(`${scope}-adresse`).value,
            geolocated: document.getElementById(`${scope}-point-geographique`).checked,
            longitude: document.getElementById(`${scope}-longitude`).value,
            latitude: document.getElementById(`${scope}-latitude`).value,
            proprietaire: document.getElementById(`${scope}-proprietaire`).value,
            surface: parseFloat(document.getElementById(`${scope}-surface`).value),
            prix: document.getElementById(`${scope}-prix`).value,
            relief: document.getElementById(`${scope}-relief`).value,
            enVente: document.getElementById(`${scope}-en-vente`).checked
        };
        if (scope === 'update') data.id = identity;
        $.ajax({
            url: baseUrl(`/terrain/${scope}.action`),
            method: 'post',
            dataType: 'json',
            data,
            success: function () {
                $(`#${scope}-modal`).modal('hide');
                if (scope === 'insert') {
                    initInsertForm();
                    toastr["success"]("Un terrain est ajouté dans la base de données", "Insertion");
                } else {
                    toastr["success"]("Un terrain dans la base de données est modifié", "Modification");
                    proprietaire_id = -1;
                    identity = -1;
                }
                getDataFromService();
            },
            error: function () {
                alert('error');
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
    return false;
}

$(document).ready(function () {
    getClients().then(function (resolve) {
        clients = resolve;
        constructClientHtml(clients, 'insert');
        constructClientHtml(clients, 'update');
    });
    $('#insert-modal').on('bs-modal-show', () => {
        initClientSearchField('insert');
    });
    ['insert', 'update'].forEach(scope => {
        $(`${scope}-modal`).on('bs-modal-hide', () => {
            formMap[scope] = new mapboxgl.Map({
                container: `${scope}-map-selection`,
                style: 'mapbox://styles/mapbox/outdoors-v11', // style URL,
                zoom: 4,
                center: [47.0908595, -21.4560529]
            });
            markerMap[scope] = new mapboxgl.Marker().setLngLat([47.0908595, -21.4560529]).addTo(formMap[scope]);
        })
    });
});