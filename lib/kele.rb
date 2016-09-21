require "kele/version"
require "httparty"
require "roadmap"

class Kele
  include HTTParty
  include Roadmap

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

  def get_mentor_id
    @mentor_id = self.get_me.dig("current_enrollment", "mentor_id")
  end

  def get_mentor_availability(mentor_id = nil)
    mid = mentor_id.nil? ? get_mentor_id : mentor_id
    response = self.class.get("#{@api_url}/mentors/#{mid}/student_availability", headers: {"authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

  def get_messages(page = nil)
    options = {
      headers: { "authorization" => @auth_token }
    }
    if page
      options["body"] = {
        page: page
      }
    end
    response = self.class.get("#{@api_url}/message_threads", options)
    @mentor_availability = JSON.parse(response.body)
  end

  def create_message(thread = nil, subject = nil, message = nil)
    options = {
      headers: { "authorization" => @auth_token },
      body: {
              user_id: get_me["id"],
              recipient_id: get_mentor_id,
              subject: subject,
              "stripped-text": message
            }
    }
    options[:body][:token] = thread if thread
    response = self.class.post("#{@api_url}/messages", options)
    raise "error" if response.code != 200
  end
end
