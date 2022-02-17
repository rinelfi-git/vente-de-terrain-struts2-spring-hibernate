function $formValidation(field) {
	var formValidation = {
		field: field,
		requriedValid: function () {
			return !(formValidation.field.required && formValidation.field.value === '')
		},
		minLengthValid: function() {
			return !(formValidation.field.minLength > 0 && formValidation.field.value.length < formValidation.field.minLength);
		},
		maxLengthValid: function() {
			return !(formValidation.field.maxLength > 0 && formValidation.field.value.length > formValidation.field.maxLength);
		},
	}
	return formValidation;
}