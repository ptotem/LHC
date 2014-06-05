///**
// * Created with JetBrains RubyMine.
// * User: rushabhhathi
// * Date: 08/11/13
// * Time: 21:50
// * To change this template use File | Settings | File Templates.
// */
//var fbSdkLoader;
//
////appId =>
//// Electionia => 418175744951459
//// Electionia-Dev => 255269797987971
////agileDex=>222280634572524
//
//fbSdkLoader = function() {
//        window.fbAsyncInit = function() {
//            var initConfig;
//            initConfig = {
//                appId: "628824307167447",
//                channelUrl: "/channel.html",
//                status: true,
//                cookie: true,
//                xfbml: true,
//                oauth: true
//            };
//            return FB.init(initConfig);
//        };
//        return (function(d, debug) {
//            var id, js, ref;
//            js = void 0;
//            id = "facebook-jssdk";
//            ref = d.getElementsByTagName("script")[0];
//            if (d.getElementById(id)) {
//                return;
//            }
//            js = d.createElement("script");
//            js.id = id;
//            js.async = true;
//            js.src = "//connect.facebook.net/en_US/all" + (debug ? "/debug" : "") + ".js";
//            return ref.parentNode.insertBefore(js, ref);
//        })(document, false);
//
//};
//
//fbSdkLoader();
//

$(function () {

});

function share_result(fb_share_app_logo){

    FB.ui(
        {
            method: 'feed',
            name: 'Let\'s Have Coffee',
            link: 'http://www.letshavecoffee.in',
            picture: fb_share_app_logo,
            description: 'Let\'s Have Coffee is an exclusive platform for guys and girls from top colleges in India to meet each other.'
        },
        function(response) {
            if (response && response.post_id) {
                console.log('Post was published.');
            } else {
                console.log('Post was not published.');
            }
        }
    );
}