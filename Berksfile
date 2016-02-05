source "https://api.berkshelf.com"

# cookbook 'tomcat', git:'https://github.com/maoo/tomcat.git', tag: "v11.17.3"
cookbook 'apache_tomcat', git:'https://gitlab.com/maoo/chef-apache_tomcat.git'

# cookbook 'tomcat', path: '../tomcat'

# Resolve transitive deps of artifact-deployer
cookbook 'maven', git:'https://github.com/maoo/maven.git', tag: "v1.2.0-fork"
cookbook 'file', git: 'https://github.com/jenssegers/chef-file.git', tag: "v1.0.0"

cookbook 'commons', git: 'https://github.com/Alfresco/chef-commons.git', branch: 'artifact_deployer'
# cookbook 'commons', path: '../chef-commons'

metadata
