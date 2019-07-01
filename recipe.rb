class Recipe
  attr_reader :name, :description, :prep_time, :difficulty, :done

# name, description, prep_time = nil, difficulty = nil, done = false

  def initialize(attr = {})
    @name = attr[:name]
    @description = attr[:description]
    @prep_time = attr[:prep_time]
    @difficulty = attr[:difficulty]
    @done = attr[:done] == "true"
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

end
