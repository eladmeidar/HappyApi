module HTTParty
  class Request #:nodoc:
    SupportedHTTPMethods = [
      Net::HTTP::Get,
      Net::HTTP::Post,
      Net::HTTP::Put,
      Net::HTTP::Delete,
      Net::HTTP::Head,
      Net::HTTP::Purge
    ]
  end
end