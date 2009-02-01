class AsanaSubtypesController < ApplicationController
    before_filter :admin_login_required, :only => [ :new, :create, :edit, :update ]   
    
    # GET /asana_subtypes
    # GET /asana_subtypes.xml
    def index
      @asana_subtypes = AsanaSubtype.find(:all, :include => :asanas)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @asana_subtypes }
      end
    end

    # GET /asana_subtypes/1
    # GET /asana_subtypes/1.xml
    def show
      @asana_subtype = AsanaSubtype.find(params[:id])  

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @asana_subtype }
      end
    end

    # GET /asana_subtypes/new
    # GET /asana_subtypes/new.xml
    def new
      @asana_subtype = AsanaSubtype.new
      
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @asana_subtype }
      end
    end

    # GET /asana_subtypes/1/edit
    def edit
      @asana_subtype = AsanaSubtype.find(params[:id], :include => :asanas)  
    end

    # POST /asana_subtypes
    # POST /asana_subtypes.xml
    def create
      @asana_subtype = AsanaSubtype.new(params[:asana_subtype])

      respond_to do |format|
        if @asana_subtype.save
          flash.now[:notice] = 'Asana starting position was successfully created.'
          format.html { redirect_to(@asana_subtype) }
          format.xml  { render :xml => @asana_subtype, :status => :created, :location => @asana_subtype }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @asana_subtype.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /asana_subtypes/1
    # PUT /asana_subtypes/1.xml
    def update
      @asana_subtype = AsanaSubtype.find(params[:id], :include => :asanas)  

      respond_to do |format|
        if @asana_subtype.update_attributes(params[:asana_subtype])
          flash.now[:notice] = 'Asana starting position was successfully updated.'
          format.html { redirect_to(@asana_subtype) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @asana_subtype.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /asana_subtypes/1
    # DELETE /asana_subtypes/1.xml
    def destroy
      @asana_subtype = AsanaSubtype.find(params[:id])
      @asana_subtype.destroy

      respond_to do |format|
        format.html { redirect_to(asana_subtypes_url) }
        format.xml  { head :ok }
      end
    end
  end

 
