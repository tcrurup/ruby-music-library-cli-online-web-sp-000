class Song
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(song_name, song_artist = nil, song_genre = nil)
    @name = song_name
    self.artist = song_artist unless song_artist.nil?
    self.genre = song_genre unless song_genre.nil?
  end
  
  def save
    self.class.all << self
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def artist_name
    self.artist.name  
  end
  
  def genre_name
    self.genre.name
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(song_name)
    Song.new(song_name).tap{ |song| song.save }
  end
  
  def self.new_from_filename(filename)
    song_data = filename.split(".")[0].split(" - ").collect{ |a| a.strip }
    #song_data = [artist_name, song_name, genre_type]
    
    self.new(song_data[1]).tap do |song|
      song.artist = Artist.find_or_create_by_name(song_data[0])
      song.genre = Genre.find_or_create_by_name(song_data[2])
    end
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap{ |song| song.save }
  end
end