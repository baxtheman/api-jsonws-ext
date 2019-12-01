package it.baxtheman.liferay.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.BaseFilter;

@Component(immediate = true, property = {
		"servlet-context-name=",
		"servlet-filter-name=ApiJsonwsFilter",
		"url-pattern=/api/jsonws/invoke/*" },
	service = Filter.class)
public class ApiJsonwsFilter extends BaseFilter {

	@Activate
	void activate() {

		_log.info("init");
	}

	@Deactivate
	void deactivate() {
	}

	@Override
	protected void processFilter(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws Exception {

		String cmd = request.getParameter("cmd");

		if (_log.isDebugEnabled()) {

			_log.debug("ApiJsonwsFilter " + cmd);
		}

		super.processFilter(request, response, filterChain);
	}

	@Override
	protected Log getLog() {
		return _log;
	}

	private static final Log _log = LogFactoryUtil.getLog(ApiJsonwsFilter.class);
}
