<%-- 
    Document   : confirm-delete
    Created on : 7 mars 2022, 09:43:10
    Author     : rinelfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    #confirm-delete-cin {
        font-weight: bold;
    }
</style>
<div class="modal fade" id="confirm-delete">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Supprimer le client</h4>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label=nk"Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Vous êtes sur le point de supprimer un client portant le CIN "<span id="confirm-delete-cin"></span>". Veuillez confirmer la suppression de ceci tout en prenant en compte que si vous supprimez ce client:<br>
                <ol>
                    <li>Ce client ne sera plus disponnible dans la liste du clientel.</li>
                    <li>Tous les terrains en possession de ce client seront aussi supprimés.</li>
                    <li>Tous les historiques de ventes concertant ce client seront supprimés.</li>
                </ol>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="deleteClient()">Confirmer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
