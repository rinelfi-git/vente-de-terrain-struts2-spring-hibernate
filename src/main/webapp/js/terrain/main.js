/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* global mapboxgl, toastr */

mapboxgl.accessToken = 'pk.eyJ1IjoicmluZWxmaSIsImEiOiJjbDBhdXVteDQwM3JsM2tvN2NjMXEzdGM3In0.Fv-NkbIGRVB4RdBMO6pNGw';
const formMap = {
    insert: new mapboxgl.Map({
        container: 'insert-map-selection',
        style: 'mapbox://styles/mapbox/outdoors-v11', // style URL,
        zoom: 4,
        center: [47.0908595, -21.4560529]
    })
};
const markerMap = {
    insert: new mapboxgl.Marker().setLngLat([47.0908595, -21.4560529]).addTo(formMap.insert)
};
const previewMap = new mapboxgl.Map({
    container: 'map-container',
    style: 'mapbox://styles/mapbox/outdoors-v11', // style URL,
    zoom: 4,
    center: [47.0908595, -21.4560529]
});
let currentPage = 1;
let elementPerPage = 12;
let pageLength = 1;
let selectedIdentity = 0;

toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": true,
    "progressBar": false,
    "positionClass": "toast-bottom-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "300",
    "timeOut": "2000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
};

function loadThumbnails(identity, apercues) {
    selectedIdentity = identity;
    thumbnails = apercues;
    updateThumbnailView();
}

function navigatePaginationTo(target) {
    var min = Math.min(target, pageLength), max = Math.max(1, target);
    currentPage = min === pageLength ? min : max;
    getDataFromService();
}

function updateCurrentLocation(scope) {
    navigator.geolocation.getCurrentPosition(function (position) {
        console.log('update', position.coords);
        document.getElementById('insert-longitude').value = position.coords.longitude;
        document.getElementById('insert-latitude').value = position.coords.latitude;
        markerMap[scope].remove();
        markerMap[scope] = new mapboxgl.Marker().setLngLat([position.coords.longitude, position.coords.latitude]).addTo(formMap.insert);
        formMap[scope].flyTo({
            zoom: 18,
            center: [position.coords.longitude, position.coords.latitude]
        });
    }, function (err) {
        toastr["error"]("Le navigateur ne permet pas le prélèvement de la localisation. Assurez vous que votre connexion est sécurisée et que vous avez permis la géolocalisation.<br>Détail : " + err.code + ": " + err.message, "Erreur de localisation");
    }, {
        enableHighAccuracy: true
    });
}

function getPagesList() {
    var keyword = $('[name=keyword]').val();
    $.ajax({
        method: 'post',
        url: baseUrl('terrain/records.action'),
        data: {
            pageCurrent: currentPage,
            elementPerPage: elementPerPage,
            paginationSearchActivated: keyword.length > 0,
            paginationSearchKeyword: keyword,
            paginationSearchField: $('[name=search-field]').filter(':checked').val()
        },
        dataType: 'json',
        success: function (response) {
            pageLength = Math.ceil(response / elementPerPage);
            $('#terrain-cards-pagination').html(paginationTemplate(1, pageLength, currentPage));
        }
    });
}

function locateOnMap(latitude, longitude) {
    const mapLong = document.getElementById('map-long');
    const mapLat = document.getElementById('map-lat');
    const latlong = [typeof longitude === 'undefined' ? mapLong.value : longitude, typeof latitude === 'undefined' ? mapLat.value : latitude];
    mapLong.value = latlong[0];
    mapLat.value = latlong[1];
    $('#map').off('shown.bs.modal').on('shown.bs.modal', function () {
        previewMap.resize();
        const marker = new mapboxgl.Marker().setLngLat(latlong).addTo(previewMap);
        previewMap.flyTo({
            center: latlong,
            zoom: 18
        });
        $('#map').off('hide.bs.modal').on('hidden.bs.modal', function () {
            marker.remove();
        });
    });
    if (!$('#map').is(':visible'))
        $('#map').modal('show');
    else {
        previewMap.flyTo({
            center: latlong,
            zoom: 18
        });
    }
}

function calcSelectionChanged(element) {
    previewMap.setStyle(element.value);
}

function getDataFromService() {
    var keyword = $('[name=keyword]').val();
    $.ajax({
        method: 'post',
        url: baseUrl('terrain/pagination.action'),
        data: {
            pageCurrent: currentPage,
            elementPerPage: elementPerPage,
            paginationSearchActivated: keyword.length > 0,
            paginationSearchKeyword: keyword,
            paginationSearchField: $('[name=search-field]').filter(':checked').val(),
            paginationOrdered: true,
            orderDirection: $('[name=sort-order]').filter(':checked').val(),
            paginationFieldOrder: $('[name=sort-field]').filter(':checked').val()
        },
        dataType: 'json',
        success: function (response) {
            let terrainCardHtml = '';
            for (let i = 0; i < response.length; i++) {
                terrainCardHtml += terrainCardTemplate(i, response[i]);
            }
            $('#terrain-cards').html(terrainCardHtml);
            getPagesList();
        }
    });
    return false;
}

function promptDelete(id, adresse) {
    identity = id;
    $('#confirm-delete-adresse').text(adresse);
    $('#confirm-delete').modal('show');
}

function deleteTerrain() {
    $.ajax({
        url: baseUrl('terrain/delete.action'),
        method: 'post',
        dataType: 'json',
        data: {identity},
        success: function () {
            $('#confirm-delete').modal('hide');
            getDataFromService();
            toastr["success"]("Le terrain est supprimé avec succès", "Suppression");
        },
        error: function () {
            alert('error');
        }
    });
}

$(document).ready(function () {
    previewMap.addControl(new mapboxgl.NavigationControl());
    getDataFromService();

    ['insert'].forEach(function (scope) {
        $('#' + scope + '-modal').on('shown.bs.modal', function () {
            formMap[scope].resize();
        });
        formMap[scope].on('click', function (event) {
            $('#' + scope + '-longitude').val(event.lngLat.lng);
            $('#' + scope + '-latitude').val(event.lngLat.lat);
            $('#' + scope + '-coordinates').find('input[type=number]').trigger('input');
        });
    });
});