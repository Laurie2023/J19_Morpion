class MultiplesGames #gestion de parties multiples avec historiques
  attr_accessor :player1_name, :player2_name, :player1_token, :player2_token

  def intro #message de début de partie
    puts "BIENVENU.E DANS NOTRE SUPER JEU"

    puts "JOUEUR #1"
    pust "Quel est ton prénom ?"
    print "> "
    @player1_name = gets.chomp
    pust "Quels jetons souhaites-tu ?"
    print "> "
    @player1_token = gets.chomp

    puts "JOUEUR #2"
    pust "Quel est ton prénom ?"
    print "> "
    @player2_name = gets.chomp
    pust "Quels jetons souhaites-tu ?"
    print "> "
    @player2_token = gets.chomp
  end 

  def one_game 
    a_game = Game.new(self.player1_name, self.player2_name, self.player1_token, self.player2_token)
  end 

end 