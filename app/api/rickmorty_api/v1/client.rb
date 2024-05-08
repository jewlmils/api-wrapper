require 'faraday'

class RickmortyApi::V1::Client
  BASE_URL = 'https://rickandmortyapi.com/api'

  # Find a character using unique ID
  def get_character_by_id(id)
    request(
      http_method: :get,
      endpoint: "character/#{id}"
    )
  end

  # Find a episode using unique ID 
  def get_episode_by_name(episode_name)
    request(
      http_method: :get,
      endpoint: "episode?name=#{episode_name}"
    )
  end
  

  private

  def client
    @client ||= begin
      options = {
        request: {
          open_timeout: 10,
          read_timeout: 10
        }
      }
      Faraday.new(url: BASE_URL, **options) do |config|
        config.request :json
        config.response :json, parser_options: { symbolize_names: true }
        config.response :raise_error
        config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
      end
    end
  end

  def request(http_method:, endpoint:, params: {}, body: {})
    response = client.public_send(http_method, endpoint, params, body)
    {
      status: response.status,
      body: response.body
    }
  rescue Faraday::Error => e
    puts e.inspect
  end
end