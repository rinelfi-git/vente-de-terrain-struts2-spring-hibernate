<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 23/11/2021
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Dashboard</title>
    <s:include value="fragments/links.jsp"/>
    <s:include value="fragments/scripts.jsp"/>
</head>
<body class="layout-top-nav">
<div class="wrapper">
    <%--    top nav--%>
    <s:include value="fragments/navs.jsp"/>
    
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
                                <span class="info-box-number">1</span>
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
                                <span class="info-box-number">10</span>
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
                                <span class="info-box-number">10</span>
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
                                <h3 class="card-title">Nouveau terrains (8)</h3>
                                
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
                                    <li class="item" >
                                        <div class="product-info">
										<span class="product-title">
											Terrain
											<span class="badge badge-info float-right">10 000 000 Ar</span><br>
											<span class="badge badge-info float-right">15.12 m²</span>
										</span>
                                            <span class="product-description">propritaire : Elie Rijaniaina</span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer text-center">
                                <a href="#!" class="uppercase">Tout voir</a>
                            </div>
                            <!-- /.card-footer -->
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Nouveau clients (5)</h3>
                                
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
                                    <li>
                                        <img alt="Rijaniaina">
                                        <span class="users-list-name">Elie Rijaniaina</span>
                                    </li>
                                </ul>
                                <!-- /.users-list -->
                            </div>
                            <!-- /.card-body -->
                            <div class="card-footer text-center">
                                <a href="#!" class="uppercase">Tout voir</a>
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
</body>
</html>
