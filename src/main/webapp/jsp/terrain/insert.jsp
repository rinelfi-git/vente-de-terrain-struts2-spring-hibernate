<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 07/12/2021
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #insert-map-selection {
        height: 200px;
        display: none;
    }

    #insert-coordinates {
        display: none;
    }
</style>
<div class="modal fade" id="insert-modal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Nouveau Terrain</h4>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form autocomplete="off" onsubmit="return submit('insert')">
                    <input type="submit" value="" hidden="hidden">
                    <div class="form-group">
                        <label for="insert-adresse">Adresse: <span
                                class="text-danger">*</span></label>
                        <textarea class="form-control" id="insert-adresse" name="adresse" maxlength="255" required></textarea>
                        <small class="form-text text-danger" id="insert-adresse-error"></small>
                    </div>
                    <div class="row">
                        <div class="icheck-primary ml-2 mb-3">
                            <input type="checkbox" id="insert-point-geographique" name="point-geographique" onchange="switchGeolocationMode(this, 'insert')">
                            <label for="insert-point-geographique">
                                Coordonnées géographiques
                            </label>
                        </div>
                    </div>
                    <div class="input-group mb-2" id="insert-coordinates">
                        <input type="number" id="insert-longitude" class="form-control" placeholder="Longitude" oninput="updateCurrentLocationInput('insert')" step="0.00001" value="0.0">
                        <input type="number" id="insert-latitude" class="form-control" placeholder="Latitude" oninput="updateCurrentLocationInput('insert')" step="0.00001" value="0.0">
                        <div class="input-group-append">
                            <button class="btn btn-default" type="button" onclick="updateCurrentLocation('insert')">
                                <i class="fa fa-location"></i>
                            </button>
                        </div>
                    </div>
                    <div class="row mb-2" id="insert-map-selection"></div>
                    <div class="row" id="insert-map-view">
                        <div class="icheck-primary ml-2 mb-3">
                            <input type="checkbox" id="insert-satellite" name="satellite" onchange="updateMapViewMode(this, 'insert')">
                            <label for="insert-satellite">
                                Satellite
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="insert-proprietaire">propriétaire:<span
                                class="text-danger">*</span></label>
                        <div class="input-group mb-2" id="insert-client-search-container">
                            <input type="text" class="form-control" placeholder="Recherche" oninput="searchForClient(this, clients, 'insert')"/>
                            <div class="input-group-append">
                                <span class="btn btn-default" id="insert-client-search-result-number">0</span>
                            </div>
                        </div>
                        <div class="input-group">
                            <select id="insert-proprietaire" class="custom-select" required>
                                <option selected="selected" hidden="hidden" value="">(Sélectionner un propriétaire)</option>
                            </select>
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button" onclick="toggleClientSearch('insert')">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div>
                        <small class="form-text text-danger" id="insert-proprietaire-error"></small>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-surface">surface:<span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="insert-surface" required>
                                <small class="form-text text-danger" id="insert-surface-error"></small>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-prix">prix par m²:<span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="insert-prix" required>
                                <small class="form-text text-danger" id="insert-prix-error"></small>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="insert-relief">relief:<span class="text-danger">*</span></label>
                        <select id="insert-relief" class="custom-select">
                            <option value="Coline">Coline</option>
                            <option value="Montagne">Montagne</option>
                            <option value="Plateau">Plateau</option>
                            <option value="Plaine">Plaine</option>
                        </select>
                    </div>
                    <div class="row">
                        <div class="icheck-primary ml-2 mb-3">
                            <input type="checkbox" id="insert-en-vente" name="en-vente">
                            <label for="insert-en-vente">
                                En vente
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="initInsertForm()">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="submit('insert')">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script src="${pageContext.request.contextPath}/js/terrain/insert.js"></script>

