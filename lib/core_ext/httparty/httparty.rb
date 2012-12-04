module HTTParty
  module ClassMethods
    # Perform a HEAD request to a path
    def purge(path, options={}, &block)
      perform_request Net::HTTP::Purge, path, options, &block
    end
  end
end