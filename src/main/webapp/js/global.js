const BASE_URL = 'http://localhost:8080/vente-de-terrain-0.0.1-SNAPSHOT/'
function baseUrl(url) {
	if(url.indexOf('/') === 0) url = url.slice(1)
	return BASE_URL + url
}

function profileUrl(url) {
	if(url.indexOf('/') === 0) url = url.slice(1)
	return 'http://localhost/vente_de_terrain/client/' + url
}