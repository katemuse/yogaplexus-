class SequencesController < ApplicationController       
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :sort ]
 
  # GET /sequences
  # GET /sequences.xml
  def index
    @sequences = Sequence.find(:all, :include => [:postures, :user])
       
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sequences }
    end
  end

  # GET /sequences/1
  # GET /sequences/1.xml
  def show
    @sequence = Sequence.find(params[:id], :include => [:postures, :user]) 
    @author = @sequence.user #User.find(@sequence.user.id) 
    @poses = @sequence.postures
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sequence }
    end
  end

  # GET /sequences/new
  # GET /sequences/new.xml
  def new
    @sequence = Sequence.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sequence }
    end
  end

  # GET /sequences/1/edit
  def edit
    @sequence = Sequence.find(params[:id], :include =>:postures)  
    @poses = @sequence.postures
    #@asana_group = Asana.find(:all)	#uncomment this to show all the asanas 
				    					#in the _filtered_asanas partial 
				    					#when the Show template first appears
  end

  # POST /sequences
  # POST /sequences.xml
  def create
    @sequence = Sequence.new(params[:sequence])
    @sequence.user_id=current_user.id   
    @asana_group = nil   
    
    respond_to do |format|
      if @sequence.save
        flash.now[:notice] = 'Sequence was successfully created.'
        format.html { redirect_to :action=>:edit, :id=>@sequence.id}
        format.xml  { render :xml => @sequence, :status => :created, :location => @sequence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sequences/1
  # PUT /sequences/1.xml
  def update
    @sequence = Sequence.find(params[:id])
    respond_to do |format|
      if @sequence.update_attributes(params[:sequence])
        flash.now[:notice] = 'Sequence was successfully updated.'
        format.html { redirect_to(:action=>:show, :id=>@sequence.id) }  #
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" } 
        format.xml  { render :xml => @sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sequences/1
  # DELETE /sequences/1.xml
  def destroy
    @sequence = Sequence.find(params[:id])
    @sequence.destroy
    respond_to do |format|
      format.html { redirect_to(:action => :home, :controller => :users) }
      format.xml  { head :ok }
    end
  end  
  
   def accept_asana_categories_and_return_asanas  #this a concatenation of ajax and no-ajax versions 
   												 # of two nearly identical ajax and non-ajax actions.
   												 # It covers both ajax and non-ajax requests using
   												 # request.xhr?.   No one should have to do without													# request.xhr? and it bewilders me that AWDR even
   												 # suggests writing two different controller actions
   												 # for ajax and non-ajax versions. 
   												 #
  												# This method narrows the large list of asanas by
  												# asana_type (spinal position) and/or asana_subtype;
  												# although the ajax implementation doesn't take
  												# advantage of the fact that the method provides 
  												# the means to find the intersection of instances 
  												# of both parent classes. The original non-ajax version
  												# used it, but that went the way of the dinosaurs. 
    @sequence =  Sequence.find(params[:sequence_id])  
    @poses = @sequence.postures
    
    if !params[:asana_type_id].blank?
      type_id = (params[:asana_type_id])
    else
      type_id = nil
    end
    if !params[:asana_subtype_id].blank?  
      subtype_id = (params[:asana_subtype_id])
    else
      subtype_id = nil
    end 
  	 if !type_id && !subtype_id
      @asana_group =  Asana.find(:all)
    elsif type_id && !subtype_id
      @asana_group =  Asana.find(:all, :conditions => {:asana_type_id => type_id})
    elsif !type_id && subtype_id 
      @asana_group =  Asana.find(:all, :conditions => {:asana_subtype_id => subtype_id})  
    elsif type_id  && subtype_id      
      @asana_group =  Asana.find(:all, :conditions => {:asana_type_id => type_id, :asana_subtype_id => subtype_id})  #ajax configuration  doesn't take advantage of this.
    end
    if request.xhr? 
      render :partial => 'filtered_asanas' 
    else
      respond_to do |format|
         format.html { render( :action => :edit, :locals => {:asana_group => @asana_group, :id => @sequence.id} )}  #I have some questions about this, but so far it works.
         format.xml  { head :ok }
       end
     end
  end 

	def add_to_sequence   # This is also a concatenation of ajax and no-ajax versions of the same
						  # action, or behavior.
						  # The nested if's are a pain for all concerned.  It works, though.  
                          # It's called from each link of a list of asanas, narrowed down by
                          # category, in the "asanatrix".  When clicked, it seems that the chosen asana
                          # is added to the sequence.  Actually, what really happens is a new
                          # AsanasSequences instance is created, which is a sequence's pose that
                          # also belongs to an asana, and has access to all the asana's information
                          # through it's .asana method. This is by default added to the end, although
                          # in future we would like to be able to drag it in to the middle of the 
                          # sequence.  The sequence already uses drag and drop and acts as list for
                          # reordering.  
                          
    @sequence =  Sequence.find(params[:sequence_id])  
    @poses = @sequence.postures  
    @pose = AsanasSequences.new
    @pose.asana_id = params[:asana_id]
    @pose.sequence_id = @sequence.id 
    @asana = @pose.asana 
    if @sequence.user.id = current_user.id
      if @pose.save!
        flash.now[:notice] = 'Pose was successfully added to Sequence.'    
        if request.xhr? 
           render :partial => 'sequence_list'
        else 
           respond_to do |format|
              if @pose.id
                flash.now[:notice] = 'Pose was successfully added to Sequence.'
                format.html { redirect_to :action=> :show, :id=>@sequence }
                format.xml  { head :ok }
              end                
            end
          end
      else
         flash[:notice] = "Oops.  Pose didn't make it to Sequence"  
         respond_to do |format|                                      
            format.html { redirect_to (:action => :edit,  :id => @sequence.id) }
            #used to have { render (:action => :edit, :locals => {:asana_group => 
            # @asana_group, :sequence =>  @sequence} )} It worked, but I guess it was wrong, because
            # if the edit page had rendered as it was supposed to, and then it was refreshed,
            # it probably added the pose to the sequence a second time.  
            
            						
                                         
                                        # The only really sucky thing about the way this 
            							# degrades is that without 
                          				# javascript it sends the user 
                          				# to the "show" view.  
                          				# Not sure why, since	
                          				# the redirect action says edit.  
                          				# "render" doesn't work either.
                          				# Strangely, pressing "delete" sends you back to edit, because
                          				# asanas_sequences_controller destroy redirection works.
            format.xml  { head :ok } 
            end                             
       end                          
    end    
  end 
       
                                                                     
 
  #  The following was an attempt to toggle show/hide link on each pose of the sequence list.  
  #  I added a boolean 'revealed' attribute to the AsanasSequences table.  
  #  I couldn't get it to work so I gave up.   
 
  # def show_or_hide_details  
  #   @asana = Asana.find(params[:asana_id])
  #   @pose = AsanasSequences.find(params[:pose_id])    
  #   if @pose.revealed
  #     @pose.revealed = true
  #     @pose.save
  #     render :partial => 'asana_details'      
  #   else
  #      @pose.revealed = false   
  #      @pose.save
  #     render :none => true  
  #   end
  # end
  #      
  def reveal_details
     @asana = Asana.find(params[:asana_id])
     @pose = AsanasSequences.find(params[:pose_id]) 
            
     # if request.xhr?   
       render :partial => "asana_details"     
     # else 
     #      respond_to do |format|    #this isn't working, probably because of the @no_ajax=true bit.
     								# It threw a nil object error that made no sense to me.
     #        format.html { redirect_to(:action => :edit, @no_ajax => true )} 
     #        format.xml  { head :ok }
     #      end    
     #  end    
  end

  # def hide_details #NOT SUCCESSFUL.   no ajax, since toggle_slide handles both show and hide 
  #    @pose = AsanasSequences.find(params[:pose_id]) 
  #    respond_to do |format|
  #      format.html { redirect_to( :action => :edit, :locals => {:pose => @pose, :reveal => false} )} 
  #      format.xml  { head :ok }
  #    end
  #   end       
                                      
             
   def sort                                     #from Rails Recipes, Chad Fowler, (c)2006
     @sequence = Sequence.find(params[:id], :include => :postures)
     @sequence.postures.each do |pose|
       pose.position = params['sequence-list'].index(pose.id.to_s)+1  
       pose.save
     end
    render :none => true 
   end
    
                                            
end
