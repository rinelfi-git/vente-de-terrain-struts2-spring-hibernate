<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 05/12/2021
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="terrain" value="#param.terrain" scope="page"/>
<s:set var="apercues" value="#terrain.apercues" scope="page"/>
<div class="w-100 col-12 col-sm-12 col-md-6 col-lg-4 d-flex align-items-stretch">
    <div class="card bg-white card-lightblue card-outline w-100">
        <div class="card-body">
            <s:if test="%{#apercues == null || apercues.size() <= 1}">
                <div class="row">
                    <div class="col-12">
                        <s:if test="%{#apercues != null && apercues.size() == 1}">
                            <div style="background-image: url(${param.host}/${apercues(0)}); height: 175px; background-position: center; background-size: cover"></div>
                        </s:if>
                        <s:else>
                            <div style="background-image: url(${param.host}/${param.field}); height: 175px; background-position: center; background-size: cover"></div>
                        </s:else>
                    </div>
                </div>
            </s:if>
            <s:else>
                <div id="carousel-indicator${param.index}" class="carousel slide" data-ride="carousel" data-interval="false">
                    <ol class="carousel-indicators">
                        <s:iterator value="apercues" var="apercue" status="status">
                            <li data-target="#carousel-indicator${param.index}" data-slide-to="${status.index}" class="<s:if test="%{#status.index == 0}">active</s:if>"></li>
                        </s:iterator>
                    </ol>
                    <div class="carousel-inner">
                        <s:iterator value="apercues" var="apercue" status="status">
                            <div class="carousel-item <s:if test="%{#status.index == 0}">active</s:if>">
                                <div class="d-block w-100" style="background-image: url(${param.host}/${apercue}); height: 175px; background-position: center; background-size: cover"></div>
                            </div>
                        </s:iterator>
                    </div>
                    <a class="carousel-control-prev" href="#carousel-indicator${param.index}" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carousel-indicator${param.index}" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </s:else>
            <button class="btn btn-outline-dark btn-flat" data-toggle="modal" data-target="#modifier-apercu${param.index}"><span class="material-icons">insert_photo</span> Changer les aperçues</button>
            <table class="w-100">
                <tr>
                    <td><small><strong>Localisation</strong></small></td>
                    <td><small>${terrain.localisation}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Propriétaire</strong></small></td>
                    <td><small>${terrain.proprietaire.nom} ${terrain.proprietaire.prenom}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Surface (m²)</strong></small></td>
                    <td class="text-right"><small>${terrain.surface}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Prix par m² (Ar)</strong></small></td>
                    <td class="text-right"><small>${terrain.prixParMetreCarre}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Relief</strong></small></td>
                    <td><small>${terrain.relief}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Status</strong></small></td>
                    <td><small><s:if test="%{#terrain.enVente}">en vente</s:if><s:else>pas en vente</s:else></small></td>
                </tr>
            </table>
        </div>
        <div class="card-footer">
            <div class="text-left">
                <div class="input-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        action
                    </button>
                    <div class="dropdown-menu">
                        <a href="!#" class="dropdown-item" data-toggle="modal" data-target="#modification-modal${param.index}"><span class="material-icons">update</span> modifier</a>
                        <div class="dropdown-divider"></div>
                        <a href="!#" class="dropdown-item"><span class="material-icons">delete_forever</span> supprimer</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
