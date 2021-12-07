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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/client.css">
    <s:include value="fragments/scripts.jsp"/>
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
        <s:include value="terrain/insert.jsp"/>
        
        <!-- Main content -->
        <div class="content">
            <div class="container">
                <!-- /.row -->
                <div class="row">
                    <s:iterator value="terrains" status="status" var="terrain">
                        <s:include value="terrain/card.jsp">
                            <s:param name="terrain" value="#terrain"/>
                            <s:param name="host">${fileHost}</s:param>
                            <s:param name="index">${status.index}</s:param>
                            <s:param name="field">${defaultThumbnail}</s:param>
                        </s:include>
                    </s:iterator>
                </div><!-- /.container-fluid -->
                
                <!--			pagination-->
                <div class="row">
                    <div class="col-12">
                        <ul class="pagination float-right">
                            <li [ngClass]="{'page-item': true, 'disabled': 1 == paginationHelper.getPageCourante()}" (click)="naviguerPage(1)">
                                <button class="page-link"><span class="material-icons md-18">first_page</span></button>
                            </li>
                            <li [ngClass]="{'page-item': true, 'disabled': 1 == paginationHelper.getPageCourante()}" (click)="naviguerArriere(paginationHelper.getPageCourante())">
                                <button class="page-link"><span class="material-icons md-18">chevron_left</span></button>
                            </li>
                            <li [ngClass]="{'page-item': true, 'active': page == paginationHelper.getPageCourante()}" *ngFor="let page of boutonPages" (click)="naviguerPage(page)">
                                <button class="page-link">{{page}}</button>
                            </li>
                            <li [ngClass]="{'page-item': true, 'disabled': paginationHelper.getPageTotal() == paginationHelper.getPageCourante()}" (click)="naviguerAvant(paginationHelper.getPageCourante())">
                                <button class="page-link"><span class="material-icons md-18">chevron_right</span></button>
                            </li>
                            <li [ngClass]="{'page-item': true, 'disabled': paginationHelper.getPageTotal() == paginationHelper.getPageCourante()}" (click)="naviguerPage(paginationHelper.getPageTotal())">
                                <button class="page-link"><span class="material-icons md-18">last_page</span></button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
    </div>
    <div class="modal fade" id="element-par-page">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>Element par page</h4>
                </div>
                <div class="modal-body">
                    <div class="form-check"><label for="element6"><input type="radio" name="elementParPage" id="element6"> 6</label></div>
                    <div class="form-check"><label for="element12"><input type="radio" name="elementParPage" id="element12"> 12</label></div>
                    <div class="form-check"><label for="element18"><input type="radio" name="elementParPage" id="element18"> 18</label></div>
                    <div class="form-check"><label for="element24"><input type="radio" name="elementParPage" id="element24"> 24</label></div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <label class="input-group-text" for="customElement"><input type="radio" name="elementParPage" id="customElement"></label>
                            </div>
                            <input type="number" class="form-control" name="elementParPage" placeholder="nombre d'éléments">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default">appliquer</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="module-recherche">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>Modules à rechercher</h4>
                </div>
                <div class="modal-body">
                
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default">appliquer</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="tri">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>Tri d'affichage</h4>
                </div>
                <div class="modal-body">
                    <div class="form-check"><label for="atoz"><input type="radio" name="sortDirection" id="atoz"> A - Z</label></div>
                    <div class="form-check"><label for="ztoa"><input type="radio" name="sortDirection" id="ztoa"> Z - A</label></div>
                    <hr>
                    <div class="form-check"><label for="nameSort"><input type="radio" name="sortConstraint" id="nameSort"> nom et prénom</label></div>
                    <div class="form-check"><label for="cinSort"><input type="radio" name="sortConstraint" id="cinSort"> cin</label></div>
                    <div class="form-check"><label for="addressSort"><input type="radio" name="sortConstraint" id="addressSort"> adresse</label></div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default">appliquer</button>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>
