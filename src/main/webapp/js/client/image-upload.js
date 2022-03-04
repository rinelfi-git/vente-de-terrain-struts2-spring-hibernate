/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
// import 'cropperjs/dist/cropper.css';

const image = document.getElementById('image');
let cropper = null
function uploadImageChange(element) {
    const reader = new FileReader()
    const file = element.files[0]
    reader.onload = function () {
        image.src = reader.result
        $('label[for=profile-image]').text(file.name)
        if (cropper != null)
            cropper.destroy()
        cropper = new Cropper(image, {
            aspectRatio: 1,
            viewMode: 1
        });
    }
    reader.readAsDataURL(file);
}

function saveProfileImage() {
    let croppedimage = cropper.getCroppedCanvas().toDataURL("image/png");
    croppedimage = croppedimage.substring(croppedimage.indexOf(',') + 1, croppedimage.length)
    const formData = new FormData()
    formData.append('base64image', croppedimage)
    formData.append('identity', identity)
    $.ajax({
        url: baseUrl('client/profile.action'),
        method: 'post',
        dataType: 'json',
        contentType: false,
        processData: false,
        data: formData,
        success: function () {
            getDataFromService()
            $('#update-profile-image').modal('hide')
        },
        error: function () {

        }
    })
}

$(document).ready(function () {
    $('#update-profile-image').on('hidden.bs.modal', function () {
        if (cropper != null){
            cropper.destroy()
            image.src = ''
            $('label[for=profile-image]').text('Choose file')
        }
            
    })
})