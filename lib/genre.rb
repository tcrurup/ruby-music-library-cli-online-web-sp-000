class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(genre_name)
    @name = genre_name
    @songs = []
  end
  
  def save
    self.class.all << self
  end
  
  def add_song(song)
    self.songs << song unless self.songs.include?(song)  
  end
  
  def artists
    self.songs.collect{ |song| song.artist }.uniq  
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(genre_name)
    Genre.new(genre_name).tap{ |genre| genre.save }
  end
end