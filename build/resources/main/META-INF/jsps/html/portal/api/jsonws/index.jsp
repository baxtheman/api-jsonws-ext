
<%@ include file="/html/portal/api/jsonws/init.jsp" %>

<c:if test="<%= themeDisplay.getPermissionChecker().isOmniadmin() || PropsValues.JSONWS_WEB_SERVICE_API_DISCOVERABLE %>">
	<style>
		<%@ include file="/html/portal/api/jsonws/css.jspf" %>
	</style>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.0/clipboard.min.js"></script>

	<div id="wrapper">
		<header id="banner" role="banner">
			<div id="heading">
				<h1 class="site-title">
					<a class="logo"
						href="<%=HtmlUtil.escapeAttribute(jsonWSContextPath)%>"
						title="JSONWS API">

						<img height="50px" src="<%=HtmlUtil.escape(themeDisplay.getCompanyLogo())%>">
					</a>
					<span class="site-name"> JSONWS API </span>
				</h1>
			</div>
		</header>

		<div id="content">
			<div id="main-content">
				<aui:row>
					<aui:col cssClass="lfr-api-navigation" width="<%= 25 %>">
						<liferay-util:include page="/html/portal/api/jsonws/actions.jsp" />
					</aui:col>

					<aui:col cssClass="lfr-api-details" width="<%= 75 %>">
						<liferay-util:include page="/html/portal/api/jsonws/action.jsp" />
					</aui:col>
				</aui:row>
			</div>
		</div>

		<footer>
			<liferay-ui:message key="powered-by" /> <a href="https://twitter.com/baxtheman" rel="external">Liferay & @baxtheman</a>
		</footer>
	</div>
</c:if>