control 'alfresco-10' do
  impact 0.7
  title 'Haproxy configurations'

  describe file('/etc/haproxy/haproxy.cfg') do
    it { should exist }
    it { should be_file }
    its('content') { should match('acl is_solr6 path_beg /solr') }
    its('content') { should match('use_backend solr6 if is_solr6') }
    its('content') { should match('acl solr_path path_reg \^\/share\/\.\*\/proxy\/alfresco\/api\/solr\/\.\*') }
    its('content') { should match('http-request deny if solr_path') }
    its('content') { should match('backend solr6') }
    its('content') { should match('option httpchk GET /solr') }
    its('content') { should match('# Instance local_solr6_backend, az local') }
    its('content') { should match('server local_solr6_backend 127.0.0.1:8090 check inter 5000') }
    its('content') { should match 'errorfile 400 /var/www/html/errors/400.http' }
    its('content') { should match 'errorfile 403 /var/www/html/errors/403.http' }
    its('content') { should match 'errorfile 404 /var/www/html/errors/404.http' }
    its('content') { should match 'errorfile 500 /var/www/html/errors/500.http' }
    its('content') { should match 'errorfile 502 /var/www/html/errors/502.http' }
    its('content') { should match 'errorfile 503 /var/www/html/errors/503.http' }
    its('content') { should match 'errorfile 504 /var/www/html/errors/504.http' }
    its('content') { should match 'acl is_400_error status eq 400' }
    its('content') { should match 'acl is_403_error status eq 403' }
    its('content') { should match 'acl is_404_error status eq 404' }
    its('content') { should match 'acl is_500_error status eq 500' }
    its('content') { should match 'acl is_502_error status eq 502' }
    its('content') { should match 'acl is_503_error status eq 503' }
    its('content') { should match 'acl is_504_error status eq 504' }
    its('content') { should match 'rspideny . if is_400_error' }
    its('content') { should match 'rspideny . if is_403_error' }
    its('content') { should match 'rspideny . if is_404_error' }
    its('content') { should match 'rspideny . if is_500_error' }
    its('content') { should match 'rspideny . if is_502_error' }
    its('content') { should match 'rspideny . if is_503_error' }
    its('content') { should match 'rspideny . if is_504_error' }
  end
end
