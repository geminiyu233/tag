window.onload = function() {
	/*resize();*/
}
/*整屏等比缩放*/
$(window, document).resize(function() {
	/*resize();*/
})

/*function resize() {
	var ratio_width = $(window).width() / 1920
	$('.content').css({
		transform: "scale(" + ratio_width + ")",
		transformOrigin: "left top",
		//控制不了的时候去body里面加上overflow：hidden;
	});
	$('.main').height($(window).height()*1.185);

}*/

$(function() {
	$(".nav>ul").find("li").off("click").on("click", function() {
		var index = $(this).index();
		$(this).addClass("on").siblings().removeClass("on");
		getEnterDistribution($(this).attr("id"));
		getTagFrequency($(this).attr("id"));
		// $(".model-box").eq(index).addClass("active").siblings().removeClass("active");
	});
});

$(".time-list>span").click(function() {
	var index = $(this).index();
	$(this).addClass("blue").siblings().removeClass("blue");
	getInitializeRank($(this).attr("text"));
	// $(".model-box").eq(index).addClass("active").siblings().removeClass("active");
}) ;
// $(".nav>div").click(function() {
// 		var index = $(this).index();
// 		$(this).addClass("on").siblings().removeClass("on");
// 		// $(".model-box").eq(index).addClass("active").siblings().removeClass("active");
// 	}) ;

$('.tab-h li').click(function() {
	$(this).addClass('active').siblings('li').removeClass('active');
})






