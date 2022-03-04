/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var clientSearchInputInsert = document.getElementById('client-search-input-insert')
var clients = []

function switchGeolocationMode(element, scope) {
    console.log(`${scope}-coordinates`)
    if ($(element).is(':checked')) {
        $(`#${scope}-coordinates`).css({display: 'flex'})
        $(`#${scope}-map-selection`).css({display: 'flex'})
        $(`#${scope}-coordinates`).find('input[type=number]').trigger('input')
        formMap[scope].resize()
    } else {
        $(`#${scope}-coordinates`).css({display: 'none'})
        $(`#${scope}-map-selection`).css({display: 'none'})
        $(`#${scope}-coordinates`).find('input[type=number]').val('0.0')
        $(`#${scope}-coordinates`).find('input[type=number]').trigger('input')
    }
}

function insert() {
    const adresseValidation = $formValidation(document.getElementById('insert-adresse'))
    const proprietaryValidation = $formValidation(document.getElementById('insert-proprietaire'))
    const surfaceValidation = $formValidation(document.getElementById('insert-surface'))
    const prixValidation = $formValidation(document.getElementById('insert-prix'))
    const reliefValidation = $formValidation(document.getElementById('insert-relief'))

    if (adresseValidation.isValid() && proprietaryValidation.isValid() && surfaceValidation.isValid() && prixValidation.isValid() && reliefValidation.isValid()) {
        $.ajax({
            url: baseUrl('/terrain/insert.action'),
            method: 'post',
            dataType: 'json',
            data: {
                adresse: $('#insert-adresse').val(),
                geolocated: $('#insert-point-geographique').is(':checked'),
                longitude: $('#insert-longitude').val(),
                latitude: $('#insert-latitude').val(),
                proprietaire: parseInt($('#insert-proprietaire').val(), 10),
                surface: parseFloat($('#insert-surface').val()),
                prix: parseInt($('#insert-prix').val(), 10),
                relief: $('#insert-relief').val(),
                enVente: $('#insert-en-vente').is(':checked')
            },
            success: function () {
                getDataFromService()
                $('#insert-modal').modal('hide')
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
    } else
        initSearchField()
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
            if (client.cin.toString().indexOf(element.value) >= 0 || client.nom != null && client.nom.toUpperCase().indexOf(element.value.toUpperCase()) >= 0 || client.prenom != null && client.prenom.toUpperCase().indexOf(element.value.toUpperCase()) >= 0)
                return client
        })
        $('#client-search-result-number-insert').text(copy.length)
    } else
        $('#client-search-result-number-insert').text(0)
    console.log('result', copy)
    constructClientHtml(copy)
}

initSearchField()

getClients().then(function (resolve) {
    clients = resolve
    constructClientHtml(clients)
})
