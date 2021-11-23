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
            <s:a href="login.action"><b>Green</b>FIELD</s:a>
        </div>
        <!-- /.login-logo -->
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">Sign in to start your session</p>
                
                <form method="post" autocomplete="off" id="login-form">
                    <div class="input-group mb-3">
                        <input type="email" class="form-control" placeholder="Nom d'utilisateur ou email" id="username">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" placeholder="Mot de passe" id="password">
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
                        <p class="text text-center text-danger">${message}</p>
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
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/global.js"></script>
<script>
  $(() => {
	  document.getElementById('login-form').addEventListener('submit', event => {
		  event.preventDefault()
		  $.ajax({
			  url: `${BASE_URL}/login/authentication`,
			  method: 'post',
			  data: {username: document.getElementById('username').value, password: document.getElementById('password').value},
			  success: data => {
				  console.log('executed')
			  },
			  error: (err1, err2, err3) => {
				  console.log(err1, err2, err3)
			  }
		  })
	  })
  })
</script>
</body>
</html>
