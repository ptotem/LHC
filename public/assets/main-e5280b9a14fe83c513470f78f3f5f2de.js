$(document).ready(function(){var a=($("#filterOptions li.active a").attr("class"),$("ul.ourHolder")),i=a.clone();$("#filterOptions li a").click(function(){$("#filterOptions li").removeClass("active");var t=$(this).attr("class");if($(this).parent().addClass("active"),"all"==t)var e=i.find("li");else var e=i.find("li[data-type="+t+"]");return a.quicksand(e,{duration:800,easing:"easeInOutQuad"}),!1})});