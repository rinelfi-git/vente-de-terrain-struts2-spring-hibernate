$(() => {
	$('.modal').on('closeModal', e => {
		$(e.currentTarget).modal('hide');
	});
	$(document).on('mouseover', '.custom-class-image-edit-overlay-foreground', e => {
		var icon = $(e.currentTarget).prev('.fa');
		var background = icon.prev('.custom-class-image-edit-overlay-background');
		var animationDuration = 200;
		icon.stop();
		background.stop();
		icon.css({
			position: 'absolute',
			top: ($(e.currentTarget).height() / 2 - icon.height() / 2) + 'px',
			left: (7 + $(e.currentTarget).width() / 2 - icon.width() / 2) + 'px',
		});
		icon.fadeIn(animationDuration);
		background.addClass('overlay-active');
		$(e.currentTarget).on('mouseout', e => {
			var icon = $(e.currentTarget).prev('.fa');
			var background = icon.prev('.custom-class-image-edit-overlay-background');
			icon.stop();
			icon.fadeOut(animationDuration);
			background.removeClass('overlay-active');
		})
	})
})
