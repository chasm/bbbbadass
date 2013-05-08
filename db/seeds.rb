User.destroy_all

user = User.create _id: SecureRandom.uuid,
  name: 'Chas.',
  email: 'chas@munat.com',
  is_admin: true,
  password: '123',
  password_confirmation: '123',
  phone_numbers: [
    {
      _id: SecureRandom.uuid,
      area_code: '206',
      line_number: '925-3872',
      phone_type: 'voip'
    },
    { 
      _id: SecureRandom.uuid,
      area_code: '206',
      line_number: '842-4896',
      phone_type: 'home'
    }
  ]
