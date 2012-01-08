jQuery(document).ready(function(){
	// для браузеров кроме Firefox и движка Webkit меняем 
	// встроенный алгоритм просчета ширины субменю
	if(!jQuery.browser.mozilla && !jQuery.browser.webkit){
		jQuery("header ul ul a").css("font-family", "arial");
		jQuery("header ul ul").each(function(){
			var ww = 0;
			jQuery("li", this).each(function(){
				var w = jQuery(this).width();
				// добавляем 20% на всякий, неправильно 
				// рассчитывается ширина блоков с внешними шрифтами
				ww += w + Math.ceil(w*0.2);
			});
			jQuery(this).width(ww);
		});
		// Возвращаем шрифт оббратно
		jQuery("header ul ul a", this).css("font-family", 'LobsterRegular');
	}
	// выбор списка локаций - при наведении вылетает выпадающий список
	jQuery(".loc-select-box").hover(
		function(){
			jQuery(".loc-list").show();
		},
		function(){
			jQuery(".loc-list").hide();
		}
	);
	// выпадающий список районов видимый пока мы на нем самом
	jQuery(".loc-list").hover(
		function(){
			jQuery(".loc-list").show();
		},
		function(){
			jQuery(".loc-list").hide();
		}
	);
	// Вопрос - ответ: скрывается по +/-
	jQuery(".faq li .toggle").click(function(){
		var prnt = jQuery(this).parents("li");
		if (prnt.is(".active")){
			prnt.removeClass("active");
		} else {
			prnt.addClass("active");
		}
	});
	//ie6-8 nth-child хак (переопределяем css)
	if (jQuery.browser.msie && parseInt(jQuery.browser.version)<9){
		jQuery(".flt-choices li:nth-child(7n), .flt-choices li:last-child").css("margin-right", "0px");
		jQuery(".flt-table tr td:nth-child(n)").css("background-color", "transparent");
		jQuery(".flt-table tr:nth-child(4n-2) td").css("background", "transparent url(../img/bg_gray.png) 0 0 repeat scroll");
		jQuery(".flt-table tr:nth-child(4n) td").css("background-color", "ffffff");
		jQuery(".items li:nth-child(4n+1)").css("margin", "0px");
		jQuery(".flt-checked-box:last-child .right-line").css("background", "transparent none");
	}
});
