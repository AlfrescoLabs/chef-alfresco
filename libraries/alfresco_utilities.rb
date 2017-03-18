class Array
  def ljust!(n, x)
    fill(x, length...n)
  end
end

# Utility library to compare two different Alfresco versions
module AlfrescoHelper
  # is the current Alfresco version set in the attributes greater than this one?
  def alf_version_gt?(version)
    origin = alf_version.split('.')
    compare = version.split('.')
    if origin.length > compare.length
      compare.ljust!(origin.length, '0')
    elsif origin.length < compare.length
      origin.ljust!(compare.length, '0')
    end
    origin.each_index do |element|
      return true if origin[element] > compare[element]
      next if origin[element] == compare[element]
      return false
    end
    false
  end

  # is the current Alfresco version set in the attributes greater or equal than this one?
  def alf_version_ge?(version)
    origin = alf_version.split('.')
    compare = version.split('.')
    if origin.length > compare.length
      compare.ljust!(origin.length, '0')
    elsif origin.length < compare.length
      origin.ljust!(compare.length, '0')
    end
    origin.each_index do |element|
      return true if origin[element] > compare[element]
      next if origin[element] == compare[element]
      return false
    end
    true
  end

  # is the current Alfresco version set in the attributes less than this one?
  def alf_version_lt?(version)
    !alf_version_ge?(version)
  end

  # is the current Alfresco version set in the attributes less or equal than this one?
  def alf_version_le?(version)
    !alf_version_gt?(version)
  end

  # get Alfresco version from node - using method for testing purpose
  def alf_version
    node['alfresco']['version']
  end
end

Chef::Recipe.send(:include, AlfrescoHelper)
