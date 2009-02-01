class AsanasSequencesController < ApplicationController  
  # DELETE /asana_sequence/1
  # DELETE /asana_sequence/1.xml
  def destroy
    @asana_sequence = AsanasSequences.find(params[:id])
    @sequence = @asana_sequence.sequence
    @asana_sequence.destroy
    
    respond_to do |format|
      format.html { redirect_to(:controller => :sequences, :action=> :edit, :id => @sequence.id) }
      format.xml  { head :ok }
    end
  end
end