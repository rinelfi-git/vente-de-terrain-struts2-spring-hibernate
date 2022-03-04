<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 20:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="update-modal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Nouveau client</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form autocomplete="off" id="update-personal-form">
                    <input type="submit" hidden="hidden" id="update-information-submitters">
                    <div class="form-group">
                        <label for="update-cin">cin:<span class="text-danger">*</span></label>
                        <input type="text" placeholder="xxx xx(1 ou 2) xxx xxx (Sans espace)" name="cin" id="update-cin" class="form-control" required maxlength="12" pattern="[0-9]{5}(1|2){1}[0-9]{6}">
                        <small class="form-text text-danger" id="update-cin-error"></small>
                    </div>
                    <div class="form-group">
                        <label for="update-nom">nom:<span class="text-danger">*</span></label>
                        <input type="text" placeholder="ex: Rakotoarivelo" name="nom" id="update-nom" class="form-control" required>
                        <small class="form-text text-danger" id="update-nom-error"></small>
                    </div>
                    <div class="form-group">
                        <label for="update-prenom">prénom:</label>
                        <input type="text" placeholder="ex: Benjamina" class="form-control" id="update-prenom" name="prenom">
                    </div>
                </form>
                <form autocomplete="off" id="update-telephones-form">
                    <input type="submit" hidden="hidden" id="update-telephones-submitters">
                    <div id="update-telephones-iteration">
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button class="btn btn-primary btn-flat w-100" type="button" onclick="addTelephone()"><i class="fa fa-plus"></i></button>
                        </div>
                    </div>
                </form>
                <form autocomplete="off" id="update-address-form">
                    <input type="submit" hidden="hidden" id="update-address-submitter">
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="update-ville">ville:<span class="text-danger">*</span></label>
                                <input type="text" placeholder="ex: Fianarantsoa" class="form-control" id="update-ville" name="ville" required>
                                <small class="form-text text-danger" id="update-ville-error"></small>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="update-postal">code postal:<span class="text-danger">*</span></label>
                                <input type="number" placeholder="ex: 301" class="form-control" id="update-postal" name="postal" required>
                                <small class="form-text text-danger" id="update-postal-error"></small>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label for="update-lot">lot:</label>
                            <textarea id="update-lot" rows="3" class="form-control" name="lot"></textarea>
                            <small class="form-text text-danger" id="update-lot-error"></small>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="update-cancel">Annuler</button>
                <button type="button" class="btn btn-default" id="update-previous"><i class="fa fa-angle-left"></i> Précédent</button>
                <button type="button" class="btn btn-primary" id="update-next">Suivant <i class="fa fa-angle-right"></i></button>
                <button type="button" class="btn btn-primary" id="update-save">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

