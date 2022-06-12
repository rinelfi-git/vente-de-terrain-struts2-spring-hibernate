function terrainCardTemplate(index, terrain) {
    const apercues = terrain.apercues;
    let apercuHtml = '';
    if (apercues.length <= 1) {
        apercuHtml = `
        <div class="row">
            <div class="col-12">
                ${apercues.length === 1 ? '<div style="background-image: url(' + terrainApercuUrl(apercues[0]) + '); height: 175px; background-position: center; background-size: cover"></div>' : '<div style="background-image: url(' + terrainApercuUrl('default.png') + '); height: 175px; background-position: center; background-size: cover"></div>'}
            </div>
        </div>
		`;
    } else {
        let indicatorsHtml = '';
        let apercuesHtml = '';
        for (let i = 0; i < apercues.length; i++) {
            indicatorsHtml += `<li data-target="#carousel-indicator${index}" data-slide-to="${i}" class="${i === 0 ? 'active' : ''}"></li>`;
            apercuesHtml += `
			<div class="carousel-item${i === 0 ? ' active' : ''}">
				<div class="d-block w-100" style="background-image: url(${terrainApercuUrl(apercues[i])}); height: 175px; background-position: center; background-size: cover"></div>
			</div>
			`;
        }
        apercuHtml = `
		<div id="carousel-indicator${index}" class="carousel slide" data-ride="carousel" data-interval="false">
			<ol class="carousel-indicators">
				${indicatorsHtml}
			</ol>
			<div class="carousel-inner">
				${apercuesHtml}
			</div>
			<a class="carousel-control-prev" href="#carousel-indicator${index}" role="button" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next" href="#carousel-indicator${index}" role="button" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
		`;
    }
    const apercuesJson = JSON.stringify(apercues).replaceAll('"', '\'');
    return `
			<div class="w-100 col-12 col-sm-12 col-md-6 col-lg-4 d-flex align-items-stretch">
			    <div class="card bg-white card-lightblue card-outline w-100">
			        <div class="card-body">
			            ${apercuHtml}
			            <button class="btn btn-outline-dark btn-flat" data-toggle="modal" data-target="#thumbnail-modal"
			                onclick="loadThumbnails(${terrain.id}, ${apercuesJson})">
			                <span class="material-icons">insert_photo</span>
			                Changer les aperçues
			            </button>
			            <table class="w-100">
			                <tr>
			                    <td><small><strong>Adresse</strong></small></td>
			                    <td><small>${terrain.adresse}</small></td>
			                </tr>
			                <tr>
			                    <td><small><strong>Propriétaire</strong></small></td>
			                    <td><small>${terrain.proprietaire.nom} ${terrain.proprietaire.prenom}</small></td>
			                </tr>
			                <tr>
			                    <td><small><strong>Surface</strong></small></td>
			                    <td class="text-right"><small>${terrain.surface} m²</small></td>
			                </tr>
			                <tr>
			                    <td><small><strong>Prix</strong></small></td>
			                    <td class="text-right"><small>${terrain.prix} Ariary/m²</small></td>
			                </tr>
			                <tr>
			                    <td><small><strong>Relief</strong></small></td>
			                    <td><small>${terrain.relief}</small></td>
			                </tr>
			                <tr>
			                    <td><small><strong>Status</strong></small></td>
			                    <td><small>${terrain.enVente ? 'en vente' : 'pas en vente'}</td>
			                </tr>
			            </table>
			        </div>
			        <div class="card-footer">
			            <div class="row">
			                <div class="col">
			                    <div class="text-left">
			                        <div class="input-group">
			                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
			                                aria-expanded="false">
			                                action
			                            </button>
			                            <div class="dropdown-menu">
			                                <a href="javascript:;" class="dropdown-item" data-toggle="modal"
			                                    data-target="#modification-modal${index}"><span class="material-icons">update</span>
			                                    modifier</a>
			                                <div class="dropdown-divider"></div>
			                                <a href="javascript:;" class="dropdown-item" onclick="promptDelete(${terrain.id}, '${terrain.adresse.replaceAll("'", "\'")}')"><span class="material-icons">delete_forever</span>
			                                    supprimer</a>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="col">
			                    <div class="text-right">
			                        <button class="btn btn-default" ${terrain.geolocated ? `onclick="locateOnMap(${terrain.coordinates.latitude}, ${terrain.coordinates.longitude})"`: 'disabled'}>
			                            <i class="fa fa-map-marker-alt"></i>
			                        </button>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
	`;
}