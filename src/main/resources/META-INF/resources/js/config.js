;
(function() {
	AUI().applyConfig({
		groups : {
			apijsonext : {
				base : MODULE_PATH + '/js/',
				combine : Liferay.AUI.getCombine(),
				modules : {
					'clipboard' : {
						path : 'clipboard.min.js'
					},
					'run_prettify' : {
						path : 'run_prettify.min.js'
					}
				},
				root : MODULE_PATH + '/js/'
			}
		}
	});
})();