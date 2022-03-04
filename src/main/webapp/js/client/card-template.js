/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function clientCardTemplate(id, nom, prenom, cin, adresse, telephones, photo) {
    var telephoneHtml = ''
    for (const telephone of telephones) {
        telephoneHtml += '<span> <b>-</b> ' + telephone + '<br></span>'
    }
    var clientCardTemplate = '<div class="w-100 col-12 col-md-6 col-lg-4 d-flex align-items-stretch">'
    clientCardTemplate += '<div class="card bg-white card-lightblue card-outline w-100">'
    clientCardTemplate += '<div class="card-body box-profile">'
    clientCardTemplate += '<div class="row">'
    clientCardTemplate += '<div class="col-8">'
    clientCardTemplate += '<h2 class="lead"><b>' + nom + (prenom != null ? ' ' + prenom : '') + '</b></h2>'
    clientCardTemplate += '<ul class="ml-4 mb-0 fa-ul text-muted">'
    clientCardTemplate += '<li class="small"><span class="fa-li"><span class="material-icons">contacts</span></span><b>CIN</b>:<br>' + cin + '</li>'
    clientCardTemplate += typeof adresse !== 'undefined' ? '<li class="small"><span class="fa-li"><span class="material-icons">place</span></span><b>Adresse</b>:<br>' + adresse.lot + ' - ' + adresse.codePostal + ' ' + adresse.ville + '</li>' : ''
    clientCardTemplate += telephones.length > 0 ? '<li class="small"><span class="fa-li"><span class="material-icons">phone</span></span><b>Téléphone</b>:<br>' + telephoneHtml + '</li>' : ''
    clientCardTemplate += '</ul>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '<div class="col-4 text-center">'
    clientCardTemplate += '<img src="' + profileUrl(photo) + '" alt="' + nom + '" class="img-circle img-fluid" style="background: #0069d9;">'
    clientCardTemplate += '<div class="custom-class-image-edit-overlay custom-class-image-edit-overlay-background"></div>'
    clientCardTemplate += '<i class="fa fa-camera fa-2x text-white custom-class-icon-edit-overlay"></i>'
    clientCardTemplate += '<div class="custom-class-image-edit-overlay custom-class-image-edit-overlay-foreground" data-toggle="modal" data-target="#modification-photo" onclick="udpateClientProfileImage( ' + id + ')"></div>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '<div class="card-footer">'
    clientCardTemplate += '<div class="text-left">'
    clientCardTemplate += '<div class="input-group">'
    clientCardTemplate += '<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">action</button>'
    clientCardTemplate += '<div class="dropdown-menu">'
    clientCardTemplate += '<a href="!#" class="dropdown-item" data-toggle="modal" data-target="#modification-modal" onclick="initialiserModifier(' + id + ')"><span class="material-icons">update</span> modifier</a>'
    clientCardTemplate += '<div class="dropdown-divider"></div>'
    clientCardTemplate += '<a href="!#" class="dropdown-item"><span class="material-icons">delete_forever</span> supprimer</a>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '</div>'
    clientCardTemplate += '</div>'
    return clientCardTemplate
}

