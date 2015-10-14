# Download chef-alfresco tar.gz into /tmp folder
curl -L https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/devops/chef-alfresco/0.6.6/chef-alfresco-0.6.6.tar.gz > /tmp/chef-alfresco-0.6.6.tar.gz

# Unpack it in /tmp
tar xvzf /tmp/chef-alfresco-0.6.6.tar.gz -C /tmp/chef-alfresco

# Copy cookbooks into /etc/chef location
cp -rf /tmp/chef-alfresco/cookbooks /etc/chef

# Download Chef JSON attribute
curl -L https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/devops/chef-alfresco/0.6.6/chef-alfresco-0.6.6.tar.gz > /etc/chef/attributes.json

# Run chef
cd /etc/chef
chef-client -z -j /etc/chef/attributes.json
