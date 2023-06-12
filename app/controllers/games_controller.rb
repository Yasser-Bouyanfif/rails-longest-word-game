require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @arr = Array.new(10) { ("a".."z").to_a.sample }
  end

  def word_exists?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serial = URI.open(url).read
    deserialized = JSON.parse(serial)
    return deserialized["found"]
  end
  # puts word_exists?("tomato")

  def included?(word, arr)
    word.chars.all? { |letter| arr.include?(letter) }
  end

  def score
    @word = params[:word]
    @arr = params[:array]
    if word_exists?(@word)
      if included?(@word, @arr)
        @score = "Congratulations! #{@word.upcase} is a valid English word!"
      else
        @score = "Sorry but #{@word.upcase} can't be built ouf of #{@arr.split(",")}"
    end
  else
    @score = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
  end
  end
end
