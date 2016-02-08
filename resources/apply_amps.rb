  # Used for applying amps on alfresco and share
  resource_name :apply_amps

  property :resource_title, String, name_property: true
  property :amps_folder, String, default: lazy { node['alfresco']['amps_folder'] }
  property :amps_share_folder, String, default: lazy { node['alfresco']['amps_share_folder'] }
  property :share_amps, default: lazy { node['amps']['share'] }
  property :alfresco_amps, default: lazy { node['amps']['repo'] }
  property :bin_folder, String, default: lazy { node['alfresco']['bin'] }
  property :alfresco_webapps, String, default: lazy {node['artifacts']['alfresco']['destination']}
  property :share_webapps, String, default: lazy {node['artifacts']['share']['destination']}
  property :alfresco_root, String, required: true
  property :share_root, String, required: true
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
      batch 'Cleanup alfresco webapps and temporary files' do
        code <<-EOH
            rmdir /q /s "#{alfresco_webapps}/alfresco"
            rmdir /q /s "#{alfresco_root}/logs"
            md "#{alfresco_root}/logs"
            rmdir /q /s "#{alfresco_root}/temp"
            md "#{alfresco_root}/temp"
            rmdir /q /s "#{alfresco_root}/work"
            md "#{alfresco_root}/work"
            EOH
        only_if { install_new_alfresco_amps }
      end
      batch 'Cleanup share webapps and temporary files' do
        code <<-EOH
            rmdir /q /s "#{share_webapps}/share"
            rmdir /q /s "#{share_root}/logs"
            md "#{share_root}/logs"
            rmdir /q /s "#{share_root}/temp"
            md "#{share_root}/temp"
            rmdir /q /s "#{share_root}/work"
            md "#{share_root}/work"
            EOH
        only_if { install_new_share_amps }
      end
    else
      execute 'Cleanup alfresco webapps and temporary files' do
        command "rm -rf #{alfresco_webapps}/alfresco; rm -rf #{alfresco_root}/logs/*; rm -rf #{alfresco_root}/temp/*; rm -rf #{alfresco_root}/work/*"
        cwd bin_folder
        user unixUser
        only_if { install_new_alfresco_amps }
      end

      execute 'Cleanup share webapps and temporary files' do
        command "rm -rf #{share_webapps}/share; rm -rf #{share_root}/logs/*; rm -rf #{share_root}/temp/*; rm -rf #{share_root}/work/*"
        cwd bin_folder
        user unixUser
        only_if { install_new_share_amps }
      end

    end
  end
