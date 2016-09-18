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

  def get_me
    response = self.class.get("#{@api_url}/users/me", headers: { "authorization" => @auth_token })
    @user_account = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("#{@api_url}/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end
end
