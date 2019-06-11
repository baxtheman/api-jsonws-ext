;console.log('api-json-ext by @baxtheman');
;
(function () {
    AUI().applyConfig({
        groups : {
            apijsonext : {
                base : MODULE_PATH + '/js/',
                combine : Liferay.AUI.getCombine(),
                modules : {
                    'clipboard' : {
                        path : 'clipboard.min.js'
                    },
                    'run_prettify_css' : {
                        type: 'css',
                        path : 'prettify.css'
                    },
                    'run_prettify' : {
                        path : 'prettify.js',
                        requires: ['run_prettify_css']
                    },
                    'local-storage-fallback' : {
                        path : 'local-storage-fallback.min.js'
                    }
                },
                root : MODULE_PATH + '/js/'
            }
        }
    });
})();