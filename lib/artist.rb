class Artist
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(artist_name)
    @name = artist_name
    @songs = []
  end
  
  def save
    self.class.all << self
  end
  
  def add_song(song)
    self.songs << song unless self.songs.include?(song)
    song.artist = self if song.artist == nil
  end
  
  def genres
    self.songs.collect{ |song| song.genre }.uniq
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(artist_name)
    Artist.new(artist_name).tap{ |artist| artist.save }
  end
end