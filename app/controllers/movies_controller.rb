class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def modify
    id_path = params.fetch("path_id")
    record = Movie.where({ :id => id_path })
    record = record.first
    record.title = params.fetch("query_name")
    record.year = params.fetch("query_yr")
    record.duration = params.fetch("query_duration")
    record.description = params.fetch("query_desc")
    record.image = params.fetch("query_image")
    record.director_id = params.fetch("query_director_id")
    record.save

    redirect_to("/movies/#{id_path}")
  end

  def delete
    @id_path = params.fetch("path_id")
    @record_delete = Movie.where({:id => @id_path}).first
    @record_delete.destroy
    
    # render(:template => "actor_templates/what")
    redirect_to("/movies")
  end

  def create
    record = Movie.new

    record.title = params.fetch("query_name")
    record.year = params.fetch("query_yr").to_i
    record.duration = params.fetch("query_duration").to_i
    record.description = params.fetch("query_desc")
    record.image = params.fetch("query_image")
    record.director_id = params.fetch("query_director_id")
    record.save

    redirect_to("/movies")
  end
end
