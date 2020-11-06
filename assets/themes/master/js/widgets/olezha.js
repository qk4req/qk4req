$(function() {
	var o = $(".olezha");
	setInterval(function() {
		o.jAnimateOnce("fadeInUp", function() {
			setTimeout(function() {
				o.jAnimateOnce("wobble", function() {
					setTimeout(function() {
						o.jAnimateOnce("fadeOutDown", function() {
							o.hide();
						});
					}, 90000);//1.5 минуты
				});
			}, 90000);//1.5 минуты
		}).show();
	}, 1200000);//20 минут
});