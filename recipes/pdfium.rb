# Only install PDFium if the version of Alfresco is equal or greater than 5.2.1
execute 'extract pdfium tgz' do
  command 'tar xzvf /usr/local/bin/pdfium.tgz'
  cwd '/usr/local/bin'
  creates '/usr/local/bin/alfresco-pdf-renderer'
end
