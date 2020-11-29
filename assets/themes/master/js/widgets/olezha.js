$(function() {
	var el = $(".olezha");
	setInterval(function() {
		el.jAnimate("fadeInUp", function() {
			setTimeout(function() {
				el.jAnimate("wobble", function() {
					setTimeout(function() {
						el.jAnimateOnce("fadeOutDown", function() {
							el.hide();
						});
					}, 30000);//30сек
				});
			}, 10000);//10сек
		}).show();
	}, 1200000);//20 минут
});