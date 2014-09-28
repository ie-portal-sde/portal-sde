var deployJava = {
    debug: null,
    returnPage: null,
    brand: null,
    locale: null,
    installType: null,
    getJavaURL: 'http://java.sun.com/webapps/getjava/BrowserRedirect?host=java.com',
    oldMimeType: 'application/npruntime-scriptable-plugin;DeploymentToolkit',
    mimeType: 'application/java-deployment-toolkit',
    isPluginInstalled: function() {
        var plugin = deployJava.getPlugin();
        if (plugin && plugin.jvms) {
            return true;
        } else {
            return false;
        }
    },
    getPlugin: function() {
        deployJava.refresh();
        var ret = document.getElementById('deployJavaPlugin');
        return ret;
    },
    getBrowser: function() {
        var browser = navigator.userAgent.toLowerCase();
        if (deployJava.debug) {
            alert('userAgent -> ' + browser);
        }
        if ((navigator.vendor) && 
            (navigator.vendor.toLowerCase().indexOf('apple') != -1) &&
            (browser.indexOf('safari') != -1)) {
            if (deployJava.debug) {
                alert('We claim to have detected "Safari".');
            }
            return 'Safari';
        } else if (browser.indexOf('msie') != -1) {
            if (deployJava.debug) {
                alert('We claim to have detected "IE".');
            }
            return 'MSIE';
        } else if ((browser.indexOf('mozilla') != -1) || 
                   (browser.indexOf('firefox') != -1)) {
            if (deployJava.debug) {
                alert('We claim to have detected a Netscape family browser.');
            }
            return 'Netscape Family';
        } else {
            if (deployJava.debug) {
                alert('We claim to have failed to detect a browser.');
            }
            return '?';
        }
    },
    IEInstall: function(javaUrl) {
         location.href = javaUrl;
         return false;
    },  
    writePluginTag: function() {
        var browser = deployJava.getBrowser();
        if (browser == 'MSIE') {
            document.write('<' + 
                'object classid="clsid:CAFEEFAC-DEC7-0000-0000-ABCDEFFEDCBA" ' +
                'id="deployJavaPlugin" width="0" height="0">' +
                '<' + '/' + 'object' + '>');
        } else if (browser == 'Netscape Family') {
            if (navigator.mimeTypes != null) for (var i=0; 
                    i < navigator.mimeTypes.length; i++) {
                if (navigator.mimeTypes[i].type == deployJava.mimeType) {
                    if (navigator.mimeTypes[i].enabledPlugin) {
                        document.write('<' + 
                            'embed id="deployJavaPlugin" type="' + 
                            deployJava.mimeType + '" hidden="true" />');
                    }
                }
           }
        }
    },
    refresh: function() {
        navigator.plugins.refresh(false);

        var browser = deployJava.getBrowser();
        if (browser == 'Netscape Family') {
            var plugin = document.getElementById('deployJavaPlugin');
            // only do this again if no plugin
            if (plugin == null) {
                if (navigator.mimeTypes != null) for (var i=0;
                    i < navigator.mimeTypes.length; i++) {
                    if (navigator.mimeTypes[i].type == deployJava.mimeType) {
                        if (navigator.mimeTypes[i].enabledPlugin) {
                            document.write('<' +
                                'embed id="deployJavaPlugin" type="' +
                                deployJava.mimeType + '" hidden="true" />');
                        }
                    }
               }
            }
        }
    },
    do_initialize: function() {
        deployJava.writePluginTag();
        if (deployJava.locale == null) {
            var loc = null;

            if (loc == null) try {
                loc = navigator.userLanguage;
            } catch (err) { }

            if (loc == null) try {
                loc = navigator.systemLanguage;
            } catch (err) { }
    
            if (loc == null) try {
                loc = navigator.language;
            } catch (err) { }
    
            if (loc != null) {
                loc.replace("-","_")
                deployJava.locale = loc;
            }
        }
    }   
};
deployJava.do_initialize();


