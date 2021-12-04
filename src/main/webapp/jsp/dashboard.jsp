<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 23/11/2021
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Dashboard</title>
    <s:include value="fragments/links.jsp"></s:include>
</head>
<body class="layout-top-nav">
<div class="wrapper">
    <%--    top nav--%>
    <s:include value="fragments/header.jsp"></s:include>
    
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0 text-dark"><b><small>Tableau de bord</small></b></h1>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- Main content -->
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-12 col-sm-6 col-md-4">
                        <div class="info-box mb-3">
                            <span class="info-box-icon bg-lightblue elevation-1"><i class="fas fa-thumbs-up"></i></span>
                            
                            <div class="info-box-content">
                                <span class="info-box-text">Terrains</span>
                                <span class="info-box-number"></span>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->
                    </div>
                    <!-- /.col -->
                    
                    <!-- fix for small devices only -->
                    <div class="clearfix hidden-md-up"></div>
                    
                    <div class="col-12 col-sm-6 col-md-4">
                        <div class="info-box mb-3">
                            <span class="info-box-icon bg-lightblue elevation-1"><i class="fas fa-shopping-cart"></i></span>
                            
                            <div class="info-box-content">
                                <span class="info-box-text">Ventes</span>
                                <span class="info-box-number">{{recapitulation && recapitulation.totalVente}}</span>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->
                    </div>
                    <!-- /.col -->
                    <div class="col-12 col-sm-6 col-md-4">
                        <div class="info-box mb-3">
                            <span class="info-box-icon bg-lightblue elevation-1"><i class="fas fa-users"></i></span>
                            
                            <div class="info-box-content">
                                <span class="info-box-text">Clients</span>
                                <span class="info-box-number">{{recapitulation && recapitulation.totalClient}}</span>
                            </div>
                            <!-- /.info-box-content -->
                        </div>
                        <!-- /.info-box -->
                    </div>
                    <!-- /.col -->
                </div>
                <!--
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Chiffre d'affaires</h3>
                                
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="chart" style="height: 250px; min-width: 488px;width: 100%">
                                    <canvas baseChart
                                            [datasets]="barChartData"
                                            [labels]="barChartLabels"
                                            [options]="barChartOptions"
                                            [legend]="barChartLegend"
                                            [chartType]="barChartType">
                                    </canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                -->
                <div class="row">
                    <div class="col-md-6 col-sm-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Nouveau terrains ({{recapitulation.dernierTerrain.length}})</h3>
                                
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body p-0">
                                <ul class="products-list product-list-in-card pl-2 pr-2">
                                    <li class="item" *ngFor="let terrain of recapitulation.dernierTerrain">
                                        <div class="product-info">
										<span class="product-title">
											{{terrain[2]}}
											<span class="badge badge-info float-right">{{terrain[3].toLocaleString('fr', {maximumFractionDigits: 2})}} Ar</span><br>
											<span class="badge badge-info float-right">{{terrain[4].toLocaleString('fr', {maximumFractionDigits: 2})}} m²</span>
										</span>
                                            <span class="product-description">propritaire : {{terrain[0]}} {{terrain[1]}}</span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer text-center">
                                <a [routerLink]="['/', 'application', 'terrain']" class="uppercase">Tout voir</a>
                            </div>
                            <!-- /.card-footer -->
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Nouveau clients ({{recapitulation.dernierClient.length}})</h3>
                                
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i>
                                    </button>
                                    <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body p-0">
                                <ul class="users-list clearfix">
                                    <li *ngFor="let utilisateur of recapitulation.dernierClient">
                                        <img [src]="url + utilisateur[2]" alt="User Image">
                                        <span class="users-list-name">{{utilisateur[1] === '' ? utilisateur[0] : utilisateur[1]}}</span>
                                    </li>
                                </ul>
                                <!-- /.users-list -->
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer text-center">
                                <a [routerLink]="['/', 'application', 'client']" class="uppercase">Tout voir</a>
                            </div>
                            <!-- /.card-footer -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
    </div>
</div>
<s:include value="fragments/scripts.jsp"></s:include>
<script>
	function disconnection(element) {
		alert(element)
	}
</script>
</body>
</html>
