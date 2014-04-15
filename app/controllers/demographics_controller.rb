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
    @user = User.find(params[:id])
    @user_name = @user.demographic.name
    @user_nick_name = @user.demographic.nickname
    if @user.demographic.male?
      @user_gender = "Male"
    else
      @user_gender = "Female"
    end
    @user_age = @user.age rescue nil
    @user_religion = @user.demographic.religion
    @user_smoking = @user.demographic.smoking
    @user_drinking = @user.demographic.drinking
    @user_desc = @user.demographic.description
    @user_email = @user.email
  end

  def edit_profile
    #render :text => "#{current_user.id}, #{current_user.email}, #{params[:id]}"
    #return
    if params[:id].to_s != (current_user.id).to_s
      render :text => "You can't edit others profile"
      return
    else
      @user = current_user
      @user.build_demographic
      @user.criterions.new
      @user.attendances.new
      @user.professions.new
      @user.revelations.new
      @user.expectations.new

      @user_name = current_user.demographic.name
      @user_demographics = @user.demographic
    end
  end

  def update_profile
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
    client = Goodreads::Client.new(:api_key => 'WsRZQw8XBqoIQpHQuG0wMQ', :api_secret => '49eUFUgkFHYyskIKTMTCsbn6XkA0ssr4U9Wp61pC0b8')
    search = client.search_books(@book_search_text)
    @books_hash = Hash.new
    #render :json => search.results
    #return
    search.results.work.each_with_index do |book,index|
      @books_hash[index] = {"title"=>book.best_book.title, "id" => book.id, "author"=>book.best_book.author.name, "image"=>book.best_book.small_image_url}
    end
    render :json =>@books_hash
    return

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
      params[:demographic]
      #params.permit(:name, :male, :religion)
    end

end
