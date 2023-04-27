class BoardCase
  attr_accessor :name_case, :used, :display

  def initialize (name_to_save)
     @name_case = name_to_save
     @used = 0
     @display = "   "
  end 
  
end 