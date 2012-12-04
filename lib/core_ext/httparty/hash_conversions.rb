module HTTParty
  module HashConversions
    def self.to_params(hash)
      params = hash.map { |k,v| normalize_param(k,v) }.sort.join
      params.chop! # trailing &
      params
    end
  end
end