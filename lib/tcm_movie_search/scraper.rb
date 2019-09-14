require 'nokogiri'
require 'open-uri'
require 'httparty'
class Scraper
  attr_accessor :parse_page

  # doc = "http://www.tcm.com/schedule/monthly.html?ecid=subnavmonthschedule"

  # @parse_page ||= Nokogiri::HTML(doc) # ||= if @parse_page doesn't equal Nokogiri::HTML(doc), it will.

  # movie_title = doc.css("h2 a")
  # description = doc.css("p.description")
  # link = doc.css('h2 a').map { |link| link['href'] }
  # genre = "#{link.first}genre.html"

  # movie_genre = Nokogiri::HTML(open(genre))
  # genre_even = movie_genre.css("tr.tdrwodd")
  # genre_odd = movie_genre.css("tr.tdreven")
  # title = movie_genre.css("span.db-movietitle")
  # year = movie_genre.css("span.dbyear")
  # will remove the parentheses from the year to aid in search
  # clean_year = year.gsub(/[()]/, "")

  def initialize
    doc = HTTParty.get("http://www.tcm.com/schedule/monthly.html?ecid=subnavmonthschedule")
    @parse_page ||= Nokogiri::HTML(doc)
    # ||= if @parse_page doesn't equal Nokogiri::HTML(doc), it will.
  end

  def get_movie_titles
    movie_titles = parse_page.css("h2 a") { |title| title.text }
  end

  def get_movie_description
    movie_description = parse_page.css("p.description") { |description| description.text }
  end

  scraper = Scraper.new
  titles = scraper.get_movie_titles
  descriptions = scraper.get_movie_description

  (0...titles.size).each do |index| # three dots don't include last digit. 0 to titles - 1
    puts "- - - index: #{index + 1} - - -"
    puts "title: #{titles[index].text.gsub(/\([^()]*\)/, '')}\nbrief synposis:#{descriptions[index].text}\n"
  end

end
