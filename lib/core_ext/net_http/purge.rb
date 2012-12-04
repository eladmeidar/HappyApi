class Net::HTTP::Purge < Net::HTTP::Head
  METHOD = "PURGE"
  REQUEST_HAS_BODY = false
  RESPONSE_HAS_BODY = false
end