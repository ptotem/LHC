!function(t){t.fn.circliful=function(i){var a=t.extend({foregroundColor:"#556b2f",backgroundColor:"#eee",fillColor:!1,width:15,dimension:200,size:15,percent:50,animationStep:1},i);return this.each(function(){function i(t){v.clearRect(0,0,g.width,g.height),v.beginPath(),v.arc(x,u,y,M,w,!1),v.lineWidth=h-1,v.strokeStyle=r,v.stroke(),k&&(v.fillStyle=k,v.fill()),v.beginPath(),v.arc(x,u,y,-z,b*t-z,!1),v.lineWidth=h,v.strokeStyle=l,v.stroke(),c>P&&(P+=C,requestAnimationFrame(function(){i(Math.min(P,c)/100)}))}var s="",e="",n="",h="",d=0,o=0,c=100,l="",r="",p="",f=0;t(this).addClass("circliful"),s=void 0!=t(this).data("dimension")?t(this).data("dimension"):a.dimension,h=void 0!=t(this).data("width")?t(this).data("width"):a.width,d=void 0!=t(this).data("fontsize")?t(this).data("fontsize"):a.size,void 0!=t(this).data("percent")?(o=t(this).data("percent")/100,c=t(this).data("percent")):o=a.percent/100,l=void 0!=t(this).data("fgcolor")?t(this).data("fgcolor"):a.foregroundColor,r=void 0!=t(this).data("bgcolor")?t(this).data("bgcolor"):a.backgroundColor,f=void 0!=t(this).data("animation-step")?parseFloat(t(this).data("animation-step")):a.animationStep,void 0!=t(this).data("text")?(e=t(this).data("text"),void 0!=t(this).data("icon")&&(p='<i class="fa '+t(this).data("icon")+'"></i>'),void 0!=t(this).data("type")?(I=t(this).data("type"),"half"==I?(t(this).append('<span class="circle-text-half">'+p+e+"</span>"),t(this).find(".circle-text-half").css({"line-height":s/1.45+"px","font-size":d+"px"})):(t(this).append('<span class="circle-text">'+p+e+"</span>"),t(this).find(".circle-text").css({"line-height":s+"px","font-size":d+"px"}))):(t(this).append('<span class="circle-text">'+p+e+"</span>"),t(this).find(".circle-text").css({"line-height":s+"px","font-size":d+"px"}))):void 0!=t(this).data("icon"),void 0!=t(this).data("info")&&(n=t(this).data("info"),void 0!=t(this).data("type")?(I=t(this).data("type"),"half"==I?(t(this).append('<span class="circle-info-half">'+n+"</span>"),t(this).find(".circle-info-half").css({"line-height":.9*s+"px"})):(t(this).append('<span class="circle-info">'+n+"</span>"),t(this).find(".circle-info").css({"line-height":1.25*s+"px"}))):(t(this).append('<span class="circle-info">'+n+"</span>"),t(this).find(".circle-info").css({"line-height":1.25*s+"px"}))),t(this).width(s+"px");var g=t("<canvas></canvas>").attr({width:s,height:s}).appendTo(t(this)).get(0),v=g.getContext("2d"),x=g.width/2,u=g.height/2,m=360*o,y=(m*(Math.PI/180),g.width/2.5),w=2.3*Math.PI,M=0,P=0===f?c:0,C=Math.max(f,0),b=2*Math.PI,z=Math.PI/2,I="",k=!1;if(void 0!=t(this).data("type")&&(I=t(this).data("type"),"half"==I))var w=2*Math.PI,M=3.13,b=1*Math.PI,z=Math.PI/.996;k=void 0!=t(this).data("fill")?t(this).data("fill"):a.fillColor,i(P/100)})}}(jQuery);