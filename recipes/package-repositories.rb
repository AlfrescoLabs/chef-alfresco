if node['platform_family'] == "rhel"
  include_recipe 'yum-epel::default'
end

# Fixing temporary downtime of atrpms,
# used for libmp3lame0 package

# TODO - switch to http://repo.enetres.net/
# Read more on  http://vicendominguez.blogspot.nl/2015/09/atrpms-is-dead-and-i-need-ffmpeg-for.html

# node.set['yum']['atrpms']['baseurl'] = "https://www.mirrorservice.org/sites/dl.atrpms.net/el$releasever-$basearch/atrpms/stable"
# node.set['yum']['atrpms']['gpgcheck'] = false

# Doesn't work, we set yum repo manually
# include_recipe 'yum-atrpms::default'
template '/etc/yum.repos.d/atrpms.repo' do
  source 'yum/atrpms.repo.erb'
end
