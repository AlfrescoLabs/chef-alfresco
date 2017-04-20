control 'alfresco-04' do
  impact 0.5
  title 'Error pages'

  describe file('/var/www/html/errors/400.http') do
    it { should_not exist }
  end

  describe file('/var/www/html/errors/403.http') do
    it { should_not exist }
  end

  # describe file('/var/www/html/errors/404.http') do
  #   it { should_not exist }
  # end

  describe file('/var/www/html/errors/408.http') do
    it { should_not exist }
  end

  describe file('/var/www/html/errors/500.http') do
    it { should_not exist }
  end

  describe file('/var/www/html/errors/502.http') do
    it { should_not exist }
  end

  describe file('/var/www/html/errors/503.http') do
    it { should_not exist }
  end

  describe file('/var/www/html/errors/504.http') do
    it { should_not exist }
  end
end
