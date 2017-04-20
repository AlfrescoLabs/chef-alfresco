source 'https://api.berkshelf.com'

metadata

# Resolve transitive deps of artifact-deployer
cookbook 'maven', git: 'https://github.com/enzor/maven.git', tag: 'v1.2.0-fork'
cookbook 'file', git: 'https://github.com/jenssegers/chef-file.git', tag: 'v1.0.0'
cookbook 'commons', git: 'https://github.com/Alfresco/chef-commons.git', tag: 'v0.5.7'
cookbook 'database', git: 'https://github.com/enzor/database.git'
# cookbook 'alfresco-appserver', git: 'git@github.com:Alfresco/chef-alfresco-appserver.git', branch: 'develop'
cookbook 'alfresco-appserver', path: '../chef-alfresco-splitting/chef-alfresco-appserver'
cookbook 'alfresco-utils', git: 'git@github.com:Alfresco/chef-alfresco-utils.git', branch: 'develop'
cookbook 'apache_tomcat', git: 'https://gitlab.com/maoo/chef-apache_tomcat.git'
