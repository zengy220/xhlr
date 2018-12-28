function showTopLink() {
    if($('ft')){
        var viewPortHeight = parseInt(document.documentElement.clientHeight);
        var scrollHeight = parseInt(document.body.getBoundingClientRect().top);
        var basew = parseInt($('ft').clientWidth);
        var sw = $('#scrolltop').clientWidth;
        if (basew < 1000) {
                var left = parseInt(fetchOffset($('ft'))['left']);
                left = left < sw ? left * 2 - sw : left;
                $('#scrolltop').css("left",( basew + left ) + 'px');
        } else {
                $('#scrolltop').css("left",'auto');
                $('#scrolltop').css("right",0);
        }
		var browser=navigator.appName;
		var b_version=navigator.appVersion;
		var version=b_version.split(";");
		var trim_Version=version[0].replace(/[ ]/g,"");
        if (browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0") {
        	$('#scrolltop').style.top = viewPortHeight - scrollHeight - 150 + 'px';
        }
        if (scrollHeight < -100) {
        	$('#scrolltop').css("visibility","visible");
        } else {
        	$('#scrolltop').css("visibility","hidden");
        }
    }
}
function _attachEvent(obj, evt, func, eventobj) {
	eventobj = !eventobj ? obj: eventobj;
	if (obj.addEventListener) {
		obj.addEventListener(evt, func, false);
	}else if(eventobj.attachEvent) {
		obj.attachEvent('on' + evt, func);
	}
}