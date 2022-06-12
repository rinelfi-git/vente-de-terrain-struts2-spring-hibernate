function initialiserModifier(id) {
	identity = parseInt(id);
	$.ajax({
		url: baseUrl('terrain/select.action'),
		method: 'post',
		dataType: 'json',
		data: {
			id: identity
		},
		success: function (response) {
			proprietaire_id = response.proprietaire.id;
			document.getElementById(`update-adresse`).value = response.adresse;
			document.getElementById(`update-point-geographique`).checked = response.geolocated;
			document.getElementById(`update-longitude`).value = response.coordinates.longitude;
			document.getElementById(`update-latitude`).value = response.coordinates.latitude;
			document.getElementById(`update-proprietaire`).value = proprietaire_id;
			document.getElementById(`update-surface`).value = response.surface;
			document.getElementById(`update-prix`).value = response.prix;
			document.getElementById(`update-relief`).value = response.relief;
			document.getElementById(`update-relief`).value = response.relief;
			document.getElementById(`update-en-vente`).checked = response.enVente;
			switchGeolocationMode(document.getElementById(`update-point-geographique`), 'update');
			initClientSearchField('update');
			$('#update-modal').modal('show');
		}
	});
}