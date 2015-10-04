default['alfresco']['solr']['contentstore.path'] = "/usr/share/tomcat/alf_data/solrContentStore"

# Generic Solr configuration
default['alfresco']['solrproperties']['enable.alfresco.tracking'] = true
default['alfresco']['solrproperties']['alfresco.index.transformContent'] = true
default['alfresco']['solrproperties']['alfresco.version'] = node['alfresco']['version']
default['alfresco']['solrproperties']['alfresco.cron'] = "0/15 * * * * ? *"
default['alfresco']['solrproperties']['alfresco.lag'] = 1000
default['alfresco']['solrproperties']['alfresco.hole.retention'] = 3600000
default['alfresco']['solrproperties']['alfresco.batch.count'] = 1000

# Tracking
default['alfresco']['solrproperties']['alfresco.enableMultiThreadedTracking'] = true
default['alfresco']['solrproperties']['alfresco.corePoolSize'] = 16
default['alfresco']['solrproperties']['alfresco.maximumPoolSize'] = -1
default['alfresco']['solrproperties']['alfresco.keepAliveTime'] = 120
default['alfresco']['solrproperties']['alfresco.threadPriority'] = 5
default['alfresco']['solrproperties']['alfresco.threadDaemon'] = true
default['alfresco']['solrproperties']['alfresco.workQueueSize'] = -1

#default# ?
default['alfresco']['solrproperties']['solr.maxBooleanClauses'] = 10000

# Batch fetch

#default# 500
default['alfresco']['solrproperties']['alfresco.transactionDocsBatchSize'] = 100
#default# ?
default['alfresco']['solrproperties']['alfresco.nodeBatchSize'] = 100
#default# 500
default['alfresco']['solrproperties']['alfresco.changeSetAclsBatchSize'] = 100
#default# 100
default['alfresco']['solrproperties']['alfresco.aclBatchSize'] = 10
#default# ?
default['alfresco']['solrproperties']['alfresco.contentReadBatchSize'] = 4000
#default# ?
default['alfresco']['solrproperties']['alfresco.contentUpdateBatchSize'] = 1000

# Warming
#default# 128
default['alfresco']['solrproperties']['solr.filterCache.autowarmCount'] = 128
#default# 0
default['alfresco']['solrproperties']['solr.authorityCache.autowarmCount'] = 4
#default# 128
default['alfresco']['solrproperties']['solr.pathCache.autowarmCount'] = 32
#default# ?
default['alfresco']['solrproperties']['solr.deniedCache.autowarmCount'] = 0
default['alfresco']['solrproperties']['solr.readerCache.autowarmCount'] = 0
default['alfresco']['solrproperties']['solr.ownerCache.autowarmCount'] = 0
default['alfresco']['solrproperties']['solr.queryResultCache.autowarmCount'] = 4
default['alfresco']['solrproperties']['solr.documentCache.autowarmCount'] = 512
#default# 512
default['alfresco']['solrproperties']['solr.queryResultWindowSize'] = 200

#default# ?
default['alfresco']['solrproperties']['alfresco.doPermissionChecks'] = true
# #default# false - DEVOPS-4222
default['alfresco']['solrproperties']['alfresco.metadata.skipDescendantAuxDocsForSpecificTypes'] = true

default['alfresco']['solrproperties']['alfresco.metadata.ignore.datatype.0'] = "cm:person"
default['alfresco']['solrproperties']['alfresco.metadata.ignore.datatype.1'] = "app:configurations"

#default# false
default['alfresco']['solrproperties']['alfresco.topTermSpanRewriteLimit'] = 1000

#default# true
default['alfresco']['solrproperties']['solr.suggester.enabled'] = false

#default# ?
default['alfresco']['solrproperties']['alfresco.contentStreamLimit'] = 10000

# HTTP Client

#default# 200
default['alfresco']['solrproperties']['alfresco.maxTotalConnections'] = 200
#default# 200
default['alfresco']['solrproperties']['alfresco.maxHostConnections'] = 200
#default# 360000
default['alfresco']['solrproperties']['alfresco.socketTimeout'] = 900000

# Caching - optimised for 50 million docs repository
# 64Gb RAM boxes, with 41Gb assigned to JVM

#default# 256
default['alfresco']['solrproperties']['solr.filterCache.size'] = 256
#default# 128
default['alfresco']['solrproperties']['solr.filterCache.initialSize'] = 128
#default# 1024
default['alfresco']['solrproperties']['solr.queryResultCache.size'] = 900
#default# 1024
default['alfresco']['solrproperties']['solr.queryResultCache.initialSize'] = 900
#default# 1024
default['alfresco']['solrproperties']['solr.documentCache.size'] = 64
#default# 1024
default['alfresco']['solrproperties']['solr.documentCache.initialSize'] = 64
#default# 2048
default['alfresco']['solrproperties']['solr.queryResultMaxDocsCached'] = 2000
#default# 128
default['alfresco']['solrproperties']['solr.authorityCache.size'] = 64
#default# 256
default['alfresco']['solrproperties']['solr.authorityCache.initialSize'] = 64
#default# 256
default['alfresco']['solrproperties']['solr.pathCache.size'] = 64
#default# 128
default['alfresco']['solrproperties']['solr.pathCache.initialSize'] = 64
#default# ?
default['alfresco']['solrproperties']['solr.queryResultMaxDocsCached'] = 2048
#default# ?
default['alfresco']['solrproperties']['solr.ownerCache.size'] = 128
#default# ?
default['alfresco']['solrproperties']['solr.ownerCache.initialSize'] = 64
#default# ?
default['alfresco']['solrproperties']['solr.readerCache.size'] = 128
#default# ?
default['alfresco']['solrproperties']['solr.readerCache.initialSize'] = 64
#default# ?
default['alfresco']['solrproperties']['solr.deniedCache.size'] = 128
#default# ?
default['alfresco']['solrproperties']['solr.deniedCache.initialSize'] = 64
