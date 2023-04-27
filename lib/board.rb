require 'pry'

require_relative 'board_case.rb'

class Board
  attr_accessor :board_cases

  def initialize
    @board_cases = {}
    3.times do |x|
      3.times do |y|
        @board_cases["#{(x+65).chr}#{y+1}"] = BoardCase.new("#{(x+65).chr}#{y+1}")
      end
    end
  end 

  def display_board #affiche le plateau seul
    #tokens_on_the_board? #actualisation de l'affichage des jetons

    puts "╭───┬───┬───╮"
    puts "│#{self.board_cases["A1"].display}│#{self.board_cases["B1"].display}│#{self.board_cases["C1"].display}│"
    puts "├───┼───┼───┤"
    puts "│#{self.board_cases["A2"].display}│#{self.board_cases["B2"].display}│#{self.board_cases["C2"].display}│"
    puts "├───┼───┼───┤"
    puts "│#{self.board_cases["A3"].display}│#{self.board_cases["B3"].display}│#{self.board_cases["C3"].display}│"
    puts "╰───┴───┴───╯"

  end 

  #def tokens_on_the_board?#(token) #affiche le plateau avec les jetons 
  #  token = "X" #A SUPPRIMER
  
  #  self.board_cases.each do |key,one_case|
  #    one_case.used == 1 ? one_case.display = " #{token} " : nil
  #  end  
  #end 
  
end 

#test = Board.new
#test.display_board
#puts test.board_cases.keys
#test.board_cases["A1"].name_case
#binding.pry