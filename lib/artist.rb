require 'pry'
class Artist
  extend Concerns::Findable

  attr_accessor :name
  @@all= []

  def initialize(name)
    @name= name
    @songs= []
  end

  def genres
    self.songs.collect { |song| song.genre }.uniq
  end

  def songs
    @songs
  end

  def add_song(song)
    self.songs<< song unless self.songs.include?(song)

    song.artist= self if song.artist.nil?
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

end
