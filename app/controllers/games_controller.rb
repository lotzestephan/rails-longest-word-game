require "open-uri"

class GamesController < ApplicationController
  def new
    @letter_array = []
    10.times { @letter_array << ('a'..'z').to_a[rand(0..25)] }
  end

  def score
    @word = params[:word].downcase
    @letters = params[:letters].split(' ')
    word_array = @word.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    if JSON.parse(open(url).read)['found'] == false
      @score = "Sorry, but #{@word} is not a valid word!"
    elsif word_array != word_array.select { |l| params[:letters].include?(l) }
      @score = "Sorry, but #{@word} cannot be built out of the listed words"
    else
      @score = "Congrats, #{@word} is a valid English word!"
    end
  end
end
