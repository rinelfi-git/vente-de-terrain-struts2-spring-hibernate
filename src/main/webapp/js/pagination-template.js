function paginationTemplate(start, end, current) {
    let paginationHtml = '<li class="page-item' + (current <= 1 ? ' disabled': '') + '">'
    paginationHtml+='<button class="page-link" onclick="navigatePaginationTo(1)"><span class="material-icons md-18">first_page</span></button>'
    paginationHtml+='</li>'
    paginationHtml+='<li class="page-item' + (current <= 1 ? ' disabled': '') + '">'
    paginationHtml+='<button class="page-link" onclick="navigatePaginationTo(' + (current - 1) + ')"><span class="material-icons md-18">chevron_left</span></button>'
    paginationHtml+='</li>'
    for(let i = start; i <= end; i++) {
        paginationHtml+='<li class="page-item ' + (i == current ? 'active' : '') + '">'
        paginationHtml+='<button class="page-link" onclick="navigatePaginationTo(' + i + ')">' + i + '</button>'
        paginationHtml+='</li>'
    }
    paginationHtml+='<li class="page-item' + (current >= end ? ' disabled': '') + '">'
    paginationHtml+='<button class="page-link" onclick="navigatePaginationTo(' + (current + 1) + ')"><span class="material-icons md-18">chevron_right</span></button>'
    paginationHtml+='</li>'
    paginationHtml+='<li class="page-item' + (current >= end ? ' disabled': '') + '">'
    paginationHtml+='<button class="page-link" onclick="navigatePaginationTo(' + end + ')"><span class="material-icons md-18">last_page</span></button>'
    paginationHtml+='</li>'
    return paginationHtml
}