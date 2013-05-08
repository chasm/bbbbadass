class PhoneNumber
  include MongoMapper::EmbeddedDocument
  
  def self.phone_types
    ['mobile', 'work', 'home', 'fax', 'voip', 'pager']
  end
  
  attr_accessible :_id, :area_code, :line_number, :extension, :purpose

  key :_id, String, :required => true
  key :area_code, String, :required => true
  key :line_number, String, :required => true
  key :extension, String
  key :purpose, String, :required => true, :in => self.phone_types

end
