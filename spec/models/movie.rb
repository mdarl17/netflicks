require "rails_helper" 

RSpec.describe Movie do 
  describe 'relationships' do 
    it { should belong_to :director }
  end
end 