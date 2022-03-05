/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

const insertPhones = []

function insertAction() {
    return false
}

function initInsertForm() {
    document.getElementById(`insert-phones-form`).style.display = 'none';
    document.getElementById(`insert-address-form`).style.display = 'none';
    document.getElementById(`insert-cancel`).style.display = 'block';
    document.getElementById(`insert-previous`).style.display = 'none';
    document.getElementById(`insert-next`).style.display = 'block';
    document.getElementById(`insert-next`).dataset.target = 1;
    document.getElementById(`insert-save`).style.display = 'none';
    document.getElementById('insert-cin').value = '';
    document.getElementById('insert-nom').value = '';
    document.getElementById('insert-prenom').value = '';
    document.getElementById('insert-ville').value = '';
    document.getElementById('insert-postal').value = '';
    document.getElementById('insert-lot').value = '';
    document.getElementById('insert-phones-iteration').innerHTML = '';
    addPhoneForm('insert')
}

$(document).ready(function () {
    initInsertForm()
})
