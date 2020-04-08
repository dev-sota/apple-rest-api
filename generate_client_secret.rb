# sudo gem install jwt
#
# ruby generate_client_secret.rb
#

require 'jwt'

# parameters
key_file  = ENV['KEY_FILE']
key_id    = ENV['KEY_ID']
client_id = ENV['CLIENT_ID']
team_id   = ENV['TEAM_ID']

ecdsa_key = OpenSSL::PKey::EC.new IO.read key_file

headers = {
  'kid': key_id
}

claims = {
  'iss': team_id,
  'sub': client_id,
  'aud': 'https://appleid.apple.com',
  'exp': Time.now.to_i + 86400*180,
  'iat': Time.now.to_i,
}

token = JWT.encode claims, ecdsa_key, 'ES256', headers

puts token
