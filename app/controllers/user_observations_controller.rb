class UserObservationsController < ApplicationController
  # GET /user_observations
  # GET /user_observations.xml 
    before_filter :login_required, :only => [ :new, :create, :edit, :update ]    
  def index
    @user_observations = UserObservation.find(:all, :include => [:asana, :user])
    @asanas = Asana.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_observations }
    end
  end

  # GET /user_observations/1
  # GET /user_observations/1.xml
  def show
    @user_observation = UserObservation.find(params[:id], :include => :asana)       # , :include => :pictures   
    @asana = Asana.find(@user_observation.asana_id)
    # @pictures = @user_observation.pictures     
    respond_to do |format|
      format.html { redirect_to @asana, :id => @asana.id }# show.html.erb
      format.xml  { render :xml => @user_observation }
    end
  end

  # GET /user_observations/new
  # GET /user_observations/new.xml
  def new
    @user_observation = UserObservation.new
    #
    @asana = Asana.find(params[:user_observation][:asana_id]) 
    @asanas = Asana.find(:all)
    #
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_observation }
    end
  end

  # GET /user_observations/1/edit
  def edit
    @user_observation = UserObservation.find(params[:id])  
    @asana = @user_observation.asana
    @asanas = Asana.find(:all)
  end

  # POST /user_observations
  # POST /user_observations.xml
  def create 
    @user_observation = UserObservation.new(params[:user_observation])
    @asana = Asana.find(params[:user_observation][:asana_id]) 
    @asanas = Asana.find(:all)
    respond_to do |format|
      if @user_observation.save!
        flash[:notice] = "UserObservation was successfully created." 
        format.html { redirect_to(@user_observation) }     #show
        format.xml  { render :xml => @user_observation, :status => :created, :location => @user_observation }
      else
       flash[:notice] = 'UserObservation was not created.'   
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_observation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_observations/1
  # PUT /user_observations/1.xml
  def update
    @user_observation = UserObservation.find(params[:id])

    respond_to do |format|
      if @user_observation.update_attributes(params[:user_observation])
        flash[:notice] = 'UserObservation was successfully updated.'
        format.html { redirect_to(@user_observation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_observation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_observations/1
  # DELETE /user_observations/1.xml
  def destroy
    @user_observation = UserObservation.find(params[:id])
    @user_observation.destroy

    respond_to do |format|
      format.html { redirect_to(user_observations_url) }
      format.xml  { head :ok }
    end
  end
end
