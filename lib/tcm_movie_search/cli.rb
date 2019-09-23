# TcmMovieSearch::CLI class will directly interact with the user
class TcmMovieSearch::CLI

  # tcm_movie_search starts here
  def call
    puts "\nTCM movie schedule and search"
    puts ""
    menu_options
    list_options
    get_user_option
  end

  def get_movies
    TcmMovieSearch::Movies.all
    TcmMovieSearch::Movies.schedule
    call
  end

  def menu_options
    @menu = ["search", "schedule", "scraper test", "return to menu", "exit application",]
  end

  def list_options
    puts "\nChoose an option:".blue
    @menu.each.with_index(1) do |option, index|
      puts "#{index}. #{option}".blue
    end
  end

  def get_user_option
    # replace with case statement
    chosen_option = gets.strip.to_i
     case chosen_option
     when 1
       search
     when 2
       puts "gathering the movie schedule."
       puts "this can take a few minutes."
       puts "please wait."
       get_movies
     when 3
       get_scraped_movie
     when 4
       call
     when 5
       exit
     else
       puts "not a valid choice, please select again".blue
       puts "choice:".blue
       get_user_option
     end
  end

   def search
     puts "search:".blue
     search = gets.strip.downcase
     if search == "exit"
       call
     elsif search == "end"
       return
     elsif search == "" # can't search for whitespaces
     puts "invalid search entry"
     search
     else
      search_results(search)
     end
     call
   end

   def search_results(search)
     title = "The Picture of Dorian Gray"
     synopsis = "Brief Synopsis:
     A man remains young and handsome while his
     portrait shows the ravages of age and sin.
     (1945)"
     if (synopsis.downcase.include?(search) || title.downcase.include?(search))
       puts title
       puts synopsis
     else
       puts "no results found."
     end
   end

   def get_scraped_movie # test
     scrape_box = []
     scrape_box << TcmMovieSearch::Scraper.scrape.text.gsub(/\([^()]*\)/, '') # removes the date
     puts scrape_box
     call
   end


 end
