require 'pry'
class MusicLibraryController

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    while input != 'exit'
      puts "What would you like to do?"
      input = gets.strip
      list_songs(*(any args)) if input == "list songs"
    end
  end

  def list_artists
    sorted_array = Artist.all.sort_by { |a| a.name }
    sorted_array.each_with_index { |a, index| puts "#{index+1}. #{a.name}"  }
  end

  def list_genres
    sorted_array = Genre.all.sort_by { |genre| genre.name }
    sorted_array.each_with_index { |genre, index| puts "#{index+1}. #{genre.name}"  }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    artist = Artist.find_or_create_by_name(artist_name)
    artist_songs = artist.songs.sort_by { |song| song.name }
    artist_songs.each_with_index { |song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    genre = Genre.find_or_create_by_name(genre_name)
    genre_songs = genre.songs.sort_by { |song| song.name }
    genre_songs.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
  end

  def list_songs
    list = Song.all.sort_by { |song| song.name }
    list.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets
    index = input.to_i - 1
    songs = Song.all.sort_by { |song| song.name }
    begin
      if index > 0
        matching_song = songs[index]
        matching_song_name = matching_song.name
        matching_song_artist = matching_song.artist.name
        puts "Playing #{matching_song_name} by #{matching_song_artist}"
      end
    rescue
      nil
    end
  end

end
