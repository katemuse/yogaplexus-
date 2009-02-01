class Asana < ActiveRecord::Base     
  belongs_to :asana_subtype
  belongs_to :asana_type  
  has_many :asanas_sequences
  has_many :sequences, :through => :asanas_sequences
  has_many :user_observations
  has_one :picture, :dependent => :destroy
  has_many :variations, :class_name => 'Asana', :foreign_key => :root_asana_id 
  belongs_to :root_asana, :class_name => 'Asana', :foreign_key => :root_asana_id  
  
  
  
  validates_presence_of :english, :sanskrit 
  
  
  def asana_attributes=(asana_attributes) 
    asana_attributes.each do  |attribute|
      asana.build attribute #<!-- see railscast episode 073, podcast version (qt broken)  --> 
    end
  end  

##SCRAPING CODE!
#this almost works but would have taken too long to perfect.  It scrapes yogabasics for its yoga data using open-uri and processes it as well as it can using Nokogiri, a variant of Hpricot.  I couldn't get the proper xpath expressions to scrape  basic instructions nor figure out a clean way to associate asana categories and id's.  It took too much time but I was psyched to learn about scraping html.  I also hadn't encounter IO objects or used MatchData objects much, which were very confusing but interesting - I finally did get them to work! 
#ultimately I would move this method to a migration and run it from there.

  def self.feed    
    postures = []          # this holds unsaved postures for transmission to yml
    index_IO = open('http://www.yogabasics.com/asana/postures/')  #=> #make StringIO object
    stringy = index_IO.read   #read StringIO object to string
    filenames = Array.new 
    blob = stringy.match(/([a-z1-9]+[A-Z]?[a-z1-9])+\.html/)  #blob is the first matchData object from the string - it contains all the matches for the first matching index found, some inadvertently returned because of the grouping in the regular expression:  e.g., "5pointedStar" is returned along with "5pointedStar.html".  Therefore I use blob[0] (below) to get the desired file name.
    while blob  
      filenames << blob[0] #only filename string with .html ending is added to filenames array
      stringy = blob.post_match  #remaining scraped html populates stringy variable
      blob = stringy.match(/([a-z1-9]+[A-Z]?[a-z1-9])+\.html/) #blob is the first matchData object from the now shorter stringy  
    end   #if there are no more *.html matches in stringy, end the loop 
    path = "http://www.yogabasics.com/asana/postures/"
    filenames = filenames.collect {|name| path + name} 
    filenames.uniq!
    
    filenames.each do |filename| 
       doc = open_doc(filename) 
       filenames.delete(filename) 
       postures << parse_doc(doc)     
     end
      return postures     #this would permit the feed method to be run from a migration directly
      					# into a YAML file, but I didn't figure this step out.  Tried posture.to_yml
      					# but the yaml engine complained that the syntax in postures was wrong. 
      					#  Actually, come to think of it this worked the 2nd time around, but
      					# had so little good data I had to edit it by hand, which I did and everything
      					# worked out fine.
    end
     
private    
    def self.open_doc(filename) # used in last clause of self.feed, above
      begin
        doc = Nokogiri::HTML(open(filename))
        puts "deleting filename #{filename}"
          
      rescue OpenURI::HTTPError
        puts "attempt to access nonexistent webpage: #{$!}"
       end   
       return doc
    end 
    
    def self.parse_doc(doc) # used in last clause of self.feed
      if doc
        pose = doc
        english     = pose.search("/html/head/title").text.split(' / ')[0]  #this works
        sanskrit    = pose.search("/html/head/title").text.split(' / ')[1]  #as does this.          
        basic_instruction = pose.search("/html/body/table/tbody/tr/td/table[3]/tbody//td[img/@width='18']").text  #this doesn't work  
        posture = Asana.create(:english => english, :sanskrit => sanskrit,  :basic_instruction => basic_instruction) 
                  #Once Asana is expanded add the following
                  #difficulty = pose.search(..  
                  #benefits = pose.search('div[h3 = "Benefits + Contraindications"]/p[strong = "Benefits:"]').text
                  #contraindications = pose.search('div[h3 = "Benefits + Contraindications"]/p[strong = "Contradictions:"]').text  
                  #:difficulty => difficulty, , :benefits => benefits, :contraindications => contraindications 
        puts posture.english  #and remove this puts!   
   
        return posture
        #posture.save!        #quick and dirty but unreliable.  Use yaml instead      
      end
    end

    
end
