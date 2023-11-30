require "rails_helper" 

RSpec.describe Director do 
  describe 'relationships' do 
    it { should have_many :movies }
  end
end 