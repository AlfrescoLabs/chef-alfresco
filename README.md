# Description

Installs Alfresco Community Edition.

# Requirements

## Chef

Tested on 0.10.2 and 0.10.4 but newer and older version should work just fine.
File an [issue][issues] if this isn't the case.

## Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

* ubuntu

Please [report][issues] any additional platforms so they can be added.

## Cookbooks

This cookbook depends on the following external cookbooks:

* [database][database_cb] (Opscode)
* [imagemagick][imagemagick_cb] (Opscode)
* [java][java_cb] (Opscode)
* [mysql][mysql_cb] (Opscode)
* [openoffice][openoffice_cb]
* [swftools][swftools_cb]
* [tomcat][tomcat_cb] (Opscode)

# Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

## From the Opscode Community Platform

To install this cookbook from the Opscode platform, use the *knife* command:

    knife cookbook site install alfresco

## Using Librarian

The [Librarian][librarian] gem aims to be Bundler for your Chef cookbooks.
Include a reference to the cookbook in a **Cheffile** and run
`librarian-chef install`. To install with Librarian:

    gem install librarian
    cd chef-repo
    librarian-chef init
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'openoffice',
      :git => 'git://github.com/fnichol/chef-alfresco.git', :ref => 'v0.2.0'
    END_OF_CHEFFILE
    librarian-chef install

## Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install fnichol/chef-alfresco/v0.2.0

## As a Git Submodule

A common practice (which is getting dated) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/fnichol/chef-alfresco.git cookbooks/alfresco
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

## As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/fnichol/chef-alfresco/tarball/v0.2.0 | tar xfz - && \
      mv fnichol-chef-alfresco-* alfresco

# Usage

Coming soon...

# Recipes

## default

Installs Alfresco Community Edition.

# Attributes

Coming soon...

# Resources and Providers

There are **no** resources and providers in this cookbook.

# Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

# License and Author

Author:: Fletcher Nichol (<fnichol@nichol.ca>)

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[chef_repo]:      https://github.com/opscode/chef-repo
[database_cb]:    http://community.opscode.com/cookbooks/database
[imagemagick_cb]: http://community.opscode.com/cookbooks/imagemagick
[java_cb]:        http://community.opscode.com/cookbooks/java
[kgc]:            https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:      https://github.com/applicationsonline/librarian#readme
[mysql_cb]:       http://community.opscode.com/cookbooks/mysql
[openoffice_cb]:  http://community.opscode.com/cookbooks/openoffice
[tomcat_cb]:      http://community.opscode.com/cookbooks/tomcat
[swftools_cb]:    http://community.opscode.com/cookbooks/swftools

[repo]:         https://github.com/fnichol/chef-alfresco
[issues]:       https://github.com/fnichol/chef-alfresco/issues
