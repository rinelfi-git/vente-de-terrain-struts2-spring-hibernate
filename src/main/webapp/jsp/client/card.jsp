<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="client" value="#param.client" scope="page"/>
<s:set var="adresse" value="#client.adresse" scope="page"/>
<s:set var="telephones" value="#client.telephones" scope="page"/>
<div class="w-100 col-12 col-md-6 col-lg-4 d-flex align-items-stretch">
    <div class="card bg-white card-lightblue card-outline w-100">
        <div class="card-body box-profile">
            <div class="row">
                <div class="col-8">
                    <h2 class="lead"><b>${client.nom} ${client.prenom}</b></h2>
                    <ul class="ml-4 mb-0 fa-ul text-muted">
                        <li class="small"><span class="fa-li"><span class="material-icons">contacts</span></span><b>CIN</b>:<br>${client.cin}</li>
                        <s:if test="%{adresse != null}">
                            <li class="small"><span class="fa-li">
                            <span class="material-icons">place</span>
                        </span><b>Adresse</b>:<br>${adresse.lot} - ${adresse.codePostal} ${adresse.ville}</li>
                        </s:if>
                        <s:if test="%{!telephones.isEmpty > 0}">
                            <li class="small">
                                <span class="fa-li"><span class="material-icons">phone</span></span><b>Téléphone</b>:<br>
                                <s:iterator value="telephones">
                                    <span> <b>-</b> <s:property/><br></span>
                                </s:iterator>
                            </li>
                        </s:if>
                    </ul>
                </div>
                <div class="col-4 text-center">
                    <img src="${param.host}/${client.photo}" alt="" class="img-circle img-fluid" style="background: #0069d9;">
                    <div class="custom-class-image-edit-overlay custom-class-image-edit-overlay-background"></div>
                    <i class="fa fa-camera fa-2x text-white custom-class-icon-edit-overlay"></i>
                    <div class="custom-class-image-edit-overlay custom-class-image-edit-overlay-foreground" data-toggle="modal" data-target="#modification-photo" [attr.data-content]="client.getId()" (click)="initialiserFormulairePhoto()"></div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <div class="text-left">
                <div class="input-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        action
                    </button>
                    <div class="dropdown-menu">
                        <a href="!#" class="dropdown-item" data-toggle="modal" data-target="#modification-modal" (click)="initialiserModifier()"><span class="material-icons">update</span> modifier</a>
                        <div class="dropdown-divider"></div>
                        <a href="!#" class="dropdown-item"
                           [swal]="{title: 'Confirmer la suppression', html: 'Vous êtes sur le point de supprimer le client <b>' + client.getNom() + ' ' + client.getPrenom() + '\</b> portant le CIN: <b>' + client.getCin() + '</b><br>Tous les terrains ainsi que le registre de vente concernant ce client vont être aussi supprimé sur le champ.', icon: 'warning', showCancelButton: true, cancelButtonText: 'Annuler', confirmButtonText: 'Supprimer'}"
                           (confirm)="supprimer()"><span class="material-icons">delete_forever</span> supprimer</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
