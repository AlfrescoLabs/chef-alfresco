class Array
  def ljust!(n, x); fill(x, length...n) end
end

# Utility library to compare two different Alfresco versions
module AlfrescoHelper

  # is the current Alfresco version set in the attributes greater than this one?
  def alf_version_gt?(version)
    origin = alf_version.split('.')
    compare = version.split('.')
    if origin.length > compare.length
      compare.ljust!(origin.length, "0")
    elsif origin.length < compare.length
      origin.ljust!(compare.length, "0")
    end
    origin.each_index do |element|
      if origin[element] > compare[element]
        return true
      elsif origin[element] == compare[element]
        next
      else
        return false
      end
    end
    return false
  end

  # is the current Alfresco version set in the attributes greater or equal than this one?
  def alf_version_ge?(version)
    origin = alf_version.split('.')
    compare = version.split('.')
    if origin.length > compare.length
      compare.ljust!(origin.length, "0")
    elsif origin.length < compare.length
      origin.ljust!(compare.length, "0")
    end
    origin.each_index do |element|
      if origin[element] > compare[element]
        return true
      elsif origin[element] == compare[element]
        next
      else
        return false
      end
    end
    return true
  end

  # is the current Alfresco version set in the attributes less than this one?
  def alf_version_lt?(version)
    return !alf_version_ge?(version)
  end

  # is the current Alfresco version set in the attributes less or equal than this one?
  def alf_version_le?(version)
    return !alf_version_gt?(version)
  end

  def alf_version
    return node['alfresco']['version']
  end

end

Chef::Recipe.send(:include, AlfrescoHelper)
