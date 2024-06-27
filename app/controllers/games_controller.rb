require 'open-uri'
require 'json'

class GamesController < ApplicationController


  def new
    @letters = ('a'..'z').to_a.sample(10)
    # raise
  end

  def score
    # raise
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    response = URI.open(url).read
    dictionary = JSON.parse(response)
    validated = params[:word].chars.map { |letter| params[:letters].include?(letter) }
    @valid = !validated.include?(false) && dictionary["found"]
    @score = params[:score].nil? ? 0 : params[:score].to_i
    @result = ""
    if @valid
      @result = "valid"
      @score+=1
      # @reason = "Sorry #{params[:word]} cant be built from #{params[:letters]}" if validated.include?(false)
      # @reason = "Sorry it #{params[:word]} seems to be not an english word" if !dictionary[:found]
    else
      @result = "not an english word" if !dictionary["found"]
      @result = "can't make word from the grid" if validated.include?(false)
    end
  end

end
