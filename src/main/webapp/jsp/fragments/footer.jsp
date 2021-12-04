<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!-- Navbar -->
<nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
    <div class="container">
        <a href="<s:url namespace="/" action="dashboard" />" class="navbar-brand">
            <img src="${pageContext.request.contextPath}/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
                 style="opacity: .8">
            <span class="brand-text font-weight-light">GreenFIELD</span>
        </a>
        
        <button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse order-3" id="navbarCollapse">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a href="<s:url namespace="/" action="dashboard"  />" class="nav-link active">Accueil</a>
                </li>
                <li class="nav-item">
                    <a href="<s:url namespace="/" action="client"  />" class="nav-link">Client</a>
                </li>
                <li class="nav-item">
                    <a href="<s:url namespace="/" action="terrain"  />" class="nav-link">Terrain</a>
                </li>
                <li class="nav-item">
                    <a href="<s:url namespace="/vente"  />" class="nav-link">Vente</a>
                </li>
            </ul>
            
            <!-- Right navbar links -->
            <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
                <li class="nav-item dropdown user-menu">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <img src="<s:property value="%{#session.photo}" />" class="user-image img-circle elevation-2" alt="Utilisateur Image">
                        <span class="d-none d-md-inline"><s:property value="%{#session.photo}"/></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                        <!-- Utilisateur image -->
                        <li class="user-header bg-lightblue">
                            <img src="<s:property value="%{#session.photo}" />" class="img-circle elevation-2" alt="Utilisateur Image">
                            <p>
                                <s:property value="%{#session.photo}"/> + ' - ' + <s:property value="%{#session.email}"/>
                            </p>
                        </li>
                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <!--							<a href="#" class="btn btn-default btn-flat">Profile</a>-->
                            <button type="button" class="btn btn-default btn-flat float-right" onclick="disconnection(this)">Déconnexion</button>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- /.navbar -->
