class RickmortyApiController < ApplicationController
    def character_by_id
      client = RickmortyApi::V1::Client.new
      result = client.get_character_by_id(params[:id])
      render json: result
    end
  
    def episode_by_name
      client = RickmortyApi::V1::Client.new
      result = client.get_episode_by_name(params[:name])
      render json: result
    end
  end
