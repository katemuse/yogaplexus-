class AsanaTypesController < ApplicationController
    before_filter :admin_login_required, :only => [ :new, :create, :edit, :update ]  
      
    # GET /asana_types
    # GET /asana_types.xml
    def index
      @asana_types = AsanaType.find(:all, :include => :asanas)  

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @asana_types }
      end
    end

    # GET /asana_types/1
    # GET /asana_types/1.xml
    def show
      @asana_type = AsanaType.find(params[:id], :include => :asanas)  

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @asana_type }
      end
    end

    # GET /asana_types/new
    # GET /asana_types/new.xml
    def new
      @asana_type = AsanaType.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @asana_type }
      end
    end

    # GET /asana_types/1/edit
    def edit
      @asana_type = AsanaType.find(params[:id], :include => :asanas)  
    end

    # POST /asana_types
    # POST /asana_types.xml
    def create
      @asana_type = AsanaType.new(params[:asana_type])

      respond_to do |format|
        if @asana_type.save
          flash.now[:notice] = 'Asana category was successfully created.'
          format.html { redirect_to(@asana_type) }
          format.xml  { render :xml => @asana_type, :status => :created, :location => @asana_type }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @asana_type.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /asana_types/1
    # PUT /asana_types/1.xml
    def update
      @asana_type = Asana.find(params[:id], :include => :asanas)  

      respond_to do |format|
        if @asana_type.update_attributes(params[:asana_type])
          flash.now[:notice] = 'Asana category was successfully updated.'
          format.html { redirect_to(@asana_type) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @asana_type.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /asana_types/1
    # DELETE /asana_types/1.xml
    def destroy
      @asana_type = AsanaType.find(params[:id])
      @asana_type.destroy

      respond_to do |format|
        format.html { redirect_to(asana_types_url) }
        format.xml  { head :ok }
      end
    end


end     