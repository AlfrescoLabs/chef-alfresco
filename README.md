chef-alfresco
---
<img align="left" src="chef-alfresco-logo.png" alt="Chef Alfresco Logo" title="Chef Alfresco Logo"/>

[![Build Status](https://travis-ci.org/Alfresco/chef-alfresco.svg)](https://travis-ci.org/Alfresco/chef-alfresco)

chef-alfresco is a Chef cookbook that provides a modular, configurable and extensible way to install an Alfresco node/stack; `alfresco::default` parses `node['alfresco']['components']` and includes other `alfresco::*` recipes accordingly.

It is tested on Centos 7.x and Ubuntu 14.04 (soon on Centos 6.7)

To know more about attribute definition and overriding, check [CHEF-ATTRIBUTES.md](CHEF-ATTRIBUTES.md)
To get a list of packaged installed, their sources and versions, check [PACKAGES.md](PACKAGES.md)

[Graph of cookbooks dependencies](http://berksgraph.tolleiv.de/grph?1453651870699#2016-01-24-6ead5d913f1442303236b555f017a1afebc4a4ec.js)


How to contribute
---
To avoid any problem on master, we are implementing git-flow.
To contribute, follow this:

1. Fork this repository
2. Make your changes
3. Test your changes
4. Make a pull request to alfresco/develop


Credits
---
This project is a fork of the original [chef-alfresco](https://github.com/fnichol/chef-alfresco) developed by [Fletcher Nichol](https://github.com/fnichol); the code have been almost entirely rewritten, however the original implementation still works with Community 4.0.x versions and provides a different approach to Alfresco installation (using Alfresco Linux installer).

A big thanks to Nichol for starting this effort!

License and Author
---
Copyright 2016, Alfresco

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
