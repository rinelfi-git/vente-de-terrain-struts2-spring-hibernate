<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="back" value="'http://localhost/vente_de_terrain/users'"/>
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
                    <a href="<s:url namespace="/" action="dashboard"  />" class="nav-link <s:if test="%{namespace == 'dashboard'}">active</s:if>">Accueil</a>
                </li>
                <li class="nav-item">
                    <a href="<s:url namespace="/" action="client"  />" class="nav-link <s:if test="%{namespace == 'client'}">active</s:if>">Client</a>
                </li>
                <li class="nav-item">
                    <a href="<s:url namespace="/" action="terrain"  />" class="nav-link <s:if test="%{namespace == 'terrain'}">active</s:if>">Terrain</a>
                </li>
                <li class="nav-item">
                    <a href="<s:url namespace="/" action="vente"  />" class="nav-link <s:if test="%{namespace == 'vente'}">active</s:if>">Vente</a>
                </li>
            </ul>
            
            <!-- Right navbar links -->
            <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
                <li class="nav-item dropdown user-menu">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        <img src="${back}/${session.photo}" class="user-image img-circle elevation-2" alt="profile">
                        <span class="d-none d-md-inline">${session.username}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                        <!-- Utilisateur image -->
                        <li class="user-header bg-lightblue">
                            <img src="${back}/${session.photo}" class="img-circle elevation-2" alt="profile" style="background: #0069d9;">
                            <p>
                                ${session.username} - ${session.email}
                            </p>
                        </li>
                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <!--<a href="#" class="btn btn-default btn-flat">Profile</a>-->
                            <button type="button" class="btn btn-default btn-flat float-right" onclick="disconnection(this)">Déconnexion</button>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<script>
	function disconnection(element) {
		if (confirm('Veuillez confirmer la mise en arrêt de la session')) {
			document.location.href = BASE_URL + 'logout.action'
		}
	}
</script>
<!-- /.navbar -->
