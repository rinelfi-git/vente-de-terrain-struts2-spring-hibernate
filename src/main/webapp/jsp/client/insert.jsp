<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 04/12/2021
  Time: 20:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="insert-modal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Nouveau client</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form autocomplete="off" id="insert-personal-form" onsubmit="return validateStepForm(1, 'insert')">
                    <input type="submit" hidden name="submitter" value="submit">
                    <div class="form-group">
                        <label for="insert-cin">cin:<span class="text-danger">*</span></label>
                        <input type="text" placeholder="XXX XXX XXX XXX" name="cin" id="insert-cin" class="form-control" required maxlength="15" pattern="^[0-9]{3}-[0-9]{2}(1|2){1}-[0-9]{3}-[0-9]{3}$" oninput="checkInputCin(this)">
                        <small class="form-text text-danger" id="insert-cin-error"></small>
                    </div>
                    <div class="form-group">
                        <label for="insert-nom">nom:<span class="text-danger">*</span></label>
                        <input type="text" placeholder="ex: Rakotoarivelo" name="nom" id="insert-nom" class="form-control" required>
                        <small class="form-text text-danger" id="insert-nom-error"></small>
                    </div>
                    <div class="form-group">
                        <label for="insert-prenom">prénom:</label>
                        <input type="text" placeholder="ex: Benjamina" class="form-control" id="insert-prenom" name="prenom">
                        <small class="form-text text-danger" id="insert-prenom-error"></small>
                    </div>
                </form>
                <form autocomplete="off" id="insert-phones-form" onsubmit="return validateStepForm(2, 'insert')">
                    <input type="submit" hidden name="submitter" value="submit">
                    <div id="insert-phones-iteration">
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button class="btn btn-primary btn-flat w-100" type="button" onclick="addPhoneForm('insert')"><i class="fa fa-plus"></i></button>
                        </div>
                    </div>
                </form>
                <form autocomplete="off" id="insert-address-form" onsubmit="return validateStepForm(3, 'insert')">
                    <input type="submit" hidden name="submitter" value="submit">
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-ville">ville:<span class="text-danger">*</span></label>
                                <input type="text" placeholder="ex: Fianarantsoa" class="form-control" id="insert-ville" name="ville" required>
                                <small class="form-text text-danger" id="insert-ville-error"></small>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="form-group">
                                <label for="insert-postal">code postal:<span class="text-danger">*</span></label>
                                <input type="number" placeholder="ex: 301" class="form-control" id="insert-postal" name="postal" required>
                                <small class="form-text text-danger" id="insert-postal-error"></small>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <label for="insert-lot">lot:</label>
                            <textarea id="insert-lot" rows="3" class="form-control" name="lot"></textarea>
                            <small class="form-text text-danger" id="insert-lot-error"></small>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="insert-cancel">Annuler</button>
                <button type="button" class="btn btn-default" id="insert-previous" data-target="1" onclick="recheckStepForm(this.dataset.target, 'insert')"><i class="fa fa-angle-left"></i> Précédent</button>
                <button type="button" class="btn btn-primary" id="insert-next" data-target="1" onclick="validateStepForm(this.dataset.target, 'insert')">Suivant <i class="fa fa-angle-right"></i></button>
                <button type="button" class="btn btn-primary" id="insert-save" onclick="validateStepForm(3, 'insert')">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

