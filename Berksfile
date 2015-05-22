source "https://api.berkshelf.com"

# Using this fork due to unmerged changes - https://github.com/opscode-cookbooks/tomcat/pull/44
cookbook 'tomcat', git:'git@github.com:maoo/tomcat.git', tag: "v0.17.3-fork2"

# Resolve transitive deps of artifact-deployer
cookbook 'maven', git:'git@github.com:maoo/maven.git', tag: "v1.2.0-fork"
cookbook 'file', git: 'git@github.com:jenssegers/chef-filehelper.git', tag: "v1.0.0"

metadata
