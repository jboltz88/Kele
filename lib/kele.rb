require "kele/version"
require "httparty"

class Kele
  include HTTParty

  def initialize(email, password)
    @api_url = "https://www.bloc.io/api/v1"
    response = self.class.post("#{@api_url}/sessions", body: {email: email, password: password})
    raise "invalid email/pass" if response.code != 200
    #puts response.to_hash.inspect
    @auth_token = response["auth_token"]
  end

  # url = "#{@api_url}/users/me"
end
