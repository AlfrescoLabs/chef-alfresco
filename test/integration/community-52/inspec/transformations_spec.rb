control 'alfresco-07' do
  impact 0.7
  title 'Libreoffice installation'
  desc 'Checks to be sure that Libreoffice has been installed correctly'

  describe file('/opt/libreoffice5.2/') do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe command('/opt/libreoffice5.2/program/soffice.bin --version') do
    its(:stdout) { should include('LibreOffice 5.2.1.2') }
  end
end
