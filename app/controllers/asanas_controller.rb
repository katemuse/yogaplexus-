class AsanasController < ApplicationController
  before_filter :admin_login_required, :only => [ :new, :create, :edit, :update ]   
  
  # GET /asanas
  # GET /asanas.xml
  def index               #include-ing preloads associated objects so 
  						  # they will be available to the view.
    @asanas = Asana.find(:all, :include => [:user_observations, :picture, :asana_type, :asana_subtype]) 
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asanas }
    end
  end

  # GET /asanas/1
  # GET /asanas/1.xml
  def show
    @asana = Asana.find(params[:id], :include => [:user_observations, :picture, :asana_type, :asana_subtype])    
    @picture = @asana.picture  
    @user_observations = @asana.user_observations   #          
    @user_observation = UserObservation.new
       
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asana }
    end
  end

  # GET /asanas/new
  # GET /asanas/new.xml
  def new
    @asana = Asana.new   
    
    @asana_types = AsanaType.find(:all)    # ready an option-select field 
    @asana_subtypes = AsanaSubtype.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asana }
    end
  end

  # GET /asanas/1/edit
  def edit
    @asana = Asana.find(params[:id], :include => [:user_observations])   
    @asana_types = AsanaType.find(:all)              # for complex forms - ready an option-select field 
    @asana_subtypes = AsanaSubtype.find(:all)
    @asana_type = @asana.asana_type          # list the asana type already selected
    @asana_subtype = @asana.asana_subtype 
      
  end

  # POST /asanas
  # POST /asanas.xml
  def create
    @asana = Asana.new(params[:asana]) 
     @asana_types = AsanaType.find(:all)    # ready an option-select field 
      @asana_subtypes = AsanaSubtype.find(:all)  
    @picture = Picture.new(:uploaded_data => params[:picture_file])  #Image uploading code and 		
    																                                # attachment_fu plugin comes from 
    @service = AsanaService.new(@asana, @picture)                    #Prag Prog chapter on 
    																                                # attachment_fu by
                                                                     #its creator, Rick Olsen
    
     @asana_type = AsanaType.find(@asana.asana_type_id)          # list the asana type already selected
     @asana_subtype = AsanaSubtype.find(@asana.asana_subtype_id)  
     @service.save   
    respond_to do |format|
      if @asana.save
        flash.now[:notice] = 'Asana was successfully created.'
        format.html { redirect_to(@asana) }
        format.xml  { render :xml => @asana, :status => :created, :location => @asana }
      else
        flash.now[:notice] = 'There was a problem.  Do you want to give it another shot?'
         format.html { render :action => "new" }
        format.xml  { render :xml => @asana.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asanas/1
  # PUT /asanas/1.xml
  def update
    @asana = Asana.find(params[:id], :include => [:user_observations, :asana_type, :asana_subtype])    
    @picture = @asana.picture
    @asana_types = AsanaType.find(:all)          # list the asana type already selected
    @asana_subtypes = AsanaSubtype.find(:all)
    @service = AsanaService.new(@asana, @picture) 
    
    respond_to do |format|
      if @service.update_attributes(params[:asana], params[:picture_file])
        flash.now[:notice] = 'Asana was successfully updated.'
        format.html { redirect_to(@asana) }
        format.xml  { head :ok }
      else   
        @picture = @service.picture
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asana.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /asanas/1
  # DELETE /asanas/1.xml
  def destroy
    @asana = Asana.find(params[:id])
    if @asana.destroy 
      flash.now[:notice] = "You successfully destroyed that asana."
    else
      flash.now[:notice] = "Sorry, it's still there.  Couldn't get rid of that asana."
    end
    respond_to do |format|
      format.html { redirect_to(asanas_url) }
      format.xml  { head :ok }
    end
  end    
  
  def reveal_details
    @asana = Asana.find(params[:asana])
    render :partial => "sequences/asana_details"  
  end 
  
  def hide_details 
    @asana = Asana.find(params[:asana]) 
    render :partial => "sequences/no_asana_details"  
  end          
  def add_reply      
     @asanas = Asana.find(:all)
     @asana = Asana.find(params[:asana_id])  
     @user = User.find(params[:user_id]) 
     @reply_to = UserObservation.find_by_id(params[:reply_to_id])
     @user_observations = UserObservation.find_all_by_user_id(@user.id)
     render :partial => "reply_form"
  end 
   def add_user_observation      
      @asanas = Asana.find(:all)
      @asana = Asana.find(params[:asana_id])  
      @user = User.find(params[:user_id])
      @user_observations = UserObservation.find_all_by_user_id(@user.id)
      render :partial => "user_observ_form"
   end
       
  
end
