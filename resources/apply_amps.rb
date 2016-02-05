  # Used for applying amps on alfresco and share
  resource_name :apply_amps

  property :resource_title, String, name_property: true
  property :amps_folder, String, required: true
  property :amps_share_folder, String, required: true
  property :installation_folder, String, default: lazy { node['installer']['directory'] }
  property :share_amps, default: lazy { node['amps']['share'] }
  property :alfresco_amps, default: lazy { node['amps']['alfresco'] }
  property :bin_folder, String, required: true
  property :alfresco_webapps, String, required: true
  property :share_webapps, String, required: true
  property :tomcat_folder, String, required: true
  property :windowsUser, String
  property :windowsGroup, String
  property :unixUser, String
  property :unixGroup, String
  property :install_new_alfresco_amps, kind_of: [TrueClass, FalseClass], default: false
  property :install_new_share_amps, kind_of: [TrueClass, FalseClass], default: false

  default_action :create

  action :create do
    directory amps_folder do
      case node['platform_family']
      when 'windows'
        rights :read, 'Administrator'
        rights :write, 'Administrator'
        rights :full_control, 'Administrator'
        rights :full_control, 'Administrator', applies_to_children: true
        group 'Administrators'
      else
        owner 'root'
        group 'root'
        mode 00755
        recursive true
        :top_level
      end
    end

    directory amps_share_folder do
      case node['platform_family']
      when 'windows'
        rights :read, 'Administrator'
        rights :write, 'Administrator'
        rights :full_control, 'Administrator'
        rights :full_control, 'Administrator', applies_to_children: true
        group 'Administrators'
      else
        owner 'root'
        group 'root'
        mode 00755
        recursive true
        :top_level
      end
    end

    execute 'run setenv' do
      command './setenv.sh'
      cwd bin_folder
      user unixUser
      only_if { node['platform_family'] != 'windows' }
      only_if { ::File.exist?("#{bin_folder}/setenv.sh") }
    end

    maven_setup 'setup maven' do
      maven_home node['maven']['m2_home']
      only_if { node['commons']['install_maven'] }
    end

    artifact 'download alfresco artifacts' do
      repos_databag 'maven_repos'
      destinationPrefix amps_folder
      artifacts alfresco_amps
    end

    artifact 'download share artifacts' do
      repos_databag 'maven_repos'
      destinationPrefix amps_share_folder
      artifacts share_amps
    end

    ruby_block 'Check installed amp versions' do
      block do
        if alfresco_amps
          current_amp_version = `java -jar #{bin_folder}/alfresco-mmt.jar list #{alfresco_webapps}/alfresco.war | grep Version | awk '{ print $3 }'`
          alfresco_amps.each do |new_amp, _values|
            new_amp_version = `unzip -c #{amps_folder}/#{new_amp}.amp module.properties | grep module.version | awk -F "=" '{ print $2}'`
            install_new_alfresco_amps true unless current_amp_version.strip.include? new_amp_version.strip
          end
        end

        if share_amps
          current_amp_version = `java -jar #{bin_folder}/alfresco-mmt.jar list #{share_webapps}/share.war | grep Version | awk '{ print $3 }'`
          share_amps.each do |new_amp, _values|
            new_amp_version = `unzip -c #{amps_share_folder}/#{new_amp}.amp module.properties | grep module.version | awk -F "=" '{ print $2}'`
            install_new_share_amps true unless current_amp_version.strip.include? new_amp_version.strip
          end
        end
      end
    end

    # TODO: find a way to modify per shell winrm memory to more than 300MB, in the current session
    # powershell_script 'modify shell memory for winrm' do
    #   guard_interpreter :powershell_script
    #   code 'set-item wsman:localhost\Shell\MaxMemoryPerShellMB 2048'
    #   only_if { node['platform_family'] == 'windows' }
    # end

    execute 'apply alfresco amps' do
      command "java -jar alfresco-mmt.jar install #{amps_folder} #{alfresco_webapps}/alfresco.war -nobackup -directory -force"
      cwd bin_folder
      user unixUser if node['platform_family'] != 'windows'
      only_if { install_new_alfresco_amps }
    end

    execute 'apply share amps' do
      command "java -jar alfresco-mmt.jar install #{amps_share_folder} #{share_webapps}/share.war -nobackup -directory -force"
      cwd bin_folder
      user unixUser if node['platform_family'] != 'windows'
      only_if { install_new_share_amps }
    end

    case node['platform_family']
    when 'windows'
      batch 'Cleanup webapps and temporary files' do
        code <<-EOH
            rmdir /q /s "#{alfresco_webapps}/alfresco"
            rmdir /q /s "#{share_webapps}/share"
            rmdir /q /s "#{tomcat_folder}/logs"
            md "#{tomcat_folder}/logs"
            rmdir /q /s "#{tomcat_folder}/temp"
            md "#{tomcat_folder}/temp"
            rmdir /q /s "#{tomcat_folder}/work"
            md "#{tomcat_folder}/work"
            EOH
        only_if { install_new_share_amps || install_new_alfresco_amps }
      end
    else
      execute 'Cleanup share/alfresco webapps and temporary files' do
        command "rm -rf #{alfresco_webapps}/alfresco; rm -rf #{share_webapps}/share"
        cwd bin_folder
        user unixUser
        only_if { install_new_share_amps || install_new_alfresco_amps }
      end

      execute 'Cleanup tomcat temporary files' do
        command "rm -rf #{tomcat_folder}/logs/*; rm -rf #{tomcat_folder}/temp/*; rm -rf #{tomcat_folder}/work/*"
        cwd bin_folder
        user unixUser
        only_if { install_new_share_amps || install_new_alfresco_amps }
      end
    end
  end
