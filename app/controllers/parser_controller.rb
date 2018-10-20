class ParserController < ApplicationController
  def index
    begin  
      json = Parser.parse(params[:url]) 
      render json: json, status: :ok
    rescue Error => e  
      puts e.message  
      render json: {'error': 'error'}, status: :bad_request
    end 
  end
end
