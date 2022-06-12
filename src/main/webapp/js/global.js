const BASE_URL = `${document.location.origin}/`;
const MAX_FILE_SIZE = 10485760;
function baseUrl(url) {
    if (url.indexOf('/') === 0) url = url.slice(1);
    return BASE_URL + url;
}

function profileUrl(url) {
    if (url.indexOf('/') === 0) url = url.slice(1);
    return baseUrl(`upload/images/client/${url}`);
}

function terrainApercuUrl(url) {
    if (url.indexOf('/') === 0) url = url.slice(1);
    return baseUrl(`upload/images/terrain/${url}`);
}