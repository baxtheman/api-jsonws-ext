# `/api/jsonws extender`

Are you tired of the old api jsonws page? Take this new one with some extra features:

* Compact design, fluid layout, method details with accordion
* JSON result sintax highlight
* Fast clipboard copy
* Recall for previous call parameters (using local storage)
* Print call elapsed time and response chars size
* View current user (logged or guest)
* View Liferay.Service results from success or error callback function
* 'Javascript Example' page with the complete schema

Tested on Liferay 7.1.x & 7.2.0 CE

[Available in the Liferay marketplace](https://web.liferay.com/it/marketplace/-/mp/application/125100800)

[Download the bundle jar for 7.1](https://github.com/baxtheman/api-jsonws-ext/releases/download/7.1.0.5/it.baxtheman.liferay.apijsonwsext-7.1.0.5.jar)

[Download the bundle jar for 7.2](https://github.com/baxtheman/api-jsonws-ext/releases/download/7.2.0.5/it.baxtheman.liferay.apijsonwsext-7.2.0.5.jar)

See the old page and the new one:

![Old to new](/doc/new.gif)

View current user (logged or guest)

![user](/doc/user.jpg)

View Liferay.Service results from success or error callback function.

![success error](/doc/success-error.jpg)

'Javascript Example' page with the complete schema

![api](/doc/api-sample.jpg)

## Roadmap

* Fast switch to change `com.liferay.portal.jsonwebservice` package log level
* Extend the history feature to save several call params

## Previous version

It's still available the same plugin for Liferay 6.2 [here](https://github.com/baxtheman/mqtt-liferay-plugins/tree/master/base-services-portlet)

## Credits

* [Clipboard.js by Zeno](https://github.com/zenorocha/clipboard.js/) (Why it's not bundled in AlloyUI?)
* [JavaScript code prettifier](https://github.com/google/code-prettify)
* [local-storage-fallback](https://www.npmjs.com/package/local-storage-fallback)

License
-------

This library, *api-jsonws-ext*, is free software ("Licensed Software"); you can
redistribute it and/or modify it under the terms of the [GNU Lesser General
Public License](http://www.gnu.org/licenses/lgpl-2.1.html) as published by the
Free Software Foundation; either version 2.1 of the License, or (at your
option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; including but not limited to, the implied warranty of MERCHANTABILITY,
NONINFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General
Public License for more details.

You should have received a copy of the [GNU Lesser General Public
License](http://www.gnu.org/licenses/lgpl-2.1.html) along with this library; if
not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth
Floor, Boston, MA 02110-1301 USA
