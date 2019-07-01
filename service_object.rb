require 'nokogiri'
require 'open-uri'
require_relative 'recipe'
require 'pry-byebug'

class ServiceObject
  # def initialize
  #   @view = View.new
  # end

  def recipe_to_import(ingredient)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    # file = 'lib/strawberry.html'
    # doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
    recipes = []
    doc.search('.m_contenu_resultat').each do |element|
      name = element.search('.m_titre_resultat').text.strip
      description = element.search('.m_texte_resultat').text.strip
      prep_time = element.search('.m_detail_time > div:first').text.strip
      difficulty = element.search('.m_detail_recette').text.strip.split(" - ")[2]
      recipe = Recipe.new(
        name: name,
        description: description,
        prep_time: prep_time,
        difficulty: difficulty,
        done: false
      )
      recipes << recipe
    end
  recipes.first(5)
  end
end

