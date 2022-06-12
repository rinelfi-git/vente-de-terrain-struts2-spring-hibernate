/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* global URL, FileReader, identity */

// import 'cropperjs/dist/cropper.css';

let image = null;
let cropper = null;

function uploadImageChange(element) {
	image = document.getElementById('image');
	const file = element.files[0];
	const load = function (url) {
		image.src = url;
		$('label[for=profile-image]').text(file.name);
		if (cropper !== null)
			cropper.destroy();
		cropper = new Cropper(image, {
			aspectRatio: 1,
			viewMode: 1
		});
	};
	if (URL) {
		// plus léger
		load(URL.createObjectURL(file));
	} else if (FileReader) {
		const reader = new FileReader();
		reader.onload = function () {
			load(reader.result);
		};
		reader.readAsDataURL(file);
	}
}

function saveProfileImage() {
	const canvas = cropper.getCroppedCanvas({
		width: 150,
		height: 150
	});
	
	canvas.toBlob(function (blob) {
		const url = URL.createObjectURL(blob);
		const reader = new FileReader();
		reader.onloadend = function () {
			let base64image = reader.result;
			base64image = base64image.slice(base64image.indexOf(',') + 1, base64image.length);
			$.ajax({
				url: baseUrl('client/profile.action'),
				method: 'post',
				dataType: 'json',
				data: {
					base64image,
					identity
				},
				success: function () {
					getDataFromService();
					$('#update-profile-image').modal('hide');
				},
				error: function () {
				
				}
			});
		};
		reader.readAsDataURL(blob);
	});
	return false;
}

$(document).ready(function () {
	$('#update-profile-image').on('hidden.bs.modal', function () {
		if (cropper !== null) {
			cropper.destroy();
			image.src = '';
			$('label[for=profile-image]').text('Choose file');
		}
	});
});