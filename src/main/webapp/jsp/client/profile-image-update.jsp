<%-- 
    Document   : profile-image-update
    Created on : 4 mars 2022, 11:55:50
    Author     : rinelfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    /* Ensure the size of the image fit the container perfectly */
    #image {
        display: block;
        height: auto;
        /* This rule is very important, please don't ignore this */
        max-width: 100%;
    }
</style>
<div class="modal fade" id="update-profile-image">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modification de la photo de profile</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; width: 100%; height: 500px; background-image: url('${pageContext.request.contextPath}/img/thumbnail-default.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center;" class="mb-2">
                    <img id="image" src="">
                </div>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" id="profile-image" onchange="uploadImageChange(this)">
                    <label class="custom-file-label" for="profile-image">Choose file</label>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-primary" onclick="saveProfileImage()">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>