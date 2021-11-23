$(() => {
	$('.modal').on('hide', e => {
		$(e.currentTarget).modal('hide');
	});
	$('#modification-modal').on('show', e => {
		const element = e.currentTarget;
		$(element).modal('show');
		$(element).on('hide', () => {
			$(element).modal('hide');
		})
	})
})
