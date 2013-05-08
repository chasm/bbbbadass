object false

node do
  {
    environment: Rails.env,
    uuids: get_uuids(25),
    phone_types: PhoneNumber.phone_types,
    address_types: StreetAddress.address_types
  }
end