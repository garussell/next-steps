require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "validations" do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_presence_of :password}
    it { should have_secure_password }
  end

  describe 'Instance Methods' do
    it 'creates a new user with response from OAuth provider' do
      response = {"provider"=>"google_oauth2",
                  "uid"=>"117787023446397549870",
                  "info"=>
                  {"name"=>"Jerry smith",
                    "email"=>"jerrysmith@gmail.com",
                    "unverified_email"=>"jerrysmith",
                    "email_verified"=>true,
                    "first_name"=>"Jerry",
                    "last_name"=>"smith",
                    "image"=>
                    "https://lh3.googleusercontent.com/a/ACg8ocJjMIaawzjyMkL8cAApTTJ8W2ANwrHnd5zFCso_zlGyMBQ=s96-c"},
                  "credentials"=>
                  {"token"=>
                    "ya29.a0AfB_byDcnVhbTnIegC6eTr-UXgpm0FkimZVNU_vIq-8diUkqiEribisb4zMiuyutNJmpvK4Up2BARUSAHEU0R7o_FJtj-eAPyPz4mXNwNMGYBy9FA0-aThcn8LnwZJtuOTo_AFtFqNBh_ter-diL3XUayu8jAGTbOgaCgYKAcgSARASFQGOcNnCBJU42Qgf6CqUniQn-fO0NA0169",
                    "expires_at"=>1695071273,
                    "expires"=>true},
                  "extra"=>
                  {"id_token"=>
                    "eyJhbGciOiJSUzI1NiIsImtpZCI6IjdjMGI2OTEzZmUxMzgyMGEzMzMzOTlhY2U0MjZlNzA1MzVhOWEwYmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIzNzczMDQyODU0ODEtdWoxNzJlbzVkbzl2dHZuYXFiMmtydGdkNGkzaHBvdTEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIzNzczMDQyODU0ODEtdWoxNzJlbzVkbzl2dHZuYXFiMmtydGdkNGkzaHBvdTEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTc3ODcwMjM0NDYzOTc1NDk4NzAiLCJlbWFpbCI6Ind0c2NodXR0QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiakFZbG9icU9ZTVB4QjU2NGQxcHE0QSIsIm5hbWUiOiJXZXN0b24gU2NodXR0IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0pqTUlhYXd6anlNa0w4Y0FBcFRUSjhXMkFOd3JIbmQ1ekZDc29femxHeU1CUT1zOTYtYyIsImdpdmVuX25hbWUiOiJXZXN0b24iLCJmYW1pbHlfbmFtZSI6IlNjaHV0dCIsImxvY2FsZSI6ImVuIiwiaWF0IjoxNjk1MDY3Njc0LCJleHAiOjE2OTUwNzEyNzR9.eiGqzmgsRMdGyuE-3Nh_Ht9UnZYzaPgIqmZv7hjGK4EiZFOOj6vvB9mhvMBdVchkjP0UeMpmxGRmwXCbaDunDMuYcJa8Di5db8I57gMGAgqoseykBTzUqJV_-npw3mWWZd80ue-D5oJb2fO-5xahYMmEEnPOnt7ND5ZTsBAGrCL0HbJcAawhUijN3dZdZJfB5ESxJ2VIAXkTtKbkcTXHmYcbC8q8CJw6uZ-QC5qxqsghH_o814pxPDRq4WgGaXAJUONmaXu6tMGDbTBh-q1VehZB8NUeRzJAl6Jx119yyRinZTsfAo97lCnP4ELzdmPp8ROOAHp6dSQyWvlbNxiiAA",
                    "id_info"=>
                    {"iss"=>"https://accounts.google.com",
                      "azp"=>
                      "377304285481-uj172eo5do9vtvnaqb2krtgd4i3hpou1.apps.googleusercontent.com",
                      "aud"=>
                      "377304285481-uj172eo5do9vtvnaqb2krtgd4i3hpou1.apps.googleusercontent.com",
                      "sub"=>"117787023446397549870",
                      "email"=>"jerrysmith",
                      "email_verified"=>true,
                      "at_hash"=>"jAYlobqOYMPxB564d1pq4A",
                      "name"=>"Jerry smith",
                      "picture"=>
                      "https://lh3.googleusercontent.com/a/ACg8ocJjMIaawzjyMkL8cAApTTJ8W2ANwrHnd5zFCso_zlGyMBQ=s96-c",
                      "given_name"=>"Jerry",
                      "family_name"=>"smith",
                      "locale"=>"en",
                      "iat"=>1695067674,
                      "exp"=>1695071274},
                    }}

      expect { User.from_omniauth(response) }.to change { User.count }.by(1)
    end
  end
end
