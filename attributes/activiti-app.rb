# Database info
default['activiti-app']['mysql_version'] = '5.6'
default['activiti-app']['generate.properties'] = true
default['activiti-app']['edition'] = "enterprise"
default['activiti-app']['properties']['db.driver'] = 'com.mysql.jdbc.Driver'
default['activiti-app']['properties']['db.prefix'] = 'mysql'
default['activiti-app']['properties']['db.host'] = '127.0.0.1'
default['activiti-app']['properties']['db.port'] = '3306'
default['activiti-app']['properties']['db.dbname'] = 'activiti_modeler'
default['activiti-app']['properties']['db.params'] = 'connectTimeout=240000&socketTimeout=240000&autoReconnect=true&characterEncoding=UTF-8'


#community edition conf
default['activiti-app']['community']['properties']['jdbc.driver'] = node['activiti-app']['properties']['db.driver']
default['activiti-app']['community']['properties']['jdbc.url'] = "jdbc:#{node['activiti-app']['properties']['db.prefix']}://#{node['activiti-app']['properties']['db.host']}:#{node['activiti-app']['properties']['db.port']}/#{node['activiti-app']['properties']['db.dbname']}?#{node['activiti-app']['properties']['db.params']}"


#activiti enterprise conf
default['activiti-app']['enterprise']['properties']['server.onpremise'] = true
default['activiti-app']['enterprise']['properties']['server.contexroot'] = "/activiti-app"
default['activiti-app']['enterprise']['properties']['user.trial.durationInDays'] = 60
default['activiti-app']['enterprise']['properties']['security.rememberme.key'] = "thissecuretestkey"
default['activiti-app']['enterprise']['properties']['security.useraccount.credentialsIVSpec'] = "YourCredentialsIVSpec"
default['activiti-app']['enterprise']['properties']['security.useraccount.credentialsSecretSpec'] = "YourCredentialsSecretsSpec"
default['activiti-app']['enterprise']['properties']['hibernate.dialect'] = "org.hibernate.dialect.MySQLDialect"
default['activiti-app']['enterprise']['properties']['datasource.driver'] = default['activiti-app']['properties']['db.driver']
default['activiti-app']['enterprise']['properties']['datasource.url'] = "jdbc:#{node['activiti-app']['properties']['db.prefix']}://#{node['activiti-app']['properties']['db.host']}:#{node['activiti-app']['properties']['db.port']}/#{node['activiti-app']['properties']['db.dbname']}?#{node['activiti-app']['properties']['db.params']}"
# username and password are defined in the recipes/_activiti-attributes.rb because they use the alfresco ones
default['activiti-app']['enterprise']['properties']['datasource.min-pool-size'] = 50
default['activiti-app']['enterprise']['properties']['datasource.max-pool-size'] = 100
default['activiti-app']['enterprise']['properties']['datasource.acquire-increment'] = 1
default['activiti-app']['enterprise']['properties']['datasource.preferred-test-query'] = "select 1"
default['activiti-app']['enterprise']['properties']['datasource.test-connection-on-checkin'] = true
default['activiti-app']['enterprise']['properties']['datasource.test-connection-on-checkout'] = true
default['activiti-app']['enterprise']['properties']['datasource.max-idle-time'] = 480
default['activiti-app']['enterprise']['properties']['datasource.max-idle-time-excess-connections'] = 480

default['activiti-app']['enterprise']['properties']['activiti.process-definitions.cache.max'] = 128
default['activiti-app']['enterprise']['properties']['rest.variables.allow.serializable'] = false
default['activiti-app']['enterprise']['properties']['security.asposeKey'] = "YourAsposeKey"
default['activiti-app']['enterprise']['properties']['metrics.console.reporter.enabled'] = false
default['activiti-app']['enterprise']['properties']['event.generation.enabled'] = true
default['activiti-app']['enterprise']['properties']['event.processing.enabled'] = true
default['activiti-app']['enterprise']['properties']['event.processing.blocksize'] = 100
default['activiti-app']['enterprise']['properties']['event.processing.cronExpression'] = "0/5 * * * * ?"
default['activiti-app']['enterprise']['properties']['event.processing.expired.cronExpression'] = "0 0/30 * * * ?"
default['activiti-app']['enterprise']['properties']['event.processing.processed.events.action'] = "move"
default['activiti-app']['enterprise']['properties']['event.processing.processed.action.cronExpression'] = "0 25/45 * * * ?"
default['activiti-app']['enterprise']['properties']['admin.email'] = "admin@app.activiti.com"
default['activiti-app']['enterprise']['properties']['admin.passwordHash'] = "6e6ede972d13b9e22ef1135bbdae0a9ba2c41ff4b2e04ad66292643e69cbb48d6bc34dfa85bdd90b" #k1ngk0ng
default['activiti-app']['enterprise']['properties']['admin.lastname'] = "Administrator"
default['activiti-app']['enterprise']['properties']['admin.group'] = "Superusers"  
default['activiti-app']['enterprise']['properties']['app.analytics.default.enabled'] = true
default['activiti-app']['enterprise']['properties']['app.analytics.default.capabilities.group'] = "analytics-users"
default['activiti-app']['enterprise']['properties']['app.kickstart.default.enabled'] = true
default['activiti-app']['enterprise']['properties']['app.kickstart.default.capabilities.group'] = "kickstart-users"
default['activiti-app']['enterprise']['properties']['app.review-workflows.enabled'] = false
default['activiti-app']['enterprise']['properties']['alfresco.cloud.disabled'] = true
default['activiti-app']['enterprise']['properties']['alfresco.cloud.clientId'] = "YourIdHere"
default['activiti-app']['enterprise']['properties']['alfresco.cloud.secret'] = "YourSecretHere"
default['activiti-app']['enterprise']['properties']['alfresco.cloud.redirectUri'] = "http://localhost:8060/activiti-app/app/rest/integration/alfresco-cloud/confirm-auth-request"
default['activiti-app']['enterprise']['properties']['file.upload.max.size'] = 104857600
default['activiti-app']['enterprise']['properties']['contentstorage.fs.rootFolder'] = "data/"
default['activiti-app']['enterprise']['properties']['contentstorage.fs.createRoot'] = true
default['activiti-app']['enterprise']['properties']['contentstorage.fs.depth'] = 4
default['activiti-app']['enterprise']['properties']['contentstorage.fs.blockSize'] = 1024
default['activiti-app']['enterprise']['properties']['googledrive.web.disabled'] = true
default['activiti-app']['enterprise']['properties']['googledrive.web.auth_uri'] = "https://accounts.google.com/o/oauth2/auth"
default['activiti-app']['enterprise']['properties']['googledrive.web.client_secret'] = "RegisterWithGoogleForYourSecret"
default['activiti-app']['enterprise']['properties']['googledrive.web.token_uri'] = "https://accounts.google.com/o/oauth2/token"
default['activiti-app']['enterprise']['properties']['googledrive.web.client_email'] = "RegisterWithGoogleForYourEmail"
default['activiti-app']['enterprise']['properties']['googledrive.web.redirect_uris'] = "http://localhost:8060/activiti-app/app/rest/integration/google-drive/confirm-auth-request"
default['activiti-app']['enterprise']['properties']['googledrive.web.client_x509_cert_url'] = "RegisterWithGoogleForYourCert"
default['activiti-app']['enterprise']['properties']['googledrive.web.client_id'] = "RegisterWithGoogleForYourClientId"
default['activiti-app']['enterprise']['properties']['googledrive.web.auth_provider_x509_cert_url'] = "https://www.googleapis.com/oauth2/v1/certs"
default['activiti-app']['enterprise']['properties']['googledrive.web.javascript_origins'] = "http://localhost:8060/activiti-app"
default['activiti-app']['enterprise']['properties']['box.disabled'] = true
default['activiti-app']['enterprise']['properties']['box.web.auth_uri'] = "https://app.box.com/api/oauth2/authorize"
default['activiti-app']['enterprise']['properties']['box.web.client_id'] = "RegisterWithBoxForYourClientId"
default['activiti-app']['enterprise']['properties']['box.web.client_secret'] = "RegisterWithBoxForYourSecret"
default['activiti-app']['enterprise']['properties']['box.web.javascript_origins'] = "http://localhost:8060"
default['activiti-app']['enterprise']['properties']['box.web.token_uri'] = "https://app.box.com/api/oauth2/token"
default['activiti-app']['enterprise']['properties']['box.web.redirect_uris'] = "http://localhost:8060/activiti-app/app/rest/integration/box/confirm-auth-request"
default['activiti-app']['enterprise']['properties']['box.upload.retry.maxAttempts'] = 4
default['activiti-app']['enterprise']['properties']['box.upload.retry.delay'] = 1000

default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.executionlistener'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.cameltask'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.muletask'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.mailtask'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.scripttask'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.manualtask'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.businessruletask'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.servicetask'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.intermediatethrowevent'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.startevent.timer'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.startevent.signal'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.startevent.message'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.startevent.error'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.startevent.timecycle'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.disable.loopback'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.limit.servicetask.only-class'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.limit.multiinstance.loop'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.bpmn.limit.usertask.assignment.only-idm'] = false
default['activiti-app']['enterprise']['properties']['validator.editor.dmn.expression'] = true
default['activiti-app']['enterprise']['properties']['editor.form.javascript.disable'] = false
default['activiti-app']['enterprise']['properties']['security.http.bypassSSL'] = true

# For now we don't define an elastic-search server. I will define it in the next task
default['activiti-app']['enterprise']['properties']['elastic-search.server.type'] = "none"

# The maximum file upload limit for trial users, in bytes (eg. 10485760 = 10MB)
default['activiti-app']['enterprise']['properties']['quota.trial.maxFileUploadSize'] = 10485760
default['activiti-app']['enterprise']['properties']['quota.trial.maxRuntimeApps'] = 5
default['activiti-app']['enterprise']['properties']['quota.trial.maxApps'] = 5
default['activiti-app']['enterprise']['properties']['quota.trial.maxRunningProcesses'] = 10
default['activiti-app']['enterprise']['properties']['quota.trial.maxCompletedProcesses'] = 100
default['activiti-app']['enterprise']['properties']['quota.trial.maxTotalContentSize'] = 262144000







# default['activiti-app']['enterprise']['properties']['email.enabled'] = true
# default['activiti-app']['enterprise']['properties']['email.host'] = "smtp.sendgrid.net"
# default['activiti-app']['enterprise']['properties']['email.port'] = 25
# default['activiti-app']['enterprise']['properties']['email.useCredentials'] = true
# default['activiti-app']['enterprise']['properties']['email.username'] = "activiti_DP_Aug15"
# default['activiti-app']['enterprise']['properties']['email.password'] = "nUCYujSlcnRu8L"
# default['activiti-app']['enterprise']['properties']['email.from.default'] = "no-reply@activiti.alfresco.com"
# default['activiti-app']['enterprise']['properties']['email.from.default.name'] = "Activiti"
# default['activiti-app']['enterprise']['properties']['email.feedback.default'] = "activiti@alfresco.com"

