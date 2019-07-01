# this is our router and controller
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'cookbook'
require_relative 'recipe'
require_relative 'service_object'
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

CSV_PATH = File.join(__dir__, 'recipes.csv')
COOKBOOK = Cookbook.new(CSV_PATH)
SERVICEOBJECT = ServiceObject.new

get '/' do
  @cookbook = COOKBOOK.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  recipe = Recipe.new(
    name: params[:name],
    description: params[:description],
    prep_time: params[:prep_time],
    difficulty: params[:difficulty]
  )
  COOKBOOK.add_recipe(recipe)
  redirect to('/')
end

post '/delete' do
  COOKBOOK.remove_recipe(params[:index].to_i)
  redirect to('/')
end

post '/import' do
  ingredient = params[:ingredient]
  @import = SERVICEOBJECT.recipe_to_import(ingredient)
  erb :import
end


# get '/about' do
#   erb :about
# end

# get '/team/:username' do
#   # binding.pry
#   puts params[:username]
#   "The username is #{params[:username]}"
# end

