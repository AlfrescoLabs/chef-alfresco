# TODO: Checks
#
# Check (some) folder permissions (@toni?)
# Check iptables configuration (ports and IP blacklisting)
# Check Share login via webscripts
# Check Share search via webscripts
# Check Share transformation via webscripts
# Check JMX
# Check CMIS write/read
# Check Nginx endpoint with certificate (generate certs for alfresco.test domain)

# TODO: CI
#
# Configure Bamboo build to run kitchen converge && kitchen verify || kitchen converge && kitchen verify, avoid folder purging, run on commit; also check with kitchen list if any box is running; every friday evening, run a kitchen destroy && kitchen converge || kitchen converge

services = ['tomcat-alfresco', 'tomcat-share', 'haproxy', 'nginx']
yumrepos = %w(epel nginx)

# TODO: - should be the FQDN, but still need to configure /etc/hosts to get this to work
# alfresco_host = "chef-alfresco-testing.alfresco.test"
# alfresco_host = 'localhost'

yumrepos.each do |yumrepo|
  describe yum.repo(yumrepo) do
    it { should exist }
  end
end

# TODO: - this logic should be provided by another cookbook
#
# describe host(alfresco_host) do
#   it { should be_resolvable.by('hosts') }
# end

describe 'Alfresco daemons' do
  # Removing all the let *Connection tests, as they are classified as Validation testing, thus they don't have space in an integration test suite
  # Keeping them as memento to create future validation testing

  # let(:repoConnection) { $repoConnection ||= getFaradayConnection "http://localhost:8070" }
  # let(:shareConnection) { $shareConnection ||= getFaradayConnection "http://localhost:8081" }
  # let(:solrConnection) { $solrConnection ||= getFaradayConnection "http://localhost:8090" }
  # let(:activitiConnection) { $activitiConnection ||= getFaradayConnection "http://localhost:8060" }
  # let(:haproxyConnection) { $haproxyConnection ||= getFaradayConnection "http://localhost:9001" }
  # let(:haproxyIntConnection) { $haproxyIntConnection ||= getFaradayConnection "http://localhost:9000" }
  # let(:httpNginxConnection) { $httpNginxConnection ||= getFaradayConnection "http://localhost" }
  # let(:nginxConnection) { $nginxConnection ||= getFaradayConnection "http://#{alfresco_host}" }
  # let(:authNginxConnection) { $authNginxConnection ||= getFaradayConnection "http://admin:admin@#{alfresco_host}" }

  # services.each do |service|
  #   it "Has a running #{service} service" do
  #     expect(service(service)).to be_running
  #   end
  # end

  # The following tests are all  Validation testing, thus they don't have space in an integration test suite
  # Keeping them as memento to create future validation testing

  # it 'Has a running Alfresco Repository application' do
  #   expect(repoConnection.get('/alfresco/').body).to include('Welcome to Alfresco')
  # end
  #
  # it 'Has a running Alfresco Share application' do
  #   expect(shareConnection.get('/share/page/').body).to include('Alfresco Software Inc. All rights reserved. Simple + Smart')
  # end
  #
  # it 'Has a running Alfresco Solr application' do
  #   expect(solrConnection.get('/solr4/').body).to include('Apache SOLR')
  # end

  # it 'Has a running Activiti application' do
  #   expect(activitiConnection.get('/activiti/').body).to include('Activiti')
  # end

  # it 'Has a running Haproxy service wrapping all Alfresco public applications' do
  #   expect(haproxyConnection.get('/alfresco/').body).to include('Welcome to Alfresco')
  #   expect(haproxyConnection.get('/share/page/').body).to include('Alfresco Software Inc. All rights reserved. Simple + Smart')
  # end
  #
  # it 'Has a running Haproxy service wrapping all Alfresco internal applications' do
  #   expect(haproxyIntConnection.get('/solr4/').body).to include('Apache SOLR')
  # end
  # # TODO: - add vti and root here
  #
  # it 'Has a running Nginx service wrapping alfresco/share Haproxy endpoints' do
  #   expect(nginxConnection.get('/alfresco/').body).to include('Welcome to Alfresco')
  #   expect(nginxConnection.get('/share/page/').body).to include('Alfresco Software Inc. All rights reserved. Simple + Smart')
  # end
  #
  # it 'Has a running Nginx service wrapping alfresco/share Haproxy endpoints' do
  #   expect(nginxConnection.get('/alfresco/').body).to include('Welcome to Alfresco')
  #   expect(nginxConnection.get('/share/page/').body).to include('Alfresco Software Inc. All rights reserved. Simple + Smart')
  # end

  # it 'Has a running Nginx service wrapping /activiti Haproxy endpoints' do
  #    expect(nginxConnection.get('/activiti/').body).to include('Activiti')
  # end

  # TODO: - uncomment this!
  # it 'Has an HTTP redirect' do
  #   expect(httpNginxConnection.get('/').status).to eq 302
  # end

  # it 'Can search booted docs' do
  #   expect(authNginxConnection.get('/alfresco/service/slingshot/node/search?q=%40name%3A%22Project%20Meeting%20Minutes%22&lang=lucene&store=workspace%3A%2F%2FSpacesStore').body).to include('cm:Project Meeting Minutes')
  # end

  # # These tests are Enterprise-specific, whereas CI runs on a public environment
  #
  # it 'Has an Enterprise license installed' do
  #   expect(authNginxConnection.get('/alfresco/s/enterprise/admin/admin-license').body).to include('<span class="value">ENTERPRISE</span>')
  # end
  #
  # it 'Has an RM module installed' do
  #   expect(authNginxConnection.get('/alfresco/s/enterprise/admin/admin-systemsummary').body).to include('org_alfresco_module_rm')
  # end
  #
  # it 'Has an Google Docs module installed' do
  #   expect(authNginxConnection.get('/alfresco/s/enterprise/admin/admin-systemsummary').body).to include('org.alfresco.integrations.google.docs')
  # end
end

# describe file('/var/log/haproxy/alfresco.log') do
#   it { should exist }
# end
# describe file('/var/log/haproxy/share.log') do
#   it { should exist }
# end
# describe file('/var/log/haproxy/solr.log') do
#   it { should exist }
# end

# TODO: - not working
#
# -A INPUT -p tcp --dport 80 -j ACCEPT
# -A INPUT -p tcp --dport 443 -j ACCEPT
# -A INPUT -p tcp --dport 5701 -j ACCEPT
# -A INPUT -p tcp --dport 40000 -j ACCEPT
# -A INPUT -p tcp --dport 40010 -j ACCEPT
# -A INPUT -p tcp --dport 40020 -j ACCEPT
#
# describe iptables do
#   it { should have_rule("-A INPUT -p tcp --dport 80 -j ACCEPT") }
# end

# TODO: - not working
#
# describe cron do
#   it { should have_entry '*/30 * * * * root find #{node['tomcat']['cache_root_folder']}/tomcat-alfresco -mmin +30 -type f -exec rm -rf {} \;' }
#   it { should have_entry '*/30 * * * * root find #{node['tomcat']['cache_root_folder']}/tomcat-share -mmin +30 -type f -exec rm -rf {} \;' }
#   it { should have_entry '*/30 * * * * root find #{node['tomcat']['cache_root_folder']}/tomcat-solr -mmin +30 -type f -exec rm -rf {} \;' }
# end

# TODO: - Check that new location is correct (https); none of the approaches work!
#
# describe http_get(80, 'img-alfresco-test.alfresco.me', '/') do
#   its(:headers) { should include('Location' => /img-alfresco-test/) }
# end
# it 'Has an HTTP redirect to HTTPS' do
#   expect(httpNginxConnection.get('/').headers).include('Location' => "https://img-alfresco-test.alfresco.me/share/")
# end
