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
    @user = current_user
    @user_name = current_user.demographic.name
    if current_user.demographic.male?
      @user_gender = "Male"
    else
      @user_gender = "Female"
    end
    @user_nick_name = current_user.demographic.nickname
    @user_religion = current_user.demographic.religion
    @user_smoking = current_user.demographic.smoking
    @user_drinking = current_user.demographic.smoking
    @user_desc = current_user.demographic.description
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
    @movie_search_text = params[:movie_search_text][0]
    #render :text => @movie_search_text

    Tmdb::Api.key("a69e2d8b3e5942d8850c9d17e2dbc126")
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

  def search_music_gmusic
    require 'gmusic'

    #result = GMusic.search(:title => 'Pink Floyd', :artist => 'michael jackson')
    #
    #puts result.class
    ## => Array
    #
    #result.first.keys
    ## => [:artist, :album, :format, :size, :url, :id, :lyrics, :title]
    #
    #render :text => result.first.keys

    require 'open-uri'
    doc = open("http://www.ptotem.com/") { |f| Hpricot(f) }
    render :text => doc
    return
  end

  def edit_profile
    @user = current_user
    #@user = User.find(current_user.id)
    @user.build_demographic
    @user.criterions.new
    @user.attendances.new
    @user.professions.new
    @user.revelations.new
    @user.expectations.new

    @user_name = current_user.demographic.name
    @user_demographics = @user.demographic
  end

  def update_profile
    render :json => params
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
