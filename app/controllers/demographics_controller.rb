class DemographicsController < ApplicationController
  before_action :set_demographic, only: [:show, :edit, :update, :destroy]
  layout 'dashboard_and_profile_layout'



  # GET /demographics
  # GET /demographics.json
  def index
    @demographics = Demographic.all
  end

  # GET /demographics/1
  # GET /demographics/1.json
  def show
  end

  def profile
    if !User.where(:id=>params[:id]).first.nil?
      #@user = User.find(params[:id])
        @user = User.where(:id=>params[:id]).first
        @user_name = @user.demographic.name
        @user_nick_name = @user.demographic.nickname
        if @user.demographic.male?
          @user_gender = "Male"
        else
          @user_gender = "Female"
        end
        @user_age = @user.age rescue nil
        @user_religion = @user.demographic.religion rescue ""
        @user_smoking = @user.demographic.smoking rescue ""
        @user_drinking = @user.demographic.drinking rescue ""
        @user_desc = @user.demographic.description rescue ""
        @user_location = @user.demographic.location rescue ""
        @user_goal = @user.demographic.goal rescue ""
        @user_profession = @user.profession.name rescue ""
        @user_last_institute_id = @user.demographic.last_institute rescue nil?
        @user_last_institute_name = Institution.find(@user_last_institute_id).name rescue ""

        #render :text => @user_last_institute_name
        #return
        @user_email = @user.email

        @user_quizzes = Array.new
        @user_quiz_ans_questions = @user.quiz_answers.map(&:question_id)
        @user_quiz_ans_questions.each do |q|
          @user_quizzes << Question.find(q).quizzes.first.name
          #@user_quizzes << q.quizzes.map(&:name)
        end
        @user_quizzes = @user_quizzes.uniq
        #render :text => @user_quizzes
        #return

    else
      #redirect_to user_profile_path(current_user.id)
      respond_to do |format|
          format.html { redirect_to user_profile_path(current_user.id), notice: 'User not found.' }
      end
    end

  end

  def edit_profile
    #render :text => "#{current_user.id}, #{current_user.email}, #{params[:id]}"
    #render :json => current_user.movies
    #return
    if params[:id].to_s != (current_user.id).to_s
      render :text => "You can't edit others profile"
      return
    else
      @user = current_user
      #@user.build_demographic
      #@user.build_criterion
      #@user.attendances.new
      #@user.professions.new
      #@user.revelations.new
      #@user.expectations.new

      @user_name = current_user.demographic.name
      @user_demographics = @user.demographic
    end
  end


  def add_user_movie
    @user = current_user

    @movie_name = params[["movie_name"][0]][0]
    @movie_api_id = params[["movie_id"][0]][0].to_i
    @movie_poster = params[["movie_poster"][0]][0]
    @movie_release_date = params[["movie_release_date"][0]][0]

    #render :json => "#{@movie_name} #{@movie_id} #{@movie_poster} #{@movie_release_date}"

    if Movie.where(:movie_api_id => @movie_api_id).blank?
      @movie = Movie.create(:name=>@movie_name, :movie_api_id=>@movie_api_id, :poster=>@movie_poster, :release_date=>@movie_release_date)
      @movie.save!
      @user.movies << @movie
      render :text => "OK"
      return
    else
      if @user.movies.where(:movie_api_id=>@movie_api_id).present?
        render :text => "You have allready added this movie."
        return
      else
        @movie_found = Movie.where(:movie_api_id => @movie_api_id).first
        @user.movies << @movie_found
        render :text => "OK"
        return
      end
    end

  end

  def delete_user_movie
    @user = current_user
    @movie_api_id = params[["movie_api_id"][0]][0].to_i

    @user_movie = @user.movies.where(:movie_api_id=>@movie_api_id).first
    @user.movies.delete(@user_movie)
    render :text => "Movie deleted"
    return
    #@movie_api_id = params[["movie_name"][0]][0]
  end

  def add_user_book
    @user = current_user
    @book_name = params[["book_name"][0]][0]
    @book_id = params[["book_id"][0]][0]
    @book_poster = params[["book_poster"][0]][0]
    @book_author = params[["book_author"][0]][0]

    if Book.where(:book_api_id => @book_id).blank?
      @book = Book.create(:name=>@book_name, :book_api_id=>@book_id, :cover=>@book_poster, :author=>@book_author)
      @book.save!
      @user.books << @book
      render :text => "OK"
      return
    else
      if @user.books.where(:book_api_id=>@book_id).present?
        render :text => "You have allready added this book."
        return
      else
        @book_found = Book.where(:book_api_id => @book_id).first
        @user.books << @book_found
        render :text => "OK"
        return
      end
    end

  end

  def delete_user_book
    @user = current_user
    @book_api_id = params[["book_api_id"][0]][0].to_i

    @user_book = @user.books.where(:book_api_id=>@book_api_id).first
    @user.books.delete(@user_book)
    render :text => "Book deleted"
    return
    #@movie_api_id = params[["movie_name"][0]][0]
  end

  def add_user_music
    @user = current_user
    @music_name = params[["music_name"][0]][0]
    @music_id = params[["music_id"][0]][0]
    @music_poster = params[["music_poster"][0]][0]

    #@user.songs.create(:name=>@music_name, :song_api_id=>@music_id, :song_poster=>@music_poster)
    #
    #render :text => "#{@music_name} #{@music_id} #{@music_poster}"
    ##render :text => "User Music Created"
    #return

    if Song.where(:song_api_id => @music_id).blank?
      @song = Song.create(:name=>@music_name, :song_api_id=>@music_id, :song_poster=>@music_poster)
      @song.save!
      @user.songs << @song
      render :text => "OK"
      return
    else
      if @user.songs.where(:song_api_id=>@music_id).present?
        render :text => "You have allready added this song."
        return
      else
        @song_found = Song.where(:song_api_id => @music_id).first
        @user.songs << @song_found
        render :text => "OK"
        return
      end
    end

  end

  def delete_user_song
    @user = current_user
    @song_api_id = params[["song_api_id"][0]][0].to_i

    @user_song = @user.songs.where(:song_api_id=>@song_api_id).first
    @user.songs.delete(@user_song)
    render :text => "Song deleted"
    return
  end

  def update_profile
    #render :json => params[:user][:demographic_attributes]
    #return
    @user = current_user.demographic
    respond_to do |format|
      if @user.update(params[:user][:demographic_attributes])
        format.html { redirect_to "/profile/#{@user.id}", notice: 'Demographic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @demographic.errors, status: :unprocessable_entity }
      end
    end

  end


  def update_filled_details
    @user = current_user
    render :json => params
    return
  end


  def search_movies_ruby
    #TMDB API Key: a69e2d8b3e5942d8850c9d17e2dbc126

    #gem ruby-tmdb3 => https://github.com/Irio/ruby-tmdb - starts
    require 'rubygems'
    require 'ruby-tmdb3'

    # setup your API key
    Tmdb.api_key = "a69e2d8b3e5942d8850c9d17e2dbc126"

    # setup your default language
    Tmdb.default_language = "en"

    @movie = TmdbMovie.find(:title => "Iron Man", :limit => 1)
    #@movies = TmdbMovie.find(:title => "fight club", :limit => 10, :expand_results => false, :language => "en")

    #render :json => @movie
    #render :text => @movie.title # => movie title
    #render :text => @movie['posters'][0]["original"]
    #render :text => @movie.posters.table[0].sizes.table[0].w92.table.url # => movie poster
    @poster_arr = Array.new
    @movie.posters.map.each do |poster|
      @poster_arr << poster.sizes.w92.url
    end
    render :text => "title :- #{@movie.title}, poster :- #{@poster_arr[0]}, release_date :- #{@movie.release_date}"
    return
    #gem ruby-tmdb3 - starts
  end

  def search_movies_themoviedb
    #https://github.com/ahmetabdi/themoviedb

    #@movie_search_text = "Agneepath"
    @movie_search_text = params['movie_search_text'][0]
    #@movie_search_text = params[:movie_search_text]
    #render :text => @movie_search_text
    #return
    Tmdb::Api.key("dc6068cf02d1dec8333334af43b20856")
    Tmdb::Api.language("en")

    @movies_arr = Array.new

    @movies_hash = Hash.new

    @search = Tmdb::Search.new
    @search.resource('movie') # determines type of resource, resources => person, movie, tv, collection, company
    @search.query(@movie_search_text) # the query to search against
    @result = @search.fetch # makes request
    #render :json => @result
    @result.each_with_index do |result, index|
      #@movies_arr << "#{result["title"]}|||http://image.tmdb.org/t/p/w92#{result["poster_path"]}|||#{result["release_date"]}|||#{result["id"]}"
      @movies_hash[index] = { "title"=>result["title"], "poster"=>"http://image.tmdb.org/t/p/w92#{result["poster_path"]}", "release_date"=>result["release_date"], "movie_id"=>result["id"] }
    end
    #render :json => @movies_arr
    render :json => @movies_hash

    #@movie = Tmdb::Movie.images(1726)
    #@movie = Tmdb::Movie.find(@movie_search_text)
    #render :json => @movie
    #render :json => @movie['posters']
    #render :json => @movie.map{|m| m["title"]}

    return
  end



  def search_music_db
    require 'net/http'
    @music_search_text = URI::escape(params[:music_search_text][0])
    result = Net::HTTP.get(URI.parse('http://api.rovicorp.com/search/v2.1/music/autocomplete?entitytype=song&query='+ @music_search_text +'&country=US&language=en&size=20&format=json&apikey=7bwskaxgu2twtrzwwmjy9cra&sig=a87700b9ce773e53ffcec170f2dbb9d0'))
    @music_hash = Hash.new
    render :json => result
    return
  end


  def search_movies_by_rovicorp
    #http://api.rovicorp.com/search/v2.1/video/autocomplete?entitytype=movie&query=Mur&country=US&language=en&size=20&format=json&apikey=7bwskaxgu2twtrzwwmjy9cra&sig=4766c991aa5ce8b1789b851397d16f98
    require 'net/http'
    @movie_search_text = URI::escape(params[:movie_search_text][0])
    result = Net::HTTP.get(URI.parse('http://api.rovicorp.com/search/v2.1/video/autocomplete?entitytype=movie&query='+@movie_search_text+'&country=US&language=en&size=20&format=json&apikey=7bwskaxgu2twtrzwwmjy9cra&sig=8808394ab8c44b81fa40dbeaa8c9f044'))
    render :json => result
    return
  end

  def search_movies_by_rotten_tomatoes
    @movie_search_text = URI::escape(params[:movie_search_text][0])
    result = Net::HTTP.get(URI.parse('http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=kdne34pjmqtcs6qukt8zmqmp&q='+@movie_search_text+''))
    render :json => result
    return
  end

  def search_music_by_lastfm
    @music_search_text = URI::escape(params[:music_search_text][0])
    result = Net::HTTP.get(URI.parse('http://ws.audioscrobbler.com/2.0/?method=track.search&track='+@music_search_text+'&api_key=6078900945f603ee0a48da7cb32ab1dc&format=json'))
    render :json => result
    return
  end




  def search_music_gmusic
    require 'gmusic'

    result = GMusic.search(:title => 'heal the world', :artist => 'michael jackson')

    result.first.keys
    render :text => result.class
    return
  end


  def search_book_db
    #@book_search_text = "The Wings of Fire"
    @book_search_text = params['book_search_text'][0]

    #Nilesh - keys - starts
    #client = Goodreads::Client.new(:api_key => 'WsRZQw8XBqoIQpHQuG0wMQ', :api_secret => '49eUFUgkFHYyskIKTMTCsbn6XkA0ssr4U9Wp61pC0b8')
    #Nilesh - keys - ends

    #LHC - keys - starts
    client = Goodreads::Client.new(:api_key => '7KevzEgkysKmnWgBJEdBQ', :api_secret => 'aQ5WjXkeQdPVdZ7cMDOyA36A1z3C1GVuqWzmUnzOs')
    #LHC - keys - ends

    search = client.search_books(@book_search_text)
    @books_hash = Hash.new
    #render :json => search.results.blank?
    #return

    if !search.results.blank?
      search.results.work.each_with_index do |book,index|
        @books_hash[index] = {"title"=>book.best_book.title, "id" => book.id, "author"=>book.best_book.author.name, "image"=>book.best_book.small_image_url}
      end
      render :json => @books_hash
      return
    else
      render :json => "No Book found."
      return
    end

  end


  # GET /demographics/new
  def new
    @demographic = Demographic.new
  end

  # GET /demographics/1/edit
  def edit
  end

  # POST /demographics
  # POST /demographics.json
  def create
    @demographic = Demographic.new(demographic_params)

    respond_to do |format|
      if @demographic.save
        format.html { redirect_to @demographic, notice: 'Demographic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @demographic }
      else
        format.html { render action: 'new' }
        format.json { render json: @demographic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demographics/1
  # PATCH/PUT /demographics/1.json
  def update
    respond_to do |format|
      if @demographic.update(demographic_params)
        format.html { redirect_to @demographic, notice: 'Demographic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @demographic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demographics/1
  # DELETE /demographics/1.json
  def destroy
    @demographic.destroy
    respond_to do |format|
      format.html { redirect_to demographics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demographic
      @demographic = Demographic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def demographic_params
    def demographic_params
      #params[:demographic]
      params.require(:demographic).permit(:name, :male, :religion,:nickname, :smoking, :drinking,:country, :city,:dob,:id,:current_student)
    end

end
