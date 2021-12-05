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
    <title>Client</title>
    <s:include value="fragments/links.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/client.css">
    <s:include value="fragments/scripts.jsp"/>
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
                <div class="row">
                    <s:iterator value="clients" var="client">
                        <s:include value="client/card.jsp">
                            <s:param name="client" value="#client"/>
                            <s:param name="host">${profileHost}</s:param>
                        </s:include>
                    </s:iterator>
                    <!-- /.row -->
                </div><!-- /.container-fluid -->
                
                <!--			pagination-->
                <div class="row">
                    <div class="col-12">
                        <ul class="pagination float-right">
                            <li>
                                <button class="page-link"><span class="material-icons md-18">first_page</span></button>
                            </li>
                            <li>
                                <button class="page-link"><span class="material-icons md-18">chevron_left</span></button>
                            </li>
                            <li>
                                <button class="page-link">1</button>
                            </li>
                            <li>
                                <button class="page-link"><span class="material-icons md-18">chevron_right</span></button>
                            </li>
                            <li>
                                <button class="page-link"><span class="material-icons md-18">last_page</span></button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /.content -->
        </div>
    </div>
</div>
<script>
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
	})
</script>
</body>
</html>
