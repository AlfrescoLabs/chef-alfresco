 #!/bin/bash

# This script will install chef-alfresco into your box, fetching all
# artifacts needed from remote locations
#
# An example of how to use it in a Cloudformation template:
#
# export SKIP_CHEF_RUN=true
# export NODE_NAME=share
# curl -L https://raw.githubusercontent.com/Alfresco/chef-alfresco/master/install-alfresco.sh --no-sessionid | bash -s

# Allowed values
#NODE_NAME=share
#NODE_NAME=solr

if [ -z "$NODE_NAME" ]; then
  NODE_NAME=allinone
fi

if [ -z "$CHEF_ALFRESCO_VERSION" ]; then
  CHEF_ALFRESCO_VERSION="0.6.6"
fi

if [ -z "$NODE_URL" ]; then
  NODE_URL=https://raw.githubusercontent.com/Alfresco/chef-alfresco/master/nodes/$NODE_NAME.json
fi

if [ -z "$COOKBOOKS_TARBALL_URL" ]; then
  COOKBOOKS_TARBALL_URL=https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/devops/chef-alfresco/$CHEF_ALFRESCO_VERSION/chef-alfresco-$CHEF_ALFRESCO_VERSION.tar.gz
fi

# Download chef-alfresco tar.gz into /tmp folder
curl -L $COOKBOOKS_TARBALL_URL > /tmp/chef-alfresco.tar.gz

# Unpack it in /tmp
tar xvzf /tmp/chef-alfresco.tar.gz -C /tmp/chef-alfresco

# Copy cookbooks into /etc/chef location
cp -rf /tmp/chef-alfresco/cookbooks /etc/chef

# Download Chef JSON attribute
curl -L $NODE_URL > /etc/chef/attributes.json

# Run chef
# It can be skipped, in case you need to replace some properties
# in your chef attributes file
if [ "$SKIP_CHEF_RUN" -ne "true" ]; then
  cd /etc/chef
  chef-client -z -j /etc/chef/attributes.json
fi
