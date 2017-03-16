control "alfresco-04" do
  impact 0.5
  title "HA Proxy Configuration Check"

  describe file('/etc/haproxy/haproxy.cfg') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'http-response set-header Strict-Transport-Security' }

    its('content') { should_not match 'errorfile 400 /var/www/html/errors/400.http' }
    its('content') { should_not match 'errorfile 403 /var/www/html/errors/403.http' }
    its('content') { should_not match 'errorfile 404 /var/www/html/errors/404.http' }
    its('content') { should_not match 'errorfile 500 /var/www/html/errors/500.http' }
    its('content') { should_not match 'errorfile 502 /var/www/html/errors/502.http' }
    its('content') { should_not match 'errorfile 503 /var/www/html/errors/503.http' }
    its('content') { should_not match 'errorfile 504 /var/www/html/errors/504.http' }

    its('content') { should_not match 'acl is_400_error status eq 400' }
    its('content') { should_not match 'acl is_403_error status eq 403' }
    its('content') { should_not match 'acl is_404_error status eq 404' }
    its('content') { should_not match 'acl is_500_error status eq 500' }
    its('content') { should_not match 'acl is_502_error status eq 502' }
    its('content') { should_not match 'acl is_503_error status eq 503' }
    its('content') { should_not match 'acl is_504_error status eq 504' }

    its('content') { should_not match 'rspideny . if is_400_error' }
    its('content') { should_not match 'rspideny . if is_403_error' }
    its('content') { should_not match 'rspideny . if is_404_error' }
    its('content') { should_not match 'rspideny . if is_500_error' }
    its('content') { should_not match 'rspideny . if is_502_error' }
    its('content') { should_not match 'rspideny . if is_503_error' }
    its('content') { should_not match 'rspideny . if is_504_error' }

  end

end
