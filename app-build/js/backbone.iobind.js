/*!
   * backbone.iobind - Model
   * Copyright(c) 2011 Jake Luer <jake@alogicalparadox.com>
   * MIT Licensed
   */

/*!
   * Version
   */

/*!
   * backbone.iobind - Collection
   * Copyright(c) 2011 Jake Luer <jake@alogicalparadox.com>
   * MIT Licensed
   */

define("backbone.iobind",["backbone","backbone.iosync"],function(e){var t,n,e,r;return typeof window=="undefined"||typeof require=="function"?(n=require("jquery"),t=require("underscore"),e=require("backbone"),r=e,typeof module!="undefined"&&(module.exports=r)):(n=this.$,t=this._,e=this.Backbone,r=this),e.Model.prototype.ioBindVersion="0.4.6",e.Model.prototype.ioBind=function(t,n,r,i){var s=this._ioEvents||(this._ioEvents={}),o=this.url()+":"+t,u=this;"function"==typeof n&&(i=r,r=n,n=this.socket||window.socket||e.socket);var a={name:t,global:o,cbLocal:r,cbGlobal:function(){var e=[t];e.push.apply(e,arguments),u.trigger.apply(u,e)}};return this.bind(a.name,a.cbLocal,i||u),n.on(a.global,a.cbGlobal),s[a.name]?s[a.name].push(a):s[a.name]=[a],this},e.Model.prototype.ioUnbind=function(n,r,i){var s=this._ioEvents||(this._ioEvents={}),o=this.url()+":"+n;"function"==typeof r&&(i=r,r=this.socket||window.socket||e.socket);var u=s[n];if(!t.isEmpty(u)){if(i&&"function"==typeof i){for(var a=0,f=u.length;a<f;a++)i==u[a].cbLocal&&(this.unbind(u[a].name,u[a].cbLocal),r.removeListener(u[a].global,u[a].cbGlobal),u[a]=!1);u=t.compact(u)}else this.unbind(n),r.removeAllListeners(o);u.length===0&&delete s[n]}return this},e.Model.prototype.ioUnbindAll=function(t){var n=this._ioEvents||(this._ioEvents={});t||(t=this.socket||window.socket||e.socket);for(var r in n)this.ioUnbind(r,t);return this},e.Collection.prototype.ioBindVersion="0.4.6",e.Collection.prototype.ioBind=function(t,n,r,i){var s=this._ioEvents||(this._ioEvents={}),o=this.url+":"+t,u=this;"function"==typeof n&&(i=r,r=n,n=this.socket||window.socket||e.socket);var a={name:t,global:o,cbLocal:r,cbGlobal:function(){var e=[t];e.push.apply(e,arguments),u.trigger.apply(u,e)}};return this.bind(a.name,a.cbLocal,i),n.on(a.global,a.cbGlobal),s[a.name]?s[a.name].push(a):s[a.name]=[a],this},e.Collection.prototype.ioUnbind=function(n,r,i){var s=this._ioEvents||(this._ioEvents={}),o=this.url+":"+n;"function"==typeof r&&(i=r,r=this.socket||window.socket||e.socket);var u=s[n];if(!t.isEmpty(u)){if(i&&"function"==typeof i){for(var a=0,f=u.length;a<f;a++)i==u[a].cbLocal&&(this.unbind(u[a].name,u[a].cbLocal),r.removeListener(u[a].global,u[a].cbGlobal),u[a]=!1);u=t.compact(u)}else this.unbind(n),r.removeAllListeners(o);u.length===0&&delete s[n]}return this},e.Collection.prototype.ioUnbindAll=function(t){var n=this._ioEvents||(this._ioEvents={});t||(t=this.socket||window.socket||e.socket);for(var r in n)this.ioUnbind(r,t);return this},e});