class TcmMovieSearch::Movies

  attr_accessor :date, :time, :title, :description, :cast, :runtime, :link, :year, :genre
  @@all = []

  def initialize(date, time, title, year, description, cast, runtime, link, genre)
    @date = date
    @time = time
    @title = title
    @description = description
    @cast = cast
    @runtime = runtime
    @link = link
    @year = year
    @genre = genre
    save
  end

  def save
    @@all << self
  end

  def self.all
    TcmMovieSearch::Scraper.scraper if @@all.empty?
    @@all.inspect.blue
  end

end
