require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  char_hash = get_char_hash(response_hash, character_name)
  sorted_array = char_hash["films"].sort
  info_hash(sorted_array)
  binding.pry
end

  def get_char_hash(response_hash, character_name)
  response_hash["results"].find{|character| character["name"] == character_name}
  end

  def info_hash(array)
    film_data_response = array.map{|url| RestClient.get(url)}
    film_data_aoh = film_data_response.map{|string| JSON.parse(string)}
  end


def print_movies(films)
  film = films.map{|film_data| film_data["title"]}
  film.each_with_index{|title, index| puts "#{index+1} #{title}"}

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
  binding.pry
end

# iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
