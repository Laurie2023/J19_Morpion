require 'pry'
require 'colorize'

#Class qui défini l'objet case d'un plateau de jeu (board case) 

class BoardCase
  attr_accessor :name_case, :used, :display, :owner

  def initialize (name_to_save)
     @name_case = name_to_save
     @used = 0
     @display = "   "
     @owner = nil
  end 
  
end 