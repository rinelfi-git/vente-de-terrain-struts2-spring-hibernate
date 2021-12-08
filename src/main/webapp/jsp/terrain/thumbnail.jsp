<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 08/12/2021
  Time: 07:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="thumbnail-modal">
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
                <button type="button" class="btn btn-primary" onclick="">Enregistrer</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script>
	const thumbnails = []
	
	function thumbTemplate(image) {
		return `<div class="col-md-6 col-sm-12 mb-3" onclick="deleteThumb(` + image + `)">
                    <div class="thumbnail" style="background: url('http://localhost/vente_de_terrain/terrain/` + image + `') no-repeat center;background-size: cover">
                        <div class="cross cross-top"></div>
                        <div class="cross cross-bottom"></div>
                    </div>
                </div>`
	}
	
	function deleteThumb(image) {
		return new Promise((resolve, reject) => {
			$.ajax({
				methode: 'delete',
				url: BASE_URL + '/terrain/thumbnail/delete/' + image,
				dataType: 'json',
				success: response => resolve(response),
				error: (error1, error2, error3) => reject([error1, error2, error3])
			})
		})
	}
	
	function addThumbnail(formData) {
		return new Promise((resolve, reject) => {
			$.ajax({
				method: 'post',
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				url: BASE_URL + '/terrain/thumbnail/add.action',
				success: response => resolve(response),
				error: (error1, error2, error3) => reject([error1, error2, error3])
			})
		})
	}
	
	async function onAddInputThumbnail(element) {
		if (element.files.length > 0) {
			const file = element.files[0]
			$(element).next('.custom-file-label').text(file.name)
			const formData = new FormData()
			formData.append('apercu', file)
			thumbnails.push(await addThumbnail(formData))
			let html = ''
			thumbnails.forEach(thumbnail => html += thumbTemplate(thumbnail))
			$('#thumbnail-content .row').html(html)
		}
	}
</script>