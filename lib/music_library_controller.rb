class MusicLibraryController
  
  def initialize(filepath = './db/mp3s')
    MusicImporter.new(filepath).import
  end
  
  VALID_MENU_SELECTION = [
    'list songs', 
    'list artists', 
    'list genres', 
    'list artist', 
    'list genre',
    'play song',
    'exit']
  
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
    input = gets
    until VALID_MENU_SELECTION.include?(input)
      input = gets
    end
    
    case input
      when "list songs" then self.list_songs
      when "list artists" then self.list_artists
      when "list genres" then self.list_genres
      when "list artist" then self.list_songs_by_artist
      when "list genre" then self.list_songs_by_genre
      when "play song" then self.play_song
    end
        
    
  end
  
  def list_songs
    Song.all.sort{ |a, b| a.name <=> b.name }.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    Artist.all.sort{ |a, b| a.name <=> b.name }.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end
  
  def list_genres
    Genre.all.sort{ |a, b| a.name <=> b.name }.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets
    artist = Artist.find_by_name(artist_name)
    if not artist.nil?
      artist.songs.sort{ |a,b| a.name <=> b.name }.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre_name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets
    genre = Genre.find_by_name(genre_name)
    if not genre.nil?
      genre.songs.sort{ |a,b| a.name <=> b.name }.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist_name} - #{song.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.to_i
    if input >= 1 && input <= Song.all.length
      chosen_song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
      if not chosen_song.nil?
        puts "Playing #{chosen_song.name} by #{chosen_song.artist_name}"
      end
    end
  end
end
