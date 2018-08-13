require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:answer]
    @included = included?
    @letters = params[:letters]
    @english_word = english_word?
    @final_score = @guess.chars.count
  end

  def included?
    @guess.chars.all? { |letter| @guess.count(letter) <= params[:letters].chars.count(letter) }
  end

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{@guess}")
    json = JSON.parse(response.read)
    json['found']
  end
end

# def score_and_message(attempt, grid, time)
#   if included?(attempt.upcase, grid)
#     if english_word?(attempt)
#       score = compute_score(attempt, time)
#       [score, "well done"]
#     else
#       [0, "not an english word"]
#     end
#   else
#     [0, "not in the grid"]
#   end
# end

