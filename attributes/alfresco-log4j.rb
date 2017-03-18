# Hibernate
default['alfresco']['log4j_items']['log4j.logger.org.hibernate'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.hibernate.util.JDBCExceptionReporter'] = 'fatal'
default['alfresco']['log4j_items']['log4j.logger.org.hibernate.event.def.AbstractFlushingEventListener'] = 'fatal'
default['alfresco']['log4j_items']['log4j.logger.org.hibernate.type'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.hibernate.cfg.SettingsFactory'] = 'warn'

# Spring
default['alfresco']['log4j_items']['log4j.logger.org.springframework'] = 'warn'
# Turn off Spring remoting warnings that should really be info or debug.
default['alfresco']['log4j_items']['log4j.logger.org.springframework.remoting.support'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.springframework.util'] = 'error'

# Axis/WSS4J
default['alfresco']['log4j_items']['log4j.logger.org.apache.axis'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.apache.ws'] = 'info'

# CXF
default['alfresco']['log4j_items']['log4j.logger.org.apache.cxf'] = 'error'

# MyFaces
default['alfresco']['log4j_items']['log4j.logger.org.apache.myfaces.util.DebugUtils'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.apache.myfaces.el.VariableResolverImpl'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.apache.myfaces.application.jsp.JspViewHandlerImpl'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.apache.myfaces.taglib'] = 'error'

# OpenOfficeConnection
default['alfresco']['log4j_items']['log4j.logger.net.sf.jooreports.openoffice.connection'] = 'fatal'

# log prepared statement cache activity ###'
default['alfresco']['log4j_items']['log4j.logger.org.hibernate.ps.PreparedStatementCache'] = 'info'

# Alfresco
default['alfresco']['log4j_items']['log4j.logger.org.alfresco'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.admin'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.transaction'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.cache.TransactionalCache'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.model.filefolder'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.tenant'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.config'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.config.JndiObjectFactoryBean'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.config.JBossEnabledWebApplicationContext'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.management.subsystems'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.management.subsystems.ChildApplicationContextFactory'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.management.subsystems.ChildApplicationContextFactory$ChildApplicationContext'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.security.sync'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.security.person'] = 'info'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.sample'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web'] = 'info'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.app.AlfrescoNavigationHandler'] = 'debug'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.ui.repo.component.UIActions'] = 'debug'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.ui.repo.tag.PageTag'] = 'debug'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.bean.clipboard'] = 'debug'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.service.descriptor.DescriptorService'] = 'info'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.page'] = 'debug'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.importer.ImporterBootstrap'] = 'error'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.importer.ImporterBootstrap'] = 'info'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.admin.patch.PatchExecuter'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.domain.patch.ibatis.PatchDAOImpl'] = 'info'

# Specific patches
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.admin.patch.impl.DeploymentMigrationPatch'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.version.VersionMigrator'] = 'info'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.module.ModuleServiceImpl'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.domain.schema.SchemaBootstrap'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.admin.ConfigurationChecker'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.node.index.AbstractReindexComponent'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.node.index.IndexTransactionTracker'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.node.index.FullIndexRecoveryComponent'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.util.OpenOfficeConnectionTester'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.node.db.hibernate.HibernateNodeDaoServiceImpl'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.domain.hibernate.DirtySessionMethodInterceptor'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.transaction.RetryingTransactionHelper'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.util.transaction.SpringAwareUserTransaction.trace'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.util.AbstractTriggerBean'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.enterprise.repo.cluster'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.version.Version2ServiceImpl'] = 'warn'

# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.app.DebugPhaseListener'] = 'debug'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.node.db.NodeStringLengthWorker'] = 'info'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.workflow'] = 'info'

# CIFS server debugging
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.smb.protocol'] = 'error'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.smb.protocol.auth'] = 'debug'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.acegi'] = 'debug'

# FTP server debugging
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.ftp.protocol'] = 'error'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.ftp.server'] = 'debug'

# WebDAV debugging
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.webdav.protocol'] = 'debug'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.webdav.protocol'] = 'info'

# NTLM servlet filters
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.app.servlet.NTLMAuthenticationFilter'] = 'debug'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.webdav.auth.NTLMAuthenticationFilter'] = 'debug'

# Kerberos servlet filters
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.app.servlet.KerberosAuthenticationFilter'] = 'debug'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.webdav.auth.KerberosAuthenticationFilter'] = 'debug'

# File servers'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.fileserver'] = 'warn'

# Repo filesystem debug logging
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.filesys.repo.ContentDiskDriver'] = 'debug'

# Integrity message threshold - if 'failOnViolation' is off, then WARNINGS are generated'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.node.integrity'] = 'ERROR'

# Indexer debugging
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.Indexer'] = 'error'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.Indexer'] = 'debug'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.impl.lucene.index'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.impl.lucene.fts.FullTextSearchIndexerImpl'] = 'warn'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.impl.lucene.index'] = 'DEBUG'

# Audit debugging
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.audit'] = 'DEBUG'
# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.audit.model'] = 'DEBUG'

# Property sheet and modelling debugging
# change to error to hide the warnings about missing properties and associations'
default['alfresco']['log4j_items']['log4j.logger.alfresco.missingProperties'] = 'warn'

# Dictionary/Model debugging
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.dictionary'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.dictionary.types.period'] = 'warn'

# Virtualization Server Registry
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.mbeans.VirtServerRegistry'] = 'error'

# Spring context runtime property setter
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.util.RuntimeSystemPropertiesSetter'] = 'info'

# Debugging options for clustering
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.content.ReplicatingContentStore'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.content.replication'] = 'error'

# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.deploy.DeploymentServiceImpl'] = 'debug'

# Activity service
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.activities'] = 'warn'

# User usage tracking
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.usage'] = 'info'

# Sharepoint
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.module.vti'] = 'info'

# Forms Engine
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.config.forms'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.web.scripts.forms'] = 'info'

# CMIS
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.opencmis'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.opencmis.AlfrescoCmisServiceInterceptor'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.cmis'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.cmis.dictionary'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.apache.chemistry.opencmis'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.apache.chemistry.opencmis.server.impl.browser.CmisBrowserBindingServlet'] = 'OFF'
default['alfresco']['log4j_items']['log4j.logger.org.apache.chemistry.opencmis.server.impl.atompub.CmisAtomPubServlet'] = 'OFF'

# IMAP
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.imap'] = 'info'

# JBPM
# Note: non-fatal errors (eg. logged during job execution) should be handled by Alfresco's retrying transaction handler'
default['alfresco']['log4j_items']['log4j.logger.org.jbpm.graph.def.GraphElement'] = 'fatal'

# default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.googledocs'] = 'debug'

###### Scripting #######

# Web Framework
default['alfresco']['log4j_items']['log4j.logger.org.springframework.extensions.webscripts'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.springframework.extensions.webscripts.ScriptLogger'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.springframework.extensions.webscripts.ScriptDebugger'] = 'off'

# Repository
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.web.scripts'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.web.scripts.BaseWebScriptTest'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.web.scripts.AlfrescoRhinoScriptDebugger'] = 'off'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.jscript'] = 'error'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.jscript.ScriptLogger'] = 'warn'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.cmis.rest.CMISTest'] = 'info'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.domain.schema.script.ScriptBundleExecutorImpl'] = 'off'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.domain.schema.script.ScriptExecutorImpl'] = 'info'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.impl.solr.facet.SolrFacetServiceImpl'] = 'info'

# Bulk Filesystem Import Tool'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.bulkimport'] = 'warn'

# Freemarker
# Note the freemarker.runtime logger is used to log non-fatal errors that are handled by Alfresco's retrying transaction handler'
default['alfresco']['log4j_items']['log4j.logger.freemarker.runtime'] = ''

# Metadata extraction
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.content.metadata.AbstractMappingMetadataExtracter'] = 'warn'

# Reduces PDFont error level due to ALF-7105
default['alfresco']['log4j_items']['log4j.logger.org.apache.pdfbox.pdmodel.font.PDSimpleFont'] = 'fatal'
default['alfresco']['log4j_items']['log4j.logger.org.apache.pdfbox.pdmodel.font.PDFont'] = 'fatal'
default['alfresco']['log4j_items']['log4j.logger.org.apache.pdfbox.pdmodel.font.PDCIDFont'] = 'fatal'

# no index support
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.impl.noindex.NoIndexIndexer'] = 'fatal'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.impl.noindex.NoIndexSearchService'] = 'fatal'

# lucene index warnings
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.search.impl.lucene.index.IndexInfo'] = 'warn'

# Warn about RMI socket bind retries.
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.util.remote.server.socket.HostConfigurableSocketFactory'] = 'warn'

default['alfresco']['log4j_items']['log4j.logger.org.alfresco.repo.usage.RepoUsageMonitor'] = 'info'

# Authorization
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.enterprise.repo.authorization.AuthorizationService'] = 'info'
default['alfresco']['log4j_items']['log4j.logger.org.alfresco.enterprise.repo.authorization.AuthorizationsConsistencyMonitor'] = 'warn'
