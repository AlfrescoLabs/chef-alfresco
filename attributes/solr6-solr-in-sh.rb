default['solr6']['solr-in-sh']['SOLR_JAVA_HOME'] = ''
default['solr6']['solr-in-sh']['SOLR_STOP_WAIT'] = '180'
default['solr6']['solr-in-sh']['SOLR_HEAP'] = '512m'
default['solr6']['solr-in-sh']['SOLR_JAVA_MEM'] = '-Xms512m -Xmx512m'
default['solr6']['solr-in-sh']['GC_LOG_OPTS'] = '-verbose:gc -XX:+PrintHeapAtGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintTenuringDistribution -XX:+PrintGCApplicationStoppedTime'
default['solr6']['solr-in-sh']['GC_TUNE'] = '-XX:NewRatio=3 -XX:SurvivorRatio=4'
default['solr6']['solr-in-sh']['ZK_HOST'] = ''
default['solr6']['solr-in-sh']['ZK_CLIENT_TIMEOUT'] = '15000'
default['solr6']['solr-in-sh']['SOLR_HOST'] = node['alfresco']['internal_hostname']
default['solr6']['solr-in-sh']['SOLR_TIMEZONE'] = 'UTC'
default['solr6']['solr-in-sh']['ENABLE_REMOTE_JMX_OPTS'] = 'false'
default['solr6']['solr-in-sh']['RMI_PORT'] = 18983
default['solr6']['solr-in-sh']['SOLR_SSL_KEY_STORE'] = "#{node['solr6']['installation-path']}/#{node['solr6']['dir_name']}/keystore/ssl.repo.client.keystore"
default['solr6']['solr-in-sh']['SOLR_SSL_KEY_STORE_PASSWORD'] = 'secret'
default['solr6']['solr-in-sh']['SOLR_SSL_TRUST_STORE'] = "#{node['solr6']['installation-path']}/#{node['solr6']['dir_name']}/keystore/ssl.repo.client.truststore"
default['solr6']['solr-in-sh']['SOLR_SSL_TRUST_STORE_PASSWORD'] = 'secret'
default['solr6']['solr-in-sh']['SOLR_SSL_NEED_CLIENT_AUTH'] = 'true'
default['solr6']['solr-in-sh']['SOLR_SSL_WANT_CLIENT_AUTH'] = 'false'
default['solr6']['solr-in-sh']['SOLR_SSL_CLIENT_KEY_STORE'] = ''
default['solr6']['solr-in-sh']['SOLR_SSL_CLIENT_KEY_STORE_PASSWORD'] = ''
default['solr6']['solr-in-sh']['SOLR_SSL_CLIENT_TRUST_STORE'] = ''
default['solr6']['solr-in-sh']['SOLR_SSL_CLIENT_TRUST_STORE_PASSWORD'] = ''
default['solr6']['solr-in-sh']['SOLR_AUTHENTICATION_CLIENT_CONFIGURER'] = ''
default['solr6']['solr-in-sh']['SOLR_AUTHENTICATION_OPTS'] = ''
default['solr6']['solr-in-sh']['SOLR_ZK_CREDS_AND_ACLS'] = '-DzkACLProvider=org.apache.solr.common.cloud.VMParamsAllAndReadonlyDigestZkACLProvider -DzkCredentialsProvider=org.apache.solr.common.cloud.VMParamsSingleSetCredentialsDigestZkCredentialsProvider -DzkDigestUsername=admin-user -DzkDigestPassword=CHANGEME-ADMIN-PASSWORD -DzkDigestReadonlyUsername=readonly-user -DzkDigestReadonlyPassword=CHANGEME-READONLY-PASSWORD'
default['solr6']['solr-in-sh']['SOLR_OPTS_1'] = '$SOLR_OPTS -Dsolr.jetty.request.header.size=1000000 -Dsolr.jetty.threads.stop.timeout=300000'
default['solr6']['solr-in-sh']['SOLR_OPTS_2'] = '$SOLR_OPTS -Dsolr.autoSoftCommit.maxTime=3000'
default['solr6']['solr-in-sh']['SOLR_OPTS_3'] = '$SOLR_OPTS -Dsolr.autoCommit.maxTime=60000'
default['solr6']['solr-in-sh']['SOLR_OPTS_4'] = '$SOLR_OPTS -Dsolr.clustering.enabled=true'
default['solr6']['solr-in-sh']['SOLR_OPTS_5'] = '$SOLR_OPTS $SOLR_ZK_CREDS_AND_ACLS'
default['solr6']['solr-in-sh']['SOLR_PID_DIR'] = '/var/solr'
default['solr6']['solr-in-sh']['SOLR_HOME'] = "#{node['solr6']['solr-in-sh']['SOLR_PID_DIR']}/data"
default['solr6']['solr-in-sh']['LOG4J_PROPS'] = "#{node['solr6']['solr-in-sh']['SOLR_PID_DIR']}/log4j.properties"
default['solr6']['solr-in-sh']['SOLR_LOG_LEVEL'] = 'INFO'
# default['solr6']['solr-in-sh']['SOLR_LOGS_DIR'] = "#{node['solr6']['solr-in-sh']['SOLR_PID_DIR']}/logs"
default['solr6']['solr-in-sh']['SOLR_LOGS_DIR'] = "/var/log/solr"
default['solr6']['solr-in-sh']['SOLR_PORT'] = 8090
