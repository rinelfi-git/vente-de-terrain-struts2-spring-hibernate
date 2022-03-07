const BASE_URL = 'http://localhost:8085/vente-de-terrain/';
const MAX_FILE_SIZE = 10485760;
function baseUrl(url) {
    if (url.indexOf('/') === 0) url = url.slice(1);
    return BASE_URL + url;
}

function profileUrl(url) {
    if (url.indexOf('/') === 0) url = url.slice(1);
    return 'http://localhost/vente_de_terrain/client/' + url;
}

function terrainApercuUrl(url) {
    if (url.indexOf('/') === 0) url = url.slice(1);
    return 'http://localhost/vente_de_terrain/terrain/' + url;
}