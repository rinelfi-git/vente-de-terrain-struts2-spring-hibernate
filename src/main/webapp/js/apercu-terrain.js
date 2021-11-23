$(() => {
	$('#apercues').on('mouseover', '.apercue', e => {
		$(e.currentTarget).find('.cross').addClass('active');
	});
	$('#apercues').on('mouseout', e => {
		$('.cross').removeClass('active');
	})
});
