module Helpers
  #Establishes a connection at the give url with faraday
  #return faradayConnection
  def getFaradayConnection (url)
    newConnection= Faraday.new(:url => url,
                               :headers => {'Host' => host_inventory['hostname']}) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
    return newConnection
  end
end
