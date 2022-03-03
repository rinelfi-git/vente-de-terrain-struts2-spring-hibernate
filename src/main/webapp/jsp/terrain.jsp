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
    <title>Terrain</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://api.mapbox.com/mapbox-gl-js/v2.3.1/mapbox-gl.css' rel='stylesheet' />
    <s:include value="fragments/links.jsp"/>
    <s:include value="fragments/scripts.jsp"/>
    <script src="${pageContext.request.contextPath}/js/terrain/card-template.js"></script>
    <script src="${pageContext.request.contextPath}/js/pagination-template.js"></script>
    <script src='https://api.mapbox.com/mapbox-gl-js/v2.3.1/mapbox-gl.js'></script>
</head>
<body class="layout-top-nav">
<div class="wrapper">
    <%--top nav--%>
    <s:include value="fragments/navs.jsp"/>
    <s:include value="terrain/map.jsp"/>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark"><b><small>Gestion du terrain</small></b></h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <div class="float-sm-right">
                            <button class="btn btn-outline-primary" data-toggle="modal" data-target="#insert-modal"><span class="material-icons">add</span> Nouveau</button>
                        </div>
                    </div>
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <s:include value="terrain/search-criteria.jsp"/>
        <s:include value="terrain/insert.jsp"/>
        <s:include value="terrain/thumbnail.jsp"/>
        
        <!-- Main content -->
        <div class="content">
            <div class="container">
                <!-- /.row -->
                <div class="row" id="terrain-cards">
                </div><!-- /.container-fluid -->
                
                <!--			pagination-->
                <div class="row">
                    <div class="col-12">
                        <ul id="terrain-cards-pagination" class="pagination float-right"></ul>
                    </div>
                </div>
            </div>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
    </div>
</div>
<script type="text/javascript">
    mapboxgl.accessToken = 'pk.eyJ1IjoicmluZWxmaSIsImEiOiJjbDBhdXVteDQwM3JsM2tvN2NjMXEzdGM3In0.Fv-NkbIGRVB4RdBMO6pNGw'
	const map = new mapboxgl.Map({
		container: 'map-container',
		style: 'mapbox://styles/mapbox/outdoors-v11', // style URL,
		zoom: 4,
		center: [47.0908595, -21.4560529]
	})
	let currentPage = 1
	let elementPerPage = 12
	let pageLength = 1
	let selectedIdentity = 0
    
    function loadThumbnails(identity, apercues) {
	    selectedIdentity = identity
        thumbnails = apercues
		updateThumbnailView()
    }
	
	function navigatePaginationTo(target) {
		var min = Math.min(target, pageLength), max = Math.max(1, target)
		currentPage = min == pageLength ? min : max
		getDataFromService()
	}
	
	function getPagesList() {
		var keyword = $('[name=keyword]').val()
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
				pageLength = Math.ceil(response / elementPerPage)
				$('#terrain-cards-pagination').html(paginationTemplate(1, pageLength, currentPage))
			}
		})
	}
	
	function locateOnMap(longitude, latitude) {
		const mapLong = document.getElementById('map-long')
		const mapLat = document.getElementById('map-lat')
		const latlong = [typeof longitude === 'undefined' ? mapLong.value : longitude, typeof latitude === 'undefined' ? mapLat.value : latitude]
		mapLong.value = latlong[0]
		mapLat.value = latlong[1]
		$('#map').off('shown.bs.modal').on('shown.bs.modal', function() {
			map.resize()
			const marker = new mapboxgl.Marker().setLngLat(latlong).addTo(map)
			map.flyTo({
				center: latlong,
				zoom: 18
			})
		$('#map').off('hide.bs.modal').on('hidden.bs.modal', function() {
			marker.remove()
		})
		})
		if(!$('#map').is(':visible'))$('#map').modal('show')
		else {
			map.flyTo({
				center: latlong,
				zoom: 18
			})	
		}
    }
	
	function calcSelectionChanged(element) {
		map.setStyle(element.value)
	}
	
	function getDataFromService() {
		var keyword = $('[name=keyword]').val()
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
				let terrainCardHtml = ''
				for (let i = 0; i < response.length; i++) {
					terrainCardHtml += terrainCardTemplate(i, response[i])
				}
				$('#terrain-cards').html(terrainCardHtml)
				getPagesList()
			}
		})
		return false
	}
	
	$(document).ready(function () {
		map.addControl(new mapboxgl.NavigationControl())
		getDataFromService()
	})
</script>
</body>
</html>
