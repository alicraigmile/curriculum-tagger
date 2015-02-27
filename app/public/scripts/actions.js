document.addEventListener('DOMContentLoaded', function() {
    var selectField = document.getElementById('relationships-form-uri-select');
    var uriField = document.getElementById('relationships-form-uri-field');
    var submitButton = document.getElementById('relationships-form-submit-button');
     
    submitButton.value = 'reload';
    
    var updateFunc = function(e) {
      submitButton.value = 'update';
      submitButton.style.color = 'red';
    };
    selectField.addEventListener('change', updateFunc);
    uriField.addEventListener('change', updateFunc);
    uriField.addEventListener('keypress', updateFunc);
});