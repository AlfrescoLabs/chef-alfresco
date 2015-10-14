#NODE_NAME=share
#NODE_NAME=solr

if [ -z "$NODE_NAME" ]; then
  NODE_NAME=allinone
fi

if [ -z "$NODE_URL" ]; then
  NODE_URL=https://raw.githubusercontent.com/Alfresco/chef-alfresco/master/nodes/$NODE_NAME.json
fi

if [ -z "$COOKBOOKS_TARBALL_URL" ]; then
  COOKBOOKS_TARBALL_URL=https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/devops/chef-alfresco/0.6.6/chef-alfresco-0.6.6.tar.gz
fi

# Download chef-alfresco tar.gz into /tmp folder
curl -L $COOKBOOKS_TARBALL_URL > /tmp/chef-alfresco.tar.gz

# Unpack it in /tmp
tar xvzf /tmp/chef-alfresco.tar.gz -C /tmp/chef-alfresco

# Copy cookbooks into /etc/chef location
cp -rf /tmp/chef-alfresco/cookbooks /etc/chef

# Download Chef JSON attribute
curl -L $NODE_URL > /etc/chef/attributes.json

# TODO - Apply placeholding for @@values@@
# ...

# Run chef
cd /etc/chef
chef-client -z -j /etc/chef/attributes.json
