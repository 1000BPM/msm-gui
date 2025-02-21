class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    @the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => @the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def modify
    id_path = params.fetch("path_id")
    record = Actor.where({ :id => id_path }).first
    record.name = params.fetch("query_name")
    record.dob = params.fetch("query_dob")
    record.bio = params.fetch("query_bio")
    record.image = params.fetch("query_image")
    record.save

    redirect_to("/actors/#{id_path}")
  end

  def delete
    @id_path = params.fetch("path_id")
    @record_delete = Actor.where({:id => @id_path}).first
    @record_delete.destroy
    
    # render(:template => "actor_templates/what")
    redirect_to("/actors")
  end

  def create
    record = Actor.new
    record.name = params.fetch("query_name")
    record.dob = params.fetch("query_dob")
    record.bio = params.fetch("query_bio")
    record.image = params.fetch("query_image")
    record.save

    redirect_to("/actors")
  end
end
