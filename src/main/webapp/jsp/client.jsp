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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/2.0.0-alpha.2/cropper.min.css" integrity="sha512-6QxSiaKfNSQmmqwqpTNyhHErr+Bbm8u8HHSiinMEz0uimy9nu7lc/2NaXJiUJj2y4BApd5vgDjSHyLzC8nP6Ng==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/client/client.css">
        <s:include value="fragments/scripts.jsp"/>
        <script src="${pageContext.request.contextPath}/js/pagination-template.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/2.0.0-alpha.2/cropper.min.js" integrity="sha512-IlZV3863HqEgMeFLVllRjbNOoh8uVj0kgx0aYxgt4rdBABTZCl/h5MfshHD9BrnVs6Rs9yNN7kUQpzhcLkNmHw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="${pageContext.request.contextPath}/js/client/main.js"></script>
        <script src="${pageContext.request.contextPath}/js/client/card-template.js"></script>
        <script src="${pageContext.request.contextPath}/js/client/phone-form-template.js"></script>
        <script src="${pageContext.request.contextPath}/js/client/image-upload.js"></script>
        <script src="${pageContext.request.contextPath}/js/client/insert.js"></script>
        <script src="${pageContext.request.contextPath}/js/client/update.js"></script>
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
                <s:include value="client/update.jsp"/>
                <s:include value="client/confirm-delete.jsp"/>
                <s:include value="client/profile-image-update.jsp"/>

                <div class="content">
                    <div class="container">
                        <div class="row" id="client-card-view">
                            <!-- /.row -->
                        </div><!-- /.container-fluid -->
                        <!--			pagination-->
                        <div class="row">
                            <div class="col-12">
                                <ul class="pagination float-right" id="client-pagination"></ul>
                            </div>
                        </div>
                    </div>
                    <!-- /.content -->
                </div>
            </div>
        </div>
    </body>
</html>
