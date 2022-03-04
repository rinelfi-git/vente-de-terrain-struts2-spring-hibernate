var paginationCurrentPage = 1
var paginationElementPerPage = 12
var pageLength = 1

function getDataFromService() {
    var keyword = $('[name=keyword]').val()
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
            clientsHtml = ''
            for (client of response) {
                clientsHtml += clientCardTemplate(client.id, client.nom, client.prenom, client.cin, client.adresse, client.telephones, client.photo)
            }
            $('#client-card-view').html(clientsHtml)
            getPagesList()
        }
    })
    return false
}

function navigatePaginationTo(target) {
    var min = Math.min(target, pageLength), max = Math.max(1, target)
    paginationCurrentPage = min == pageLength ? min : max
    getDataFromService()
}

function getPagesList() {
    var keyword = $('[name=keyword]').val()
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
            pageLength = Math.ceil(response / paginationElementPerPage)
            $('#client-pagination').html(paginationTemplate(1, pageLength, paginationCurrentPage))
        }
    })
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
            left: (7 + $(e.currentTarget).width() / 2 - icon.width() / 2) + 'px',
        });
        icon.fadeIn(animationDuration);
        background.addClass('overlay-active');
        $(e.currentTarget).on('mouseout', e => {
            var icon = $(e.currentTarget).prev('.fa');
            var background = icon.prev('.custom-class-image-edit-overlay-background');
            icon.stop();
            icon.fadeOut(animationDuration);
            background.removeClass('overlay-active');
        })
    })

    $(document).on('mouseover', '.custom-class-image-edit-overlay-foreground', e => {
        var icon = $(e.currentTarget).prev('.fa');
        var background = icon.prev('.custom-class-image-edit-overlay-background');
        var animationDuration = 200;
        icon.stop();
        background.stop();
        icon.css({
            position: 'absolute',
            top: ($(e.currentTarget).height() / 2 - icon.height() / 2) + 'px',
            left: (7 + $(e.currentTarget).width() / 2 - icon.width() / 2) + 'px',
        });
        icon.fadeIn(animationDuration);
        background.addClass('overlay-active');
        $(e.currentTarget).on('mouseout', e => {
            var icon = $(e.currentTarget).prev('.fa');
            var background = icon.prev('.custom-class-image-edit-overlay-background');
            icon.stop();
            icon.fadeOut(animationDuration);
            background.removeClass('overlay-active');
        })
    })
    getDataFromService()
})
