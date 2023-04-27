require 'bundler'
Bundler.require 

require 'pry'
require 'colorize'

require_relative 'lib/board_case.rb'
require_relative 'lib/board.rb'
require_relative 'lib/game.rb'
require_relative 'lib/multiple_games.rb'
require_relative 'lib/player.rb'

#Application qui permet de jouer un tournoi de Morpion (plusieurs parties à la suite).
#Nombre de joueurs : 2 personnes.

my_game = MultiplesGames.new

my_game.intro

user_answer = my_game.ready_to_play

while user_answer == true 
  my_game.one_game
  user_answer = my_game.ready_to_play
end 

my_game.the_end