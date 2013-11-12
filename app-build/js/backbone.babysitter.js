// Backbone.BabySitter
// -------------------
// v0.0.6
//
// Copyright (c)2013 Derick Bailey, Muted Solutions, LLC.
// Distributed under MIT license
//
// http://github.com/babysitterjs/backbone.babysitter

define("backbone.babysitter",["backbone"],function(e){return e.ChildViewContainer=function(e,t){var n=function(e){this._views={},this._indexByModel={},this._indexByCustom={},this._updateLength(),t.each(e,this.add,this)};t.extend(n.prototype,{add:function(e,t){var n=e.cid;this._views[n]=e,e.model&&(this._indexByModel[e.model.cid]=n),t&&(this._indexByCustom[t]=n),this._updateLength()},findByModel:function(e){return this.findByModelCid(e.cid)},findByModelCid:function(e){var t=this._indexByModel[e];return this.findByCid(t)},findByCustom:function(e){var t=this._indexByCustom[e];return this.findByCid(t)},findByIndex:function(e){return t.values(this._views)[e]},findByCid:function(e){return this._views[e]},remove:function(e){var n=e.cid;e.model&&delete this._indexByModel[e.model.cid],t.any(this._indexByCustom,function(e,t){if(e===n)return delete this._indexByCustom[t],!0},this),delete this._views[n],this._updateLength()},call:function(e){this.apply(e,t.tail(arguments))},apply:function(e,n){t.each(this._views,function(r){t.isFunction(r[e])&&r[e].apply(r,n||[])})},_updateLength:function(){this.length=t.size(this._views)}});var r=["forEach","each","map","find","detect","filter","select","reject","every","all","some","any","include","contains","invoke","toArray","first","initial","rest","last","without","isEmpty","pluck"];return t.each(r,function(e){n.prototype[e]=function(){var n=t.values(this._views),r=[n].concat(t.toArray(arguments));return t[e].apply(t,r)}}),n}(e,_)});