require 'pry'

class Player
  attr_accessor :name_player, :token_player #:color ajouter choix d'une couleur si temps à la fin 

  def initialize(name_to_save, token_to_save)
    @name_player = name_to_save
    @token_player = token_to_save
  end 

  def score_histo #enregistrement le score du joueur à chaque partie 
  end 


end 

#test = Player.new("Laurie","X")
#binding.pry