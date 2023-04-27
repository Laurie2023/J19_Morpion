require 'pry'
require 'colorize'

require_relative 'board_case.rb'
require_relative 'board.rb'
require_relative 'player.rb'

#Class qui défini l'objet partie (game), notamment via la création d'un plateau de jeu et de 2 joueurs.

#Cette class comprend 5 méthodes : 
#1/une méthode qui s'occupe de la coordination d'un tour de jeu (un mouvement pour chaque joueur), 
#2/une méthode qui vérifie si une case est déjà occupée,
#3/une méthode qui vérifie les coordonnées entrées par le joueur,
#4/une méthode qui vérifie si l'un des joueurs a gagné,
#4/une méthode qui affiche le résultat en fin de partie.

class Game 
  attr_accessor :turn_board, :turn_players, :victory, :winner 
  
  def initialize(user_name_1,  user_name_2, user_token_1, user_token_2)
    @turn_board = Board.new
    @turn_players = [Player.new(user_name_1, user_token_1),Player.new(user_name_2, user_token_2)]
    @winner = nil
    @victory = [
      [self.turn_board.board_cases["A1"].owner,self.turn_board.board_cases["A2"].owner,self.turn_board.board_cases["A3"].owner],
      [self.turn_board.board_cases["B1"].owner,self.turn_board.board_cases["B2"].owner,self.turn_board.board_cases["B3"].owner],
      [self.turn_board.board_cases["C1"].owner,self.turn_board.board_cases["C2"].owner,self.turn_board.board_cases["C3"].owner],
      [self.turn_board.board_cases["A1"].owner,self.turn_board.board_cases["B1"].owner,self.turn_board.board_cases["C1"].owner],
      [self.turn_board.board_cases["A2"].owner,self.turn_board.board_cases["B2"].owner,self.turn_board.board_cases["C2"].owner],
      [self.turn_board.board_cases["A3"].owner,self.turn_board.board_cases["B3"].owner,self.turn_board.board_cases["C3"].owner],
      [self.turn_board.board_cases["A1"].owner,self.turn_board.board_cases["B2"].owner,self.turn_board.board_cases["C3"].owner]
      ]
  end 

  def turn #gestion d'un tour de jeu (un mouvement par joueur)
    self.turn_players.each_with_index do |player,index| 

      #initialisation du tour du joueur
      puts "\nC'est ton tour #{player.name_player}"
      print "> ".colorize(:magenta)
      user_choice_case = gets.chomp.to_s.upcase
      user_choice_case.rstrip!

      #check si la réponse du joueur est valide
      user_choice_case = test_if_the_case_is_used(user_error_management(user_choice_case))

      #le mouvement du joueur est comptabilisé
      index == 0 ? self.turn_board.board_cases[user_choice_case].display = " #{player.token_player.colorize(:yellow)} " : self.turn_board.board_cases[user_choice_case].display = " #{player.token_player.colorize(:blue)} "
      self.turn_board.board_cases[user_choice_case].used = 1
      self.turn_board.board_cases[user_choice_case].owner = player.name_player
      puts "Super mouvement !"

      #actualisation de l'array victory
      @victory = [
      [self.turn_board.board_cases["A1"].owner,self.turn_board.board_cases["A2"].owner,self.turn_board.board_cases["A3"].owner],
      [self.turn_board.board_cases["B1"].owner,self.turn_board.board_cases["B2"].owner,self.turn_board.board_cases["B3"].owner],
      [self.turn_board.board_cases["C1"].owner,self.turn_board.board_cases["C2"].owner,self.turn_board.board_cases["C3"].owner],
      [self.turn_board.board_cases["A1"].owner,self.turn_board.board_cases["B1"].owner,self.turn_board.board_cases["C1"].owner],
      [self.turn_board.board_cases["A2"].owner,self.turn_board.board_cases["B2"].owner,self.turn_board.board_cases["C2"].owner],
      [self.turn_board.board_cases["A3"].owner,self.turn_board.board_cases["B3"].owner,self.turn_board.board_cases["C3"].owner],
      [self.turn_board.board_cases["A1"].owner,self.turn_board.board_cases["B2"].owner,self.turn_board.board_cases["C3"].owner],
      [self.turn_board.board_cases["A3"].owner,self.turn_board.board_cases["B2"].owner,self.turn_board.board_cases["C1"].owner]
      ]   

      #actualisation du plateau de jeu
      system("clear")
      self.turn_board.display_board

      #check si le joueur a gagné ou si toutes les cases sont prises
      if victory_test == true 
        self.winner = player.name_player
        break
      else 
        if self.turn_board.all_cases_used == true
        break 
        end
      end
      
    end 
  end 

  def test_if_the_case_is_used(user_choice_case) #vérifie si la case est libre quand qu'un joueur veut poser un jeton  
    check = 0
    while check == 0
      if self.turn_board.board_cases[user_choice_case].used == 1 
        puts "Cette case est déjà prise - Merci de choisir une autre case.".colorize(:blue)
        print "> ".colorize(:magenta)
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
        puts "Choix de mouvement incorrect, la donnée entrée ne correspond pas à une coordonnée de case.".colorize(:blue)
        puts "Merci d'entrer une coordonnée correcte (exemple : A3)".colorize(:blue)
        print "> ".colorize(:magenta)
        user_choice_case = gets.chomp.upcase
        user_choice_case.rstrip!
      else 
        check = 1
      end 
    end 
    return user_choice_case
  end 

  def victory_test #test si un joueur a gagné
    check = 0
    (self.victory).each do |arr|
      ((arr[0]!=nil) && (arr.uniq.size == 1)) ? check += 1 : check += 0
    end 
    return check == 1 ? true : false
  end 

  def end_of_a_game #gestion de la fin partie
    puts self.winner == nil ? "\nAucun joueur n'a gagné".colorize(:red) : "\n#{self.winner.upcase} a gagné !!!!".colorize(:magenta)
    return self.winner
  end 

end 
