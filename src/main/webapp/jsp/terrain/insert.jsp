<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 07/12/2021
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="insert-modal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Nouveau Terrain</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form autocomplete="off">
                    <input type="submit" value="" hidden="hidden">
                    <div class="form-group">
                        <label for="insert-localisation">localisation:<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="localisation" id="insert-localisation">
                    </div>
                    <div class="form-group">
                        <label for="client">propriétaire:<span class="text-danger">*</span></label>
                        <div class="input-group mb-2">
                            <input type="text" class="form-control" placeholder="Recherche"/>
                            <div class="input-group-append">
                                <span class="btn btn-default">0</span>
                            </div>
                        </div>
                        <div class="input-group">
                            <select id="client" class="custom-select">
                                <option selected="selected" hidden="hidden" disabled="disabled">(Aucun client)</option>
                            </select>
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-surface">surface:<span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="insert-surface">
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-prix-par-metre">prix par m²:<span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="insert-prix-par-metre">
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
                    <div class="form-check">
                        <label for="insert-en-vente">
                            <input type="checkbox" id="insert-en-vente"> en vente
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-primary">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

