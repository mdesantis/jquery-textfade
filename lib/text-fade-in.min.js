/*!
TextFadeIn v 1.0.0
https://github.com/mdesantis/TextFadeIn

Includes parts of Sizzle.js
http://sizzlejs.com/

Copyright 2013 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/TextFadeIn/LICENSE
*/
(function(){var t;t=function(){function t(t,e,i){var r,s;this.element=t,null!=i?this.text=null!=e?e:n(this.element):"object"==typeof e?(this.text=n(this.element),i=e):(this.text=null!=e?e:n(this.element),i={}),this.milliseconds=null!=(r=i.milliseconds)?r:1,this.threads=null!=(s=i.threads)?s:1,this.sequence=i.sequence,this.start=i.start,this.complete=i.complete}var e,n,i,r,s,l,o;return e=/[^\n]/g,l=function(t){var e,n,i;for(e=t.length;e;)n=Math.floor(Math.random()*e),i=t[--e],t[e]=t[n],t[n]=i;return t},i=function(t){var e;return l(function(){e=[];for(var n=0;t>=0?t>=n:n>=t;t>=0?n++:n--)e.push(n);return e}.apply(this))},r=function(t,e,i){var r,l,o;return l=i.shift(),o=n(t),r=e.charAt(l),s(t,""+o.substr(0,l)+r+o.substr(l+r.length))},n=function(t){var e,i,r,s,l;if(r="",i=t.nodeType){if(1===i||9===i||11===i){if("string"==typeof t.textContent)return t.textContent;if(t=t.firstChild)for(r+=n(t);t=t.nextSibling;)r+=n(t)}else if(3===i||4===i)return t.nodeValue}else for(s=0,l=t.length;l>s;s++)e=t[s],r+=n(e);return r},s=function(t,e){for(;t.hasChildNodes();)t.removeChild(t.lastChild);return t.appendChild(t.ownerDocument.createTextNode(e))},o=function(t,e,n,i,s,l){var o,u;for(o=u=1;i>=1?i>=u:u>=i;o=i>=1?++u:--u){if(0===n.length)return window.clearInterval(s),"function"==typeof l&&l(),!0;r(t,e,n)}},t.prototype.run=function(){var t,n,r,l=this;return null==this.sequence&&(this.sequence=i(this.text.length)),r=this.sequence.slice(0),t=this.text.replace(e," "),s(this.element,t),n=window.setInterval(function(){return o(l.element,l.text,r,l.threads,n,l.complete)},this.milliseconds),!0},t}(),window.TextFadeIn=t}).call(this);