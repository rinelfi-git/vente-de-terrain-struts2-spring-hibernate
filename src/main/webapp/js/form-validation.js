function $formValidation(field) {
    let error = ''
    const formValidation = {
        field: typeof field === 'string' ? document.getElementById(field) : field,
        requiredValid: function () {
            const valid = !(this.field.required && this.field.value === '')
            if (!valid)
                error = 'Merci renseigner ce champ'
            return valid
        },
        minLengthValid: function () {
            const valid = !(this.field.minLength > 0 && this.field.value.length < this.field.minLength)
            if (!valid)
                error = 'La valeur du champ ne doit pas être en dessous de ' + this.field.minLength
            return valid
        },
        maxLengthValid: function () {
            const valid = !(this.field.maxLength > 0 && this.field.value.length > this.field.maxLength)
            if (!valid)
                error = 'La valeur du champ ne doit pas être au dessus de ' + this.field.minLength
            return valid
        },
        patternValid: function () {
            const valid = typeof this.field.pattern === 'undefined' || (this.field.pattern.length > 0 && this.field.value.match(this.field.pattern)) !== null;
            if (!valid)
                error = 'Le format doit corréspondre à ' + this.field.pattern
            return valid;
        },
        isValid: function () {
            return this.requiredValid() && this.minLengthValid() && this.maxLengthValid() && this.patternValid()
        },
        putError: function (help) {
            const element = document.getElementById(help)
            element.textContent = error
            element.style = {
                display: 'block'
            }
        }
    }
    return formValidation;
}