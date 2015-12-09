source "https://api.berkshelf.com"

cookbook 'tomcat', git:'git@github.com:maoo/tomcat.git', tag: "v11.17.3"
# cookbook 'tomcat', path: '../tomcat'

# Resolve transitive deps of artifact-deployer
cookbook 'maven', git:'git@github.com:maoo/maven.git', tag: "v1.2.0-fork"
cookbook 'file', git: 'git@github.com:jenssegers/chef-file.git', tag: "v1.0.0"

# cookbook 'commons', git: 'git@github.com:Alfresco/chef-commons.git'
cookbook 'commons', path: '../chef-commons'

metadata
