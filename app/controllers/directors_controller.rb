class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def modify
    id_path = params.fetch("path_id")
    record = Director.where({ :id => id_path }).first
    record.name = params.fetch("query_name")
    record.dob = params.fetch("query_dob")
    record.bio = params.fetch("query_bio")
    record.image = params.fetch("query_image")
    record.save

    redirect_to("/directors/#{id_path}")
  end

  def delete
    @id_path = params.fetch("delete_me")
    @record_delete = Director.where({:id => @id_path}).first
    # record_delete.destroy
    
    render(:template => "actor_templates/what")
    # redirect_to("/actors")
  end

  def create
    record = Director.new
    record.name = params.fetch("query_name")
    record.dob = params.fetch("query_dob")
    record.bio = params.fetch("query_bio")
    record.image = params.fetch("query_image")
    record.save

    redirect_to("/directors")
  end
end
