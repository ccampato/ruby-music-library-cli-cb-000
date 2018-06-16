require 'pry'
class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre
  @@all= []

  def initialize(name, artist = nil, genre = nil)
    @name= name
    self.artist= artist if artist
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre =  genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end

  def self.find_by_name(name)
    self.all.detect do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file_name)
    array = file_name.split(" - ")
    title = array[1]
    artist_name = array[0]
    genre_name = (array[2].chomp(".mp3"))

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new_song = Song.new(title,artist,genre)
  end

  def self.create_from_filename(file_name)
    self.new_from_filename(file_name).save
  end

end
