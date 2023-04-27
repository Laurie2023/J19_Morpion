require 'pry'
require 'colorize'

#Class qui défini l'objet joueur (player) 

class Player
  attr_accessor :name_player, :token_player, :score 

  def initialize(name_to_save, token_to_save)
    @name_player = name_to_save
    @token_player = token_to_save
  end 

end 