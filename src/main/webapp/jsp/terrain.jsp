<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Terrain</title>
    <s:include value="fragments/links.jsp"/>
    <s:include value="fragments/scripts.jsp"/>
    <script src="${pageContext.request.contextPath}/js/terrain/card-template.js"></script>
</head>
<body class="layout-top-nav">
<div class="wrapper">
    <%--top nav--%>
    <s:include value="fragments/navs.jsp"/>
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
        <s:include value="terrain/insert.jsp" />
        <s:include value="terrain/thumbnail.jsp"/>
        
        <!-- Main content -->
        <div class="content">
            <div class="container">
                <!-- /.row -->
                <div class="row" id="terrain-cards">
                </div><!-- /.container-fluid -->
                
                <!--			pagination-->
                <div class="row">
                    <div class="col-12" id="terrain-cards-pagination">
                    </div>
                </div>
            </div>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
    </div>
</div>
<script type="text/javascript">
    var currentpage = 1
	var elementperpage = 12
	var pagelength = 1

    function getDataFromService() {
		var keyword = $('[name=keyword]').val()
		$.ajax({
			method: 'post',
			url: baseUrl('terrain/pagination.action'),
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
				let terrainCardHtml = ''
				for(terrain of response) {
					terrainCardHtml += terrainCardTemplate(terrain)
				}
				$('#terrain-cards').html(terrainCardHtml)
				getPagesList()
			}
		})
		return false
	}
</script>
</body>
</html>
