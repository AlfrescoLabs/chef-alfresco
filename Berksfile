source "https://api.berkshelf.com"

metadata

cookbook 'tomcat', git:'https://github.com/maoo/tomcat.git', tag: "v11.17.3"
# cookbook 'tomcat', path: '../tomcat'

# Resolve transitive deps of artifact-deployer
cookbook 'maven', git:'https://github.com/maoo/maven.git', tag: "v1.2.0-fork"
cookbook 'file', git: 'https://github.com/jenssegers/chef-file.git', tag: "v1.0.0"
cookbook 'commons', git: 'https://github.com/Alfresco/chef-commons.git', tag: 'v0.5.5'
cookbook 'database', git: 'https://github.com/enzor/database.git'
