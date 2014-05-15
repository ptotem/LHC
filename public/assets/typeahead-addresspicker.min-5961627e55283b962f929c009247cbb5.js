/*! typeahead-addresspicker - v1.0.0 - 2014-02-28
* https://github.com/sgruhier/typeahead-addresspicker
* Copyright (c) 2014 Sebastien Gruhier; Licensed MIT */
(function(){var a=function(a,b){return function(){return a.apply(b,arguments)}},b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};this.AddressPicker=function(b){function d(b){null==b&&(b={}),this.updateMap=a(this.updateMap,this),b=$.extend({local:[],datumTokenizer:function(a){return Bloodhound.tokenizers.whitespace(a.num)},queryTokenizer:Bloodhound.tokenizers.whitespace},b),d.__super__.constructor.call(this,b),b.map&&this.initMap(b.map)}return c(d,b),d.prototype.initMap=function(a){return this.placeService=new google.maps.places.PlacesService(document.createElement("div")),a=$.extend({zoom:3,center:new google.maps.LatLng(0,0),mapTypeId:google.maps.MapTypeId.ROADMAP},a),this.map=new google.maps.Map($(a.id)[0],a),this.marker=new google.maps.Marker({position:a.center,map:this.map,visible:!1})},d.prototype.get=function(a,b){var c;return c=new google.maps.places.AutocompleteService,c.getPlacePredictions({input:a,types:["geocode"]},function(a){var c,d;return c=function(){var b,c,e;for(e=[],b=0,c=a.length;c>b;b++)d=a[b],e.push(d);return e}(),b(c)})},d.prototype.updateMap=function(a,b){return this.placeService.getDetails(b,function(a){return function(b){return a.marker.setPosition(b.geometry.location),a.marker.setVisible(!0),b.geometry.viewport?a.map.fitBounds(b.geometry.viewport):(a.map.setCenter(b.geometry.location),a.map.setZoom(16))}}(this))},d}(Bloodhound)}).call(this);
