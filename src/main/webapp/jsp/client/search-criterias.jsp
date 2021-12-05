<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container mb-2">
    <div class="card">
        <div class="card-body">
            <!-- SEARCH FORM -->
            <form action="<s:url namespace="/client" action="search"/>">
                <div class="input-group input-group-lg">
                    <input class="form-control form-control-navbar" name="keyword" type="search" placeholder="Recherche" aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="btn-group mt-2">
                    <button type="button" class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#element-par-page" (click)="initPaginationForm()"><span class="material-icons">format_list_numbered</span></button>
                    <button type="button" class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#module-recherche"><span class="material-icons">view_module</span></button>
                    <button type="button" class="btn btn-default mr-2 mb-2" data-toggle="modal" data-target="#tri"><span class="material-icons">sort</span></button>
                </div>
            </form>
        </div>
    </div>
</div>
