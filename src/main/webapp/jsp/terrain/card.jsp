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
            <s:if test="%{!apercues.isEmpty}">
                <div class="row" *ngIf="terrain.getApercues().length <= 1">
                    <div class="col-12">
                        <div style="backgroundImage: url(${param.host}' + (states.terrainHost + terrain.getApercues()[0]) + ')', height: '175px', backgroundPosition: 'center', backgroundSize: 'cover'}" *ngIf="terrain.getApercues().length == 1"></div>
                        <div [style]="{backgroundImage: 'url(' + states.defaultPreview + ')', height: '175px', backgroundPosition: 'center', backgroundSize: 'cover'}" *ngIf="terrain.getApercues().length == 0"></div>
                    </div>
                </div>
            </s:if>
            <div *ngIf="terrain.getApercues().length > 1" id="carousel-indicator{{componentIndex}}" class="carousel slide" data-ride="carousel" data-interval="false">
                <ol class="carousel-indicators">
                    <li *ngFor="let apercue of terrain.getApercues(); let j = index" [attr.data-target]="'#carousel-indicator' + componentIndex" [attr.data-slide-to]="j" [ngClass]="{active: j === 0}"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item" [ngClass]="{'carousel-item': true, 'active': j === 0}" *ngFor="let apercue of terrain.getApercues(); let j = index">
                        <div class="d-block w-100" [style]="{backgroundImage: 'url(' + (states.terrainHost + apercue) + ')', height: '175px', backgroundPosition: 'center', backgroundSize: 'cover'}"></div>
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carousel-indicator{{componentIndex}}" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carousel-indicator{{componentIndex}}" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <button class="btn btn-outline-dark btn-flat" data-toggle="modal" [attr.data-target]="'#modifier-apercu' + componentIndex" (click)="initUploadForm()"><span class="material-icons">insert_photo</span> Changer les aperçues</button>
            <table class="w-100">
                <tr>
                    <td><small><strong>Localisation</strong></small></td>
                    <td><small>{{terrain.getLocalisation()}}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Propriétaire</strong></small></td>
                    <td><small>{{terrain.getProprietaire().getNom()}} {{terrain.getProprietaire().getPrenom()}}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Surface (m²)</strong></small></td>
                    <td class="text-right"><small>{{terrain.getSurface() && terrain.getSurface().toLocaleString('fr-fr', {maximumFractionDigits: 2})}}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Prix par m² (Ar)</strong></small></td>
                    <td class="text-right"><small>{{terrain.getPrixParMetreCarre() && terrain.getPrixParMetreCarre().toLocaleString('fr-fr', {maximumFractionDigits: 2})}}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Relief</strong></small></td>
                    <td><small>{{terrain.getRelief()}}</small></td>
                </tr>
                <tr>
                    <td><small><strong>Status</strong></small></td>
                    <td><small>{{terrain.isEnVente() ? 'en vente' : 'pas en vente'}}</small></td>
                </tr>
            </table>
        </div>
        <div class="card-footer">
            <app-terrain-update [componentIndex]="componentIndex" [terrain]="updateTerrain" [clients]="updateClients" [clientsView]="updateClientsView" [updateForm]="updateForm" [clientSearchActive]="updateSearchClientActive" (updateDone)="updateAction($event)"></app-terrain-update>
            <app-terrain-preview [componentIndex]="componentIndex" [states]="childStates" [backgrounds]="updateBackgrounds" [temporaries]="updateTemporaries" [forTrash]="updateForTrash" (uploadDone)="uploadPhotoAction($event)"></app-terrain-preview>
            <div class="text-left">
                <div class="input-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" (click)="initUpdateForm()">
                        action
                    </button>
                    <div class="dropdown-menu">
                        <a href="!#" class="dropdown-item" data-toggle="modal" [attr.data-target]="'#modification-modal' +  + componentIndex" (click)="initUpdateForm()"><span class="material-icons">update</span> modifier</a>
                        <div class="dropdown-divider"></div>
                        <a href="!#" class="dropdown-item"
                           [swal]="{title: 'Confirmer la suppression', html: 'Vous êtes sur le point de supprimer le terrain de <b>' + terrain.getProprietaire().getNom() + ' ' + terrain.getProprietaire().getPrenom() + '\</b> se trouvant à <b>' + terrain.getLocalisation() + '</b><br>Tout le registre de vente concernant ce terrain être aussi supprimé sur le champ.', icon: 'warning', showCancelButton: true, cancelButtonText: 'Annuler', confirmButtonText: 'Supprimer'}"
                           (confirm)="delete()"><span class="material-icons">delete_forever</span> supprimer</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
