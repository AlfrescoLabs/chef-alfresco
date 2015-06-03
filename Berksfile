source "https://api.berkshelf.com"

# Using this fork due to unmerged changes - https://github.com/opscode-cookbooks/tomcat/pull/44
cookbook 'tomcat', git:'https://github.com/maoo/tomcat.git', tag: "v0.17.3-fork2"

# Resolve transitive deps of artifact-deployer
cookbook 'maven', git:'https://github.com/maoo/maven.git', tag: "v1.2.0-fork"
cookbook 'file', git: 'https://github.com/jenssegers/chef-file.git', tag: "v1.0.0"

metadata
