require 'pry'

class MusicImporter
  
  attr_reader :path
  
  def initialize(filepath)
    @path = filepath  
  end
  
  def files
    Dir.entries(self.path).select do |filename|
      filename.match(/.+-.+-.+\.mp3/)
    end
  end
  
  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
end

