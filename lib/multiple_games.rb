require 'pry'
require 'colorize'

require_relative 'board_case.rb'
require_relative 'board.rb'
require_relative 'player'
require_relative 'game'

#Class qui défini l'objet tournoi (plusieurs parties).
#C'est la class appelée dans app.rb (class chapeau de toutes les autres).

#Cette class comprend 4 méthodes : 
#1/une méthode qui gère l'introduction du jeu (dont la récupération des noms / tokens),
#2/une méthode qui vérifie si les joueurs veulent jouer la partie,
#3/une méthode qui fait touner une partie (grâce à la class game) et affiche le score du tournoi après chaque partie,
#4/une méthode qui affiche un message de fin de tournoi.

class MultiplesGames #gestion de parties multiples avec historiques
  attr_accessor :player1_name, :player2_name, :player1_token, :player2_token, :player1_score, :player2_score

  def initialize
    @player1_name = ""
    @player2_name = "" 
    @player1_token = "" 
    @player2_token = ""
    @player1_score = 0
    @player2_score = 0
  end 
  
  def intro #introduction pour le tournoi
    system ("clear")

    puts "____________________________________________________________________________".colorize(:light_cyan)
    print "|                     ".colorize(:light_cyan)
    print "Bienvenue sur 'MORPION MANIA' !".colorize:color => :light_magenta, :mode => :bold
    puts "                      |".colorize(:light_cyan)
    print "|       ".colorize(:light_cyan)
    print "Un jeu à deux pour découvrir qui est le meilleur stratège !".colorize(:light_magenta)
    puts "        |".colorize(:light_cyan)
    puts "|__________________________________________________________________________|".colorize(:light_cyan)

    puts "\nJOUEUR #1".colorize(:cyan)
    puts "Quel est ton prénom ?"
    print "> ".colorize(:magenta)
    @player1_name = gets.chomp
    puts "\nQuels jetons souhaites-tu ? (1 caractère seulement, exemples : ✿, ☆, △, une initiale, etc. )"
    print "> ".colorize(:magenta)
    @player1_token = gets.chomp
    
    while @player1_token.length != 1
      puts "\nMerci d'entrer un symbole de jeton valide.".colorize(:blue)
      print "> ".colorize(:magenta)
      @player1_token = gets.chomp
    end 
    
    puts "\nJOUEUR #2".colorize(:cyan)
    puts "Quel est ton prénom ?"
    print "> ".colorize(:magenta)
    @player2_name = gets.chomp
    puts "\nQuels jetons souhaites-tu ? (1 caractère seulement, exemples : ✿, ☆, △, une initiale, etc. )"
    print "> ".colorize(:magenta)
    @player2_token = gets.chomp

    while @player2_token.length != 1 || @player2_token == @player1_token
      puts "\nMerci d'entrer un symbole de jeton valide (et différent de celui choisi par #{@player1_name}).".colorize(:blue)
      print "> ".colorize(:magenta)
      @player2_token = gets.chomp
    end 

    puts "\nSuper, on est prêt pour commencer le jeux !\n".colorize(:light_magenta)
    puts "\nRappel des consignes :".colorize(:light_cyan)
    puts "Les deux joueurs jouent à tour de rôle, en plaçant leur symbole sur une case libre."
    puts "L'objectif est d'aligner trois symboles identiques en ligne horizontale, verticale ou diagonale pour gagner.\n\n"
  end 

  def ready_to_play #check avant de lancer la partie
    puts "\nEs-tu prêt pour (re)commencer ce DUEL ?".colorize(:color => :light_magenta, :mode => :bold)
    print "> ".colorize(:magenta)
    while check = 0
      user_answer = gets.chomp.upcase.rstrip
      if (user_answer == "OUI" || user_answer == "YES")
        check = 1
        return true 
      else 
        if (user_answer == "NON" || user_answer == "NO")
          check = 1
          return false
        else 
          puts ("Je n'ai pas compris ...").colorize(:blue)
        end 
      end 
    end 
  end 

  def one_game #jouer une partie

    #initialisation de la partie
    a_game = Game.new(self.player1_name, self.player2_name, self.player1_token, self.player2_token)
    system("clear")
    puts "& c'essttt partiii !!! \n\n".colorize(:color => :light_magenta, :mode => :bold)
    puts "Voici le plateau de jeu : \n\n"
    a_game.turn_board.display_board

    #partie en cours
    vic = loo = false
    while (vic == false && loo == false)
      a_game.turn
      vic = a_game.victory_test
      loo = a_game.turn_board.all_cases_used
    end 
    
    #fin de la partie
    a_game.end_of_a_game

    #affichage du score sur les dernières parties
    if a_game.winner == self.player1_name
      self.player1_score += 1
    else 
      if a_game.winner == self.player2_name
      self.player2_score += 1
      end
    end
    puts "\nLe score actuel est de #{self.player1_name} : #{self.player1_score} VS #{self.player2_name} : #{self.player2_score}\n"

  end 

  def the_end #fin du tournoi
    puts "\nMERCI d'avoir jouer à MORPION MANIA\n"
    puts "A bientôt".colorize(:magenta)
  end 

end 