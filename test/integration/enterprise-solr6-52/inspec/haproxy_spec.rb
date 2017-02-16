control 'alfresco-10' do
  impact 0.7
  title 'Haproxy configurations'

  describe file("/etc/haproxy/haproxy.cfg") do
    it { should exist }
    it { should be_file }
    its('content') { should match("acl is_solr6 path_beg /solr") }
    its('content') { should match("use_backend solr6 if is_solr6") }
    its('content') { should match('acl solr_path path_reg \^\/share\/\.\*\/proxy\/alfresco\/api\/solr\/\.\*') }
    its('content') { should match("http-request deny if solr_path") }
    its('content') { should match("backend solr6") }
    its('content') { should match("option httpchk GET /solr") }
    its('content') { should match("# Instance local_solr6_backend, az local") }
    its('content') { should match("server local_solr6_backend 127.0.0.1:8090 check inter 5000") }

  end
end
