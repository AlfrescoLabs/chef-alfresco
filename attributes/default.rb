#######################################
# Chef Alfresco Components and Features
#######################################

# Alfresco components that are not enabled by default:
# spp - Sharepoint protocol (AMP)
# aos - Alfresco Office Services (WARs); enterprise-only
# rsyslog - Remote logging
#
# Default Alfresco components
# 
default['alfresco']['components'] = ['haproxy','nginx','tomcat','transform','repo','share','solr','mysql','rm','googledocs']

# Alfresco version; you can use Enterprise versions, ie. '5.0.1'
default['alfresco']['groupId'] = "org.alfresco"
default['alfresco']['version'] = "5.0.d"

#Generates alfresco-global.properties using all node['alfresco']['properties'] key/value attributes
default['alfresco']['generate.global.properties'] = true

#Generates share-config-custom.xml using a pre-defined template (check templates/default) and configuring http endpoint and disabling CSRF
default['alfresco']['generate.share.config.custom'] = true

#Generates repo-log4j.properties using all node['alfresco']['repo-log4j'] key/value attributes
default['alfresco']['generate.repo.log4j.properties'] = true

#Patches an existing share-config-custom.xml using node['alfresco']['properties'] key/value attributes and replacing all @@key@@ occurrencies
#Note! To enable this, you must provide your own share-config-custom.xml in
# #{node['alfresco']['shared']}/classes/alfresco/web-extension/share-config-custom.xml
default['alfresco']['patch.share.config.custom'] = false

#License defaults
default['alfresco']['license_source'] = 'alfresco-license'
default['alfresco']['license_cookbook'] = 'alfresco'

#Mysql (custom) defaults
default['mysql']['update_gcc'] = true

# Used in run-chef-client
default['hosts']['hostname'] = node['hostname'] ? node['hostname'] : 'localhost'
default['hosts']['domain'] = node['domain'] ? node['domain'] : 'localdomain'

# Java defaults
default["java"]["default"]                                 = true
default["java"]["accept_license_agreement"]                = true
default["java"]["install_flavor"]                          = "oracle"
default["java"]["jdk_version"]                             = "7"
default["java"]["java_home"] = "/usr/lib/jvm/java"
default["java"]["oracle"]['accept_oracle_download_terms']  = true

#3rd-party defaults
default['alfresco']['install_fonts'] = true
default['alfresco']['exclude_font_packages'] = "pagul-fonts\*"
