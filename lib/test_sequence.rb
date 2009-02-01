

sequence = Sequence.create  

(1..4).each do |id|
  as = AsanasSequences.create(:id => id)
  a = Asana.create(:english => "lotus#{id}")  
  as.asana = a
  sequence.postures << as    
end

# %w{ One Two Three Four}.each do |name|
#   as = sequence.asanas_sequences.create
#   as.asana.create(:name => name)
# end        
sequence.save    #=> 



def display_asanas(sequence)
  puts sequence.postures(true).map {|posture| posture.asana.english }.join(", ")
end



display_asanas(sequence)         #=> 


puts sequence.postures[0].first?   #=> true      

two = sequence.postures[1]    


puts two.lower_item.asana.english         #=> Three
puts two.higher_item.asana.english          #=> One

sequence.asanas[0].move_lower
display_asanas(sequence)         #=> Two, One, Three, Four

sequence.asanas[2].move_to_top
display_asanas(sequence)         #=> Three, Two, One, Four

sequence.asanas[2].destroy
display_asanas(sequence)         #=> Three, Two, Four
# ~> -:3: uninitialized constant Sequence (NameError)
