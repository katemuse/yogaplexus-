require 'test_helper'

class AsanaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end   
  
  def test_invalid_with_empty_attributes 
    asana = Asana.new 
    assert !asana.valid? 
    assert asana.errors.invalid?(:english) 
    assert asana.errors.invalid?(:sanskrit) 
    # assert asana.errors.invalid?(:asasa_type_id) 
    #     assert asana.errors.invalid?(:asasa_sutype_id)               
  end 
  
end
