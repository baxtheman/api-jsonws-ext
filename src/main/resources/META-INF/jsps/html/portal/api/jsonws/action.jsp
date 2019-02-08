

<%@ include file="/html/portal/api/jsonws/init.jsp" %>

<%
String signature = ParamUtil.getString(request, "signature");
%>

<c:choose>
	<c:when test="<%= Validator.isNotNull(signature) %>">

		<%
		JSONWebServiceActionMapping jsonWebServiceActionMapping = JSONWebServiceActionsManagerUtil.getJSONWebServiceActionMapping(signature);
		%>

		<h2 class="method-path mb-3"><%= jsonWebServiceActionMapping.getPath() %></h2>

		<p>
			<a class="btn btn-default" data-toggle="collapse"
				href="#collapseExample" role="button" aria-expanded="false"
				aria-controls="collapseExample"> Read method details </a>
		</p>
		<div class="collapse" id="collapseExample">
			<div class="card card-body">

			<%@ include file="/html/portal/api/jsonws/details.jspf" %>

			</div>
		</div>

		<div class="lfr-api-execute lfr-api-section">
			<h3><liferay-ui:message key="execute" /></h3>

			<%
			String enctype = StringPool.BLANK;

			for (MethodParameter methodParameter : methodParameters) {
				Class<?> methodParameterTypeClass = methodParameter.getType();

				if (methodParameterTypeClass.equals(File.class)) {
					enctype = "multipart/form-data";

					break;
				}
			}
			%>

			<aui:script>
				Liferay.TPL_DATA_TYPES = {
					array: {},
					file: {},
					other: {},
					string: {}
				};
			</aui:script>

			<aui:form action="<%= jsonWSPath + jsonWebServiceActionMapping.getPath() %>" enctype="<%= enctype %>" method="<%= jsonWebServiceActionMapping.getMethod() %>" name="execute">

				<%
				if (PropsValues.JSON_SERVICE_AUTH_TOKEN_ENABLED) {
				%>

					<aui:input id='<%= "field" + methodParameters.length %>' label="p_auth" name="p_auth" readonly="true" suffix="String" value="<%= AuthTokenUtil.getToken(request) %>" />

				<%
				}

				for (int i = 0; i < methodParameters.length; i++) {
					MethodParameter methodParameter = methodParameters[i];

					String methodParameterName = methodParameter.getName();

					if (methodParameterName.equals("serviceContext")) {
						continue;
					}

					Class<?> methodParameterTypeClass = methodParameter.getType();

					String methodParameterTypeClassName = null;

					if (methodParameterTypeClass.isArray()) {
						methodParameterTypeClassName = methodParameterTypeClass.getComponentType() + "[]";
					}
					else {
						methodParameterTypeClassName = methodParameterTypeClass.getName();
					}

					if (methodParameterTypeClass.equals(File.class)) {
				%>

						<aui:input id='<%= "field" + i %>' label="<%= methodParameterName %>" name="<%= methodParameterName %>" suffix="<%= methodParameterTypeClassName %>" type="file" />

					<%
					}
					else if (methodParameterTypeClass.equals(boolean.class) || methodParameterTypeClass.equals(Boolean.class)) {
					%>

						<aui:field-wrapper label="<%= methodParameterName %>">
							<aui:input checked="<%= true %>" id='<%= "fieldTrue" + i %>' inlineField="<%= true %>" label="<%= Boolean.TRUE.toString() %>" name="<%= methodParameterName %>" type="radio" value="<%= true %>" />

							<aui:input id='<%= "fieldFalse" + i %>' inlineField="<%= true %>" label="<%= Boolean.FALSE.toString() %>" name="<%= methodParameterName %>" type="radio" value="<%= false %>" />

							<span class="suffix"><%= methodParameterTypeClassName %></span>
						</aui:field-wrapper>

					<%
					}
					else if (methodParameterTypeClass.isArray() || methodParameterTypeClass.isEnum() || methodParameterTypeClass.isPrimitive() || methodParameterTypeClass.equals(Byte.class) || methodParameterTypeClass.equals(Character.class) || methodParameterTypeClass.equals(Date.class) || methodParameterTypeClass.equals(Double.class) || methodParameterTypeClass.equals(Float.class) || methodParameterTypeClass.equals(Integer.class) || methodParameterTypeClass.equals(List.class) || methodParameterTypeClass.equals(Locale.class) || methodParameterTypeClass.equals(Long.class) || methodParameterTypeClass.equals(Map.class) || methodParameterTypeClass.equals(Short.class) || methodParameterTypeClass.equals(String.class) || methodParameterTypeClass.equals(Void.class)) {
						int size = 10;

						if (methodParameterTypeClass.equals(String.class)) {
							size = 60;
						}
					%>

						<aui:input id='<%= "field" + i %>' label="<%= methodParameterName %>" name="<%= methodParameterName %>" size="<%= size %>" suffix="<%= methodParameterTypeClassName %>" />

					<%
					}
					else {
						String objectMethodParameterName = "+" + methodParameterName;
						int size = 10;
					%>

						<aui:input id='<%= "field" + i %>' label="<%= methodParameterName %>" name="<%= objectMethodParameterName %>" size="<%= size %>" suffix="<%= methodParameterTypeClassName %>" />

					<%
					}
					%>

					<aui:script>

						<%
						String jsObjectType = "other";

						if (methodParameterTypeClass.isArray()) {
							jsObjectType = "array";
						}
						else if (methodParameterTypeClass.equals(File.class)) {
							jsObjectType = "file";
						}
						else if (methodParameterTypeClass.equals(String.class)) {
							jsObjectType = "string";
						}
						%>

						Liferay.TPL_DATA_TYPES['<%= jsObjectType %>']['<%= methodParameterName %>'] = true;

					</aui:script>

				<%
				}
				%>

				<aui:button type="submit" value="invoke" />
			</aui:form>

			<div class="hide mt-3 lfr-api-results" id="serviceResults">
				<liferay-ui:tabs
					names="result,javascript-example,curl-example,url-example"
					refresh="<%= false %>"
				>
					<liferay-ui:section>
						<button title="copy to clipboard" id="copy-clipboard" class="btn copy-clipboard" data-clipboard-target="#serviceOutput">
							<i class="icon-copy"></i>
						</button>

						<pre class="prettyprint linenums lang-js lfr-code-block" id="serviceOutput"></pre>
					</liferay-ui:section>

					<liferay-ui:section>
						<button title="copy to clipboard" id="copy-clipboard" class="btn copy-clipboard" data-clipboard-target="#jsExample">
							<i class="icon-copy"></i>
						</button>

						<pre class="prettyprint lfr-code-block" id="jsExample"></pre>
					</liferay-ui:section>

					<liferay-ui:section>
						<pre class="lfr-code-block" id="curlExample"></pre>
					</liferay-ui:section>

					<liferay-ui:section>
						<pre class="lfr-code-block" id="urlExample"></pre>
					</liferay-ui:section>
				</liferay-ui:tabs>
			</div>
		</div>

		<aui:script use="aui-io,aui-template-deprecated,querystring-parse,clipboard,run_prettify">

			new ClipboardJS('.copy-clipboard');

			var REGEX_QUERY_STRING = new RegExp('([^?=&]+)(?:=([^&]*))?', 'g');

			var form = A.one('#execute');

			var tplDataTypes = Liferay.TPL_DATA_TYPES;

			var multipart = !A.Object.isEmpty(tplDataTypes.file);

			var curlTpl = A.Template.from('#curlTpl');

			var scriptTpl = A.Template.from('#scriptTpl');
			var urlTpl = A.Template.from('#urlTpl');

			var arrayType = tplDataTypes.array;
			var fileType = tplDataTypes.file;
			var stringType = tplDataTypes.string;

			var formatDataType = function(key, value, includeNull) {
				value = decodeURIComponent(value.replace(/\+/g, ' '));
				value = escape(value);

				if (fileType[key]) {
					value = 'null';
				}
				else if (stringType[key]) {
					value = '\'' + value + '\'';
				}
				else if (arrayType[key]) {
					if (!value && includeNull) {
						value = 'null';
					}
					else if (value) {
						value = '[' + value + ']';
					}
				}

				return value;
			};

			var formatCurlDataType = function(key, value, includeNull) {
				var filePath = fileType[key];

				if (!multipart || !filePath) {
					value = formatDataType(key, value, includeNull);
				}
				else {
					value = '@path_to_file';
				}

				return value;
			};

			curlTpl.formatDataType = formatCurlDataType;
			scriptTpl.formatDataType = A.rbind(formatDataType, scriptTpl, true);

			urlTpl.toURIParam = function(value) {
				value = A.Lang.String.uncamelize(value, '-');

				return value.toLowerCase();
			};

			var curlExample = A.one('#curlExample');
			var jsExample = A.one('#jsExample');
			var urlExample = A.one('#urlExample');

			var serviceOutput = A.one('#serviceOutput');
			var serviceResults = A.one('#serviceResults');

			form.on(
				'submit',
				function(event) {
					event.halt();

					var output = A.all([curlExample, jsExample, urlExample, serviceOutput]);

					output.empty().addClass('loading-results');

					var formEl = form.getDOM();

					var formQueryString = A.IO.prototype._serialize(formEl);

					var query_elements = formQueryString.split("&");

					var PLUS_ENCODING = "%2B";
					var MINUS_ENCODING = "%2D";

					for (var i = 0 ; i < query_elements.length ; i++) {
						var query_map = query_elements[i].split("=");

						var key = query_map[0];

						var plus_bool = ((key.indexOf(PLUS_ENCODING) == 0) || (key.indexOf("+") == 0));
						var minus_bool = ((key.indexOf(MINUS_ENCODING) == 0) || (key.indexOf("-") == 0));

						if (plus_bool || minus_bool) {
							var value = "";

							for (var j = 1; j < query_map.length ; j++) {
								value += query_map[j];
							}

							if (value.length > 0) {
								if (minus_bool) {
									key = key.replace(MINUS_ENCODING,"-");
									var node = A.one('[name=' + key + ']');

									key = key.replace("-", "+");
									node.attr("name", key);
								}
							}
							else if (plus_bool) {
								key = key.replace(PLUS_ENCODING,"+");
								var node = A.one('[name=' + key + ']');

								key = key.replace("+", "-");
								node.attr("name", key);
							}
						}
					}

					formEl = form.getDOM();

					Liferay.Service(
						'<%= jsonWebServiceActionMapping.getPath() %>',
						formEl,
						function(obj) {
							serviceOutput.html(PR.prettyPrintOne(A.Lang.String.escapeHTML(JSON.stringify(obj, null, 2))));

							output.removeClass('loading-results');

							location.hash = '#serviceResults';
						}
					);

					formQueryString = A.IO.prototype._serialize(formEl);

					formQueryString = formQueryString.replace(PLUS_ENCODING, "+");
					formQueryString = formQueryString.replace(MINUS_ENCODING, "-");

					if (multipart) {
						formQueryString += Object.keys(tplDataTypes.file).map(
							function(item, index) {
								return '&' + item + '=';
							}
						).join('');
					}

					var curlData = [];
					var scriptData = [];

					var ignoreFields = {
						formDate: true,
						p_auth: true
					};

					formQueryString.replace(
						REGEX_QUERY_STRING,
						function(match, key, value) {
							if (!ignoreFields[key]) {
								curlData.push(
									{
										key: key,
										value: value
									}
								);

								scriptData.push(
									{
										key: key,
										value: value
									}
								);
							}
						}
					);

					var tplCurlData = {
						data: curlData,
						flag: multipart ? 'F' : 'd'
					};

					var tplScriptData = {
						data: scriptData
					};

					curlTpl.render(tplCurlData, curlExample);
					scriptTpl.render(tplScriptData, jsExample);

					var urlTplData = {
						data: [],
						extraData: []
					};

					var extraFields = {
						p_auth: true
					};

					formQueryString.replace(
						REGEX_QUERY_STRING,
						function(match, key, value) {
							if (!ignoreFields[key]) {
								if (extraFields[key]) {
									urlTplData.extraData.push(
										{
											key: key,
											value: value
										}
									);
								}
								else {
									urlTplData.data.push(
										{
											key: key,
											value: value
										}
									);

								}
							}
						}
					);

					urlTpl.render(urlTplData, urlExample);

					serviceResults.show();
				}
			);
		</aui:script>

		<textarea class="hide" id="scriptTpl">
Liferay.Service(
  '<%= jsonWebServiceActionMapping.getPath() %>',
  <tpl if="data.length">{
<%= StringPool.FOUR_SPACES %><tpl for="data">{key}: {[this.formatDataType(values.key, values.value)]}<tpl if="!$last">,
<%= StringPool.FOUR_SPACES %></tpl></tpl>
  },
  </tpl>function(obj) {
<%= StringPool.FOUR_SPACES %>console.log(obj);
  }
);
		</textarea>

		<textarea class="hide" id="curlTpl">
curl <%= themeDisplay.getPortalURL() + jsonWSPath + jsonWebServiceActionMapping.getPath() %> \\
  -u test@liferay.com:test <tpl if="data.length">\\
  <tpl for="data">-{parent.flag} {key}={[this.formatDataType(values.key, values.value)]} <tpl if="!$last">\\
  </tpl></tpl></tpl>
		</textarea>

		<textarea class="hide" id="urlTpl">
<%= themeDisplay.getPortalURL() + jsonWSPath + jsonWebServiceActionMapping.getPath() %><tpl if="data.length">/<tpl for="data">{key:this.toURIParam}<tpl if="value.length">/{value}</tpl><tpl if="!$last">/</tpl></tpl></tpl><tpl if="extraData.length">?<tpl for="extraData">{key:this.toURIParam}={value}<tpl if="!$last">&amp;</tpl></tpl></tpl>
		</textarea>
	</c:when>
	<c:otherwise>
		<div class="alert alert-info">
			<liferay-ui:message key="please-select-a-method-on-the-left" />
		</div>
	</c:otherwise>
</c:choose>