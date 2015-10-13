# TODO - integrate in default configuration
default['alfresco']['errorpages']['error_folder'] = "/var/www/html/errors"
default['alfresco']['errorpages']['error_file_cookbook'] = "alfresco"
default['alfresco']['errorpages']['error_file_source'] = "errors"

default['alfresco']['errorpages']['400_error_page_message'] = "Alfresco received a bad request!"
default['alfresco']['errorpages']['403_error_page_message'] = "Alfresco forbids you from doing that!"
default['alfresco']['errorpages']['404_error_page_message'] = "Alfresco couldnt find your file."
default['alfresco']['errorpages']['408_error_page_message'] = "Alfresco timed out."
default['alfresco']['errorpages']['500_error_page_message'] = "Alfresco is having some issues, sorry."
default['alfresco']['errorpages']['502_error_page_message'] = "Alfresco is having some issues!"
default['alfresco']['errorpages']['503_error_page_message'] = "Alfresco is under heavy load right now!"
default['alfresco']['errorpages']['504_error_page_message'] = "Alfresco is having some issues!"
