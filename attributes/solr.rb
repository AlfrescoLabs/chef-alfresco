# Archive Solr configuration
default['alfresco']['archive-solrproperties']['enable.alfresco.tracking'] = true
default['alfresco']['archive-solrproperties']['alfresco.index.transformContent'] = false
default['alfresco']['archive-solrproperties']['alfresco.version'] = node['alfresco']['version']
default['alfresco']['archive-solrproperties']['alfresco.cron'] = "0/15 * * * * ? *"
default['alfresco']['archive-solrproperties']['alfresco.enableMultiThreadedTracking'] = true
default['alfresco']['archive-solrproperties']['alfresco.corePoolSize'] = 4
default['alfresco']['archive-solrproperties']['alfresco.maximumPoolSize'] = -1
default['alfresco']['archive-solrproperties']['alfresco.threadDaemon'] = true
default['alfresco']['archive-solrproperties']['alfresco.workQueueSize'] = -1

# Workspace Solr configuration
default['alfresco']['workspace-solrproperties']['enable.alfresco.tracking'] = true
default['alfresco']['workspace-solrproperties']['alfresco.index.transformContent'] = true
default['alfresco']['workspace-solrproperties']['alfresco.version'] = node['alfresco']['version']
default['alfresco']['workspace-solrproperties']['alfresco.cron'] = "0/15 * * * * ? *"
default['alfresco']['workspace-solrproperties']['alfresco.lag'] = 1000
default['alfresco']['workspace-solrproperties']['alfresco.hole.retention'] = 3600000
default['alfresco']['workspace-solrproperties']['alfresco.batch.count'] = 1000

# Tracking
default['alfresco']['workspace-solrproperties']['alfresco.enableMultiThreadedTracking'] = true
default['alfresco']['workspace-solrproperties']['alfresco.corePoolSize'] = 4
default['alfresco']['workspace-solrproperties']['alfresco.maximumPoolSize'] = -1
default['alfresco']['workspace-solrproperties']['alfresco.keepAliveTime'] = 120
default['alfresco']['workspace-solrproperties']['alfresco.threadPriority'] = 5
default['alfresco']['workspace-solrproperties']['alfresco.threadDaemon'] = true
default['alfresco']['workspace-solrproperties']['alfresco.workQueueSize'] = -1
