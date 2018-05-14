require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample}
  end

  def score
    @answer = params[:answer].upcase
    @letters = params[:letters]
    if included?(@answer, @letters) == true &&
      english_word?(@answer) == true
      @score = "well done"
    else
      @score = "try again"
    end
  end


  def included?(answer, letters_string)
    @answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
  end

  def english_word?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    return json['found']
  end


end
