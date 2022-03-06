<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 08/12/2021
  Time: 07:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal" id="thumbnail-modal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modifier les aperçus</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><small>(Veuillez cliquer sur les images pour les supprimer ou annuler leur ajout)</small></p>
                <div id="thumbnail-content">
                    <div class="row">
                    </div>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="thumb-validation" onchange="onAddInputThumbnail(this)">
                        <label class="custom-file-label" for="thumb-validation">Sélectionner une fichier</label>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="saveThumbnail()">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>