require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
   @random_letters =  ("a".."z").to_a.sample(10)
  end

  def score
    @word = params[:word]
    @random_letters = params[:random_letters]
    @score = 0

    def inlcuded?(word,letters)
      word.split('').all? do |letter|
        word.count(letter) <= letters.count(letter)
      end
    end

    def english_word?(word)
      url = "https://wagon-dictionary.herokuapp.com/#{word}"
      word_checked = open(url).read
      word = JSON.parse(word_checked)
      word["found"]
    end

    if english_word?(@word) && inlcuded?(@word,@random_letters)
      @response = " your score is #{(@score += @word.length)}"
    elsif !english_word?(@word)
      @response = "not a english word!"
    elsif !inlcuded?(@word,@random_letters)
      @response = "you cannot build #{@word} from #{@random_letters} "
    end
  end
end
