require 'test_helper'

class AsanasSequencesTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end   
  
  def test_invalid_with_empty_attributes 
    posture = AsanasSequences.new 
    assert !posture.valid? 
    assert posture.errors.invalid?(:asana_id) 
    assert posture.errors.invalid?(:sequence_id) 
  end
end
