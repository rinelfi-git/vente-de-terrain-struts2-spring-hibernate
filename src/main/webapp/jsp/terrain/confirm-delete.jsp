<%-- 
    Document   : confirm-delete
    Created on : 7 mars 2022, 09:43:10
    Author     : rinelfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    #confirm-delete-adresse {
        font-weight: bold;
    }
</style>
<div class="modal fade" id="confirm-delete">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Supprimer le terrain</h4>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label=nk"Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Vous êtes sur le point de supprimer le terrain "<span id="confirm-delete-adresse"></span>". Veuillez confirmer la suppression de ceci tout en prenant en compte que si vous supprimez ce terrain:<br>
                - Ce terrain ne sera plus disponnible à la vente.<br>
                - Toutes les ventes relatives à ce terrain seront supprimées.<br>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="deleteTerrain()">Confirmer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
