/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global toastr, MAX_FILE_SIZE */

$(document).ready(function () {
    $('#thumbnail-modal').on('hide.bs.modal', () => {
        $('#thumb-validation').next('.custom-file-label').text('Sélectionner une fichier')
        thumbnails = []
        todelete = []
        updateThumbnailView()
    })

})
let thumbnails = []
let todelete = []

function thumbTemplate(image) {
    return `<div class="col-md-6 col-sm-12 mb-3" onclick="onDeleteThumbnail('` + image + `')">
                    <div class="thumbnail" style="background: url('` + terrainApercuUrl(image) + `') no-repeat center;background-size: cover">
                        <div class="cross cross-top"></div>
                        <div class="cross cross-bottom"></div>
                    </div>
                </div>`
}

function addThumbnailRequest(formData) {
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

function onDeleteThumbnail(image) {
    thumbnails.splice(thumbnails.indexOf(image), 1)
    todelete.push(image)
    updateThumbnailView()
}

async function onAddInputThumbnail(element) {
    if (element.files.length > 0) {
        const file = element.files[0]
        const formData = new FormData()
        formData.append('apercu', file)
        if (file.size <= MAX_FILE_SIZE) {
            thumbnails.push(await addThumbnailRequest(formData))
            updateThumbnailView()
        } else {
            toastr.options = {
                "closeButton": false,
                "debug": false,
                "newestOnTop": false,
                "progressBar": false,
                "positionClass": "toast-bottom-right",
                "preventDuplicates": true,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "300",
                "timeOut": "3000",
                "extendedTimeOut": "0",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
            toastr["error"](`Impossible de téléverser votre image. Veuillez vérifier que la taille n'éxcède pas le ${MAX_FILE_SIZE / 1024 / 1024} Mo`, "Erreur de téléversement")
        }
    }
}

function updateThumbnailView() {
    let html = ''
    thumbnails.forEach(thumbnail => html += thumbTemplate(thumbnail))
    $('#thumbnail-content .row').html(html)
}

function saveThumbnail() {
    saveThumbnailRequest().then(function () {
        getDataFromService()
        $('#thumbnail-modal').modal('hide')
    })
}

function saveThumbnailRequest() {
    return new Promise((resolve, reject) => {
        $.ajax({
            url: BASE_URL + 'terrain/thumbnail/save.action',
            method: 'post',
            dataType: 'json',
            traditional: true,
            data: {
                saveThumb: thumbnails,
                excludeThumb: todelete,
                identity: selectedIdentity
            },
            success: response => resolve(response),
            error: (error1, error2, error3) => reject([error1, error2, error3])
        })
    })
}
