require 'pry'

require_relative 'board_case.rb'
require_relative 'board.rb'
require_relative 'player.rb'

class Game #définit une partie de morpion
  attr_accessor :turn_board, :turn_players #A REVOIR
  
  def initialize(user_name_1,  user_name_2, user_token_1, user_token_2)
    @turn_board = Board.new
    @turn_players = [Player.new(user_name_1, user_token_1),Player.new(user_name_2, user_token_2)]
  end 

  def turn #gestion d'un tour de jeu (un mouvement par joueur)
    self.turn_players.each do |player| #2 joueurs au morpion obligatoirement

      #initialisation du tour du joueur
      puts "C'est ton tour #{player.name_player}"
      print "> "
      user_choice_case = gets.chomp.to_s.upcase
      user_choice_case.rstrip!

      #check si la réponse du joueur est valide
      user_choice_case = test_if_the_case_is_used(user_error_management(user_choice_case))

      #le mouvement du joueur est comptabilisé
      self.turn_board.board_cases[user_choice_case].display = " #{player.token_player} " 
      self.turn_board.board_cases[user_choice_case].used = 1
      puts "Super mouvement !"

      #actualisation du plateau de jeu
      self.turn_board.display_board
    end 
    puts "Fin du tour"
  end 

  def test_if_the_case_is_used(user_choice_case) #vérifie si la case est libre dès qu'un joueur veut poser un jeton  
    check = 0
    while check == 0
      if self.turn_board.board_cases[user_choice_case].used == 1 
        puts "Cette case est déjà prise - Merci de choisir une autre case."
        print "> "
        user_choice_case = user_error_management(gets.chomp)
      else 
        check =1
      end 
    end 
    return user_choice_case
  end 

  def user_error_management(user_choice_case) #gestion des potentielles erreurs dans les entrées utilisateurs
    check = 0
    while check == 0
      if /^[ABC][123]$/.match(user_choice_case) == nil 
        puts "Choix de mouvement incorrect, la donnée entrée ne correspond pas à une coordonnée de case."
        puts "Merci d'entrer une coordonnée correcte (exemple : A3)"
        print "> "
        user_choice_case = gets.chomp.upcase
        user_choice_case.rstrip!
      else 
        check = 1
      end 
    end 
    return user_choice_case
  end 

  def victory_test #test à chaque mouvement si un joueur a gagné
  end 

  def end #gestion de la fin partie
  end 

end 

test = Game.new("Laurie","Ted","X","O")
test.turn