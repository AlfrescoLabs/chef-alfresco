# Keep it empty and invoke it anyway, since attributes/solr_config.rb must be loaded
node.default['artifacts']['solrhome']['enabled']       = true
node.default['artifacts']['solr']['enabled']           = true
