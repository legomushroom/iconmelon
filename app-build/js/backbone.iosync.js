/*!
   * backbone.iobind - Backbone.sync replacement
   * Copyright(c) 2011 Jake Luer <jake@alogicalparadox.com>
   * MIT Licensed
   */

define("backbone.iosync",["backbone","socketio"],function(e){var t,n,e,r;typeof window=="undefined"||typeof require=="function"?(n=require("jquery"),t=require("underscore"),e=require("backbone"),r=e,typeof module!="undefined"&&(module.exports=r)):(n=this.$,t=this._,e=this.Backbone,r=this),e.sync=function(r,s,o){var u=t.extend({},o);u.url?u.url=t.result(u,"url"):u.url=t.result(s,"url")||i();var a=u.url.split("/"),f=a[0]!==""?a[0]:a[1];!u.data&&s&&(u.data=u.attrs||s.toJSON(o)||{}),u.patch===!0&&u.data.id==null&&s&&(u.data.id=s.id);var l=s.socket||e.socket||window.socket,c=n.Deferred();l.emit(f+":"+r,u.data,function(e,t){e?(o.error&&o.error(e),c.reject()):(o.success&&o.success(t),c.resolve())});var h=c.promise();return s.trigger("request",s,h,o),h};var i=function(){throw new Error('A "url" property or function must be specified')}});