/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function initInsertForm() {
    document.getElementById('insert-adresse').value = '';
    document.getElementById('insert-point-geographique').checked = false;
    document.getElementById('insert-coordinates').style.display = 'none';
    document.getElementById('insert-map-selection').style.display = 'none';
    document.getElementById('insert-map-view').style.display = 'none';
    document.getElementById('insert-satellite').checked = false;
    document.getElementById('insert-satellite').dispatchEvent(new Event('change'));
    document.getElementById('insert-longitude').value = '47.0908595';
    document.getElementById('insert-longitude').dispatchEvent(new Event('input'));
    document.getElementById('insert-latitude').value = '-21.4560529';
    document.getElementById('insert-latitude').dispatchEvent(new Event('input'));
    document.querySelector('#insert-client-search-container input').value = '';
    document.querySelector('#insert-client-search-container span').textContent = '0';
    document.getElementById('insert-proprietaire').value = '';
    document.getElementById('insert-surface').value = '';
    document.getElementById('insert-prix').value = '';
    document.getElementById('insert-relief').value = 'Coline';
    document.getElementById('insert-en-vente').checked = false;
}

$(document).ready(function () {
    initInsertForm();
});