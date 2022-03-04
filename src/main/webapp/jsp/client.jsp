<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Client</title>
    <s:include value="fragments/links.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/client.css">
    <s:include value="fragments/scripts.jsp"/>
    <script src="${pageContext.request.contextPath}/js/pagination-template.js"></script>
</head>
<body class="layout-top-nav">
<div class="wrapper">
    <%--    top nav--%>
    <s:include value="fragments/navs.jsp"/>
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark"><b><small>Gestion du client</small></b></h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <div class="float-sm-right">
                            <button class="btn btn-outline-primary" data-toggle="modal" data-target="#insert-modal"><span class="material-icons">add</span> Nouveau</button>
                        </div>
                    </div>
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        
        <s:include value="client/search-criterias.jsp"/>
        <s:include value="client/insert.jsp"/>
        
        <div class="content">
            <div class="container">
                <div class="row" id="client-card-view">
                    
                    <!-- /.row -->
                </div><!-- /.container-fluid -->
                
                <!--			pagination-->
                <div class="row">
                    <div class="col-12">
                        <ul class="pagination float-right" id="client-pagination">
                            
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /.content -->
        </div>
    </div>
</div>
<script>
	var paginationCurrentPage = 1
	var paginationElementPerPage = 12
	var pageLength = 1
	
	function clientCardTemplate(id, nom, prenom, cin, adresse, telephones, photo) {
		var telephoneHtml = ''
		for(telephone of telephones) {
			telephoneHtml += '<span> <b>-</b> ' + telephone + '<br></span>'
		}
		var clientCardTemplate = '<div class="w-100 col-12 col-md-6 col-lg-4 d-flex align-items-stretch">'
		clientCardTemplate+= '<div class="card bg-white card-lightblue card-outline w-100">'
		clientCardTemplate+='<div class="card-body box-profile">'
		clientCardTemplate+='<div class="row">'
		clientCardTemplate+='<div class="col-8">'
		clientCardTemplate+='<h2 class="lead"><b>' + nom + (prenom != null ? ' ' +  prenom : '') + '</b></h2>'
		clientCardTemplate+='<ul class="ml-4 mb-0 fa-ul text-muted">'
		clientCardTemplate+= '<li class="small"><span class="fa-li"><span class="material-icons">contacts</span></span><b>CIN</b>:<br>' + cin + '</li>'
		clientCardTemplate+= typeof adresse !== 'undefined' ? '<li class="small"><span class="fa-li"><span class="material-icons">place</span></span><b>Adresse</b>:<br>' + adresse.lot + ' - ' + adresse.codePostal + ' ' + adresse.ville + '</li>': ''
		clientCardTemplate+= telephones.length > 0 ? '<li class="small"><span class="fa-li"><span class="material-icons">phone</span></span><b>Téléphone</b>:<br>'+ telephoneHtml +'</li>' : ''
		clientCardTemplate+='</ul>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='<div class="col-4 text-center">'
		clientCardTemplate+='<img src="' + profileUrl(photo) + '" alt="' + nom + '" class="img-circle img-fluid" style="background: #0069d9;">'
		clientCardTemplate+='<div class="custom-class-image-edit-overlay custom-class-image-edit-overlay-background"></div>'
		clientCardTemplate+='<i class="fa fa-camera fa-2x text-white custom-class-icon-edit-overlay"></i>'
		clientCardTemplate+='<div class="custom-class-image-edit-overlay custom-class-image-edit-overlay-foreground" data-toggle="modal" data-target="#modification-photo" (click)="initialiserFormulairePhoto(' + id + ')"></div>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='<div class="card-footer">'
		clientCardTemplate+='<div class="text-left">'
		clientCardTemplate+='<div class="input-group">'
		clientCardTemplate+='<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">action</button>'
		clientCardTemplate+='<div class="dropdown-menu">'
		clientCardTemplate+='<a href="!#" class="dropdown-item" data-toggle="modal" data-target="#modification-modal" onclick="initialiserModifier(' + id + ')"><span class="material-icons">update</span> modifier</a>'
		clientCardTemplate+='<div class="dropdown-divider"></div>'
		clientCardTemplate+='<a href="!#" class="dropdown-item"><span class="material-icons">delete_forever</span> supprimer</a>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='</div>'
		clientCardTemplate+='</div>'
        return clientCardTemplate
	}
	
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
			success: function(response) {
				clientsHtml = ''
				for(client of response) {
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
			success: function(response) {
				pageLength = Math.ceil(response / paginationElementPerPage)
				$('#client-pagination').html(paginationTemplate(1, pageLength, paginationCurrentPage))
			}
		})
	}
	
	
	
	$(() => {
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
</script>
</body>
</html>
