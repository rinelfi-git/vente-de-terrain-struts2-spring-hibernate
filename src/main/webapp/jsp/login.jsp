<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 23/11/2021
  Time: 13:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Login</title>
    <base href="/">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fontawesome.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/icheck-bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/source-sans-pro.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminlte.min.css">
</head>
<body>
<div class="login-page">
    <div class="login-box">
        <div class="login-logo">
            <s:url namespace="/" action="login" var="home"/>
            <s:a href="%{#home}"><b>Green</b>FIELD</s:a>
        </div>
        <!-- /.login-logo -->
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">Sign in to start your session</p>
                
                <form method="post" autocomplete="off" id="login-form" action="<s:url namespace="/login" action="authentication"/>">
                    <div class="input-group mb-3">
                        <s:textfield name="username" cssClass="form-control" type="email" requiredLabel="" value="%{username}" placeholder="adresse mail"/>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <s:textfield name="password" cssClass="form-control" type="password" requiredLabel="" value="%{password}" placeholder="mot de passe"/>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="icheck-primary ml-2 mb-3">
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember">
                                Se souvenir de moi
                            </label>
                        </div>
                    </div>
                    <s:if test="%{message != null && message != ''}">
                        <p class="text text-center text-danger"><s:property value="%{message}"/></p>
                    </s:if>
                    <div class="row">
                        <button type="submit" class="btn btn-primary btn-block">Connexion</button>
                    </div>
                </form>
            </div>
            <!-- /.login-card-body -->
        </div>
    </div>
    <!-- /.login-box -->
</div>
</body>
</html>
