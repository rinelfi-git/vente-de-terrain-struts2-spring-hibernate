const BASE_URL = 'http://localhost:8080/vente-terrain/'
function baseUrl(url) {
	if(url.indexOf('/') === 0) url = url.slice(1)
	return BASE_URL + url
}