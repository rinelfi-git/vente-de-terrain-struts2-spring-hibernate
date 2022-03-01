function $formValidation(field) {
	let error = ''
	const formValidation = {
		field: field,
		requiredValid: function () {
			const valid = !(formValidation.field.required && formValidation.field.value === '')
			return valid
		},
		minLengthValid: function() {
			return !(formValidation.field.minLength > 0 && formValidation.field.value.length < formValidation.field.minLength)
		},
		maxLengthValid: function() {
			return !(formValidation.field.maxLength > 0 && formValidation.field.value.length > formValidation.field.maxLength)
		},
		isValid: function() {
			return formValidation.requiredValid() && formValidation.minLengthValid() && formValidation.maxLengthValid()
		}
	}
	return formValidation;
}