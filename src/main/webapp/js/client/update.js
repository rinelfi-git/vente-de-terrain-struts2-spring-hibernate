/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function initialiserModifier(id) {
    identity = id;
    $.ajax({
        url: baseUrl('client/select.action'),
        method: 'post',
        dataType: 'json',
        data: {
            identity
        },
        success: function (response) {
            document.getElementById(`update-personal-form`).style.display = 'block';
            document.getElementById(`update-phones-form`).style.display = 'none';
            document.getElementById(`update-address-form`).style.display = 'none';
            document.getElementById(`update-cancel`).style.display = 'block';
            document.getElementById(`update-previous`).style.display = 'none';
            document.getElementById(`update-next`).style.display = 'block';
            document.getElementById(`update-next`).dataset.target = 1;
            document.getElementById(`update-save`).style.display = 'none';
            document.getElementById('update-cin').value = response.cin;
            document.getElementById('update-nom').value = response.nom;
            document.getElementById('update-prenom').value = response.prenom;
            document.getElementById('update-ville').value = response.adresse.ville;
            document.getElementById('update-postal').value = response.adresse.codePostal;
            document.getElementById('update-lot').value = response.adresse.lot;
            document.getElementById('update-phones-iteration').innerHTML = '';
            for (let i = 0; i < response.telephones.length; i++) {
                addPhoneForm('update', response.telephones[i]);
                checkInputPhone(document.getElementById(`update-phone${i}`));
            }
            checkInputCin(document.getElementById('update-cin'));
            $('#update-modal').modal('show');
        }
    });
}
