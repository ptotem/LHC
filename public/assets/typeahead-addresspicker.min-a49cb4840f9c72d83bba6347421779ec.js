(function(){var e=function(e,t){return function(){return e.apply(t,arguments)}},t={}.hasOwnProperty,o=function(e,o){function n(){this.constructor=e}for(var r in o)t.call(o,r)&&(e[r]=o[r]);return n.prototype=o.prototype,e.prototype=new n,e.__super__=o.prototype,e};this.AddressPicker=function(t){function n(t){null==t&&(t={}),this.updateMap=e(this.updateMap,this),t=$.extend({local:[],datumTokenizer:function(e){return Bloodhound.tokenizers.whitespace(e.num)},queryTokenizer:Bloodhound.tokenizers.whitespace},t),n.__super__.constructor.call(this,t),t.map&&this.initMap(t.map)}return o(n,t),n.prototype.initMap=function(e){return this.placeService=new google.maps.places.PlacesService(document.createElement("div")),e=$.extend({zoom:3,center:new google.maps.LatLng(0,0),mapTypeId:google.maps.MapTypeId.ROADMAP},e),this.map=new google.maps.Map($(e.id)[0],e),this.marker=new google.maps.Marker({position:e.center,map:this.map,visible:!1})},n.prototype.get=function(e,t){var o;return o=new google.maps.places.AutocompleteService,o.getPlacePredictions({input:e,types:["geocode"]},function(e){var o,n;return o=function(){var t,o,r;for(r=[],t=0,o=e.length;o>t;t++)n=e[t],r.push(n);return r}(),t(o)})},n.prototype.updateMap=function(e,t){return this.placeService.getDetails(t,function(e){return function(t){return e.marker.setPosition(t.geometry.location),e.marker.setVisible(!0),t.geometry.viewport?e.map.fitBounds(t.geometry.viewport):(e.map.setCenter(t.geometry.location),e.map.setZoom(16))}}(this))},n}(Bloodhound)}).call(this);