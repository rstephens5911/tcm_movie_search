class TcmMovieSearch::Scraper

  @site = "http://www.tcm.com/schedule/monthly.html?ecid=subnavmonthschedule"

  doc = Nokogiri::HTML(open(@site))

  movie_title = doc.css("h2 a")
  description = doc.css("p.description")
  link = doc.css('h2 a').map { |link| link['href'] }
  genre = "#{link.first}genre.html"

  movie_genre = Nokogiri::HTML(open(genre))
  genre_even = movie_genre.css("tr.tdrwodd")
  genre_odd = movie_genre.css("tr.tdreven")
  title = movie_genre.css("span.db-movietitle")
  year = movie_genre.css("span.dbyear")
  # will remove the parentheses from the year to aid in search
  # clean_year = year.gsub(/[()]/, "")

  def self.scraper
    doc = Nokogiri::HTML(open(@site))

    movies = doc.css("h2 a") # .text.gsub(/\([^()]*\)/, '')
    description = doc.css("p.description").text
    link = doc.css('h2 a').map { |link| link['href'] }

    genre = "#{link.first}genre.html"
    movie_genre = Nokogiri::HTML(open(genre))
    genre_even = movie_genre.css("tr.tdrwodd").text
    genre_odd = movie_genre.css("tr.tdreven").text
    title = movie_genre.css("span.db-movietitle").text
    year = movie_genre.css("span.dbyear").text

    # puts movies
    # puts description
    # puts link
    # puts genre_even
    # puts genre_odd
    # puts year.gsub(/[()]/, "")
    movie_genre.each do |movie|
      title =  movie_genre.css("span.db-movietitle").text
      # year = movie_genre.css("span.dbyear").text
      Movie.new(title)
    end
  end

end
