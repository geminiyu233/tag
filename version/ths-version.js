
function resizeIframe() {
    $(".contentMain-right").width($(window).width() - 280);
}
window.onresize = resizeIframe;
$(function(){
    resizeIframe();

    $("p.innerSpan > span > a").on("click", function(){
        $("p.innerSpan > span > a.active").removeClass("active");
        $(this).addClass("active");
    });
    $("p.innerSpan > span:first > a").click();

        $("#main .title span").click(function(){
            var thisQ = $(this);
            var allp = $(".rightTitle p");
            var rightTitle = $(".rightTitle");
            if(thisQ.attr("remove")!="true"){
                thisQ.attr("remove","true");
                thisQ.css({"filter": "invert(0.8)"});
                for (var i = 0; i < allp.length; i++) {
                    if(allp[i].innerText && allp[i].innerText.indexOf(thisQ.attr("value"))>-1){
                        $(allp[i]).hide(1000);
                    }
                }
            }else{
                thisQ.attr("remove","false");
                thisQ.css({"filter": "invert(0)"});
                for (var i = 0; i < allp.length; i++) {
                    if(allp[i].innerText && allp[i].innerText.indexOf(thisQ.attr("value"))>-1){
                        $(allp[i]).show(1000);
                    }
                }
            }
        });
});
$(window).scroll(function() {
    var height = $(document).scrollTop();//滚轮向上滚动与向下滚动的高度
    if(height >= 157){
        $('.inner').css({"position":'fixed',"margin-top":'0px'});
    }else{
        $('.inner').css({"position":'absolute',"margin-top":'157px'});
    }
});