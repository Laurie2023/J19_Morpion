require 'pry'
require 'colorize'

require_relative 'board_case.rb'

#Class qui défini l'objet plateau de jeu (board), notamment via la création de 9 cases (board_case)

#Cette class comprend 2 méthodes : 
#1/l'affichage du plateau de jeu, 
#2/un test qui vérifie si toutes les cases du plateau sont occupées.

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

    puts "    A   B   C".colorize(:light_black)
    puts "  ╭───┬───┬───╮"
    print "1 ".colorize(:light_black)
    puts "│#{self.board_cases["A1"].display}│#{self.board_cases["B1"].display}│#{self.board_cases["C1"].display}│"
    puts "  ├───┼───┼───┤"
    print "2 ".colorize(:light_black)
    puts "│#{self.board_cases["A2"].display}│#{self.board_cases["B2"].display}│#{self.board_cases["C2"].display}│"
    puts "  ├───┼───┼───┤"
    print "3 ".colorize(:light_black)
    puts "│#{self.board_cases["A3"].display}│#{self.board_cases["B3"].display}│#{self.board_cases["C3"].display}│"
    puts "  ╰───┴───┴───╯"

  end 

  def all_cases_used #vérifie si toutes les cases du plateau sont occupées
    used_cases_on_board = self.board_cases.select{|key,item_boardcase|item_boardcase.used == 1}
    used_cases_on_board.length == self.board_cases.length ? true : false
  end 
end 