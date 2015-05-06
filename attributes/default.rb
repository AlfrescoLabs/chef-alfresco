#######################################
# Chef Alfresco Components and Features
#######################################
# Disable spp by default, since AOS is installed by default
# default['alfresco']['components'] = ['haproxy','nginx','tomcat','transform','repo','share','solr','mysql','spp','rm','googledocs']
default['alfresco']['components'] = ['haproxy','nginx','tomcat','transform','repo','share','solr','mysql','rm','googledocs']

#Generates alfresco-global.properties using all node['alfresco']['properties'] key/value attributes
default['alfresco']['generate.global.properties'] = true

#Generates share-config-custom.xml using a pre-defined template (check templates/default) and configuring http endpoint and disabling CSRF
default['alfresco']['generate.share.config.custom'] = true

#Generates repo-log4j.properties using all node['alfresco']['repo-log4j'] key/value attributes
default['alfresco']['generate.repo.log4j.properties'] = true

#Generates share-log4j.properties using all node['alfresco']['share-log4j'] key/value attributes
default['alfresco']['generate.share.log4j.properties'] = true

#Patches an existing share-config-custom.xml using node['alfresco']['properties'] key/value attributes and replacing all @@key@@ occurrencies
default['alfresco']['patch.share.config.custom'] = false

#License defaults
default['alfresco']['license_source'] = 'alfresco-license'
default['alfresco']['license_cookbook'] = 'alfresco'

#Mysql (custom) defaults
default['mysql']['update_gcc'] = true
