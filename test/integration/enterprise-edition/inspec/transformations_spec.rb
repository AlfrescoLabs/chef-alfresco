control 'alfresco-04' do
  impact 0.7
  title 'Libreoffice installation'
  desc 'Checks to be sure that Libreoffice has been installed correctly'

  describe file('/opt/libreoffice4.4/') do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe command('/opt/libreoffice4.4/program/soffice.bin --version') do
    its(:stdout) { should include('LibreOffice 4.4.5.2') }
  end
end
