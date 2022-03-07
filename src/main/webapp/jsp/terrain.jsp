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
        <s:include value="fragments/links.jsp"/>
        <link href='https://api.mapbox.com/mapbox-gl-js/v2.3.1/mapbox-gl.css' rel='stylesheet' />
        <s:include value="fragments/scripts.jsp"/>
        <script src='https://api.mapbox.com/mapbox-gl-js/v2.3.1/mapbox-gl.js'></script>
        <script src="${pageContext.request.contextPath}/js/terrain/main.js"></script>
        <script src="${pageContext.request.contextPath}/js/terrain/card-template.js"></script>
        <script src="${pageContext.request.contextPath}/js/terrain/form.js"></script>
        <script src="${pageContext.request.contextPath}/js/terrain/thumbnail.js"></script>
        <script src="${pageContext.request.contextPath}/js/terrain/insert.js"></script>
        <script src="${pageContext.request.contextPath}/js/pagination-template.js"></script>
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
                <s:include value="terrain/confirm-delete.jsp"/>
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
    </body>
</html>
