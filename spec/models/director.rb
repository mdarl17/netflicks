require "rails_helper" 

RSpec.describe Director do 
  describe "relationships" do 
    it { should have_many :movies }
  end

  describe "instance methods" do 
    describe "#format_name" do 
      it "displays a director's name with first name followed by middle, if any, then last name" do 
        kubrick = Director.create!({name: "Kubrick, Stanley", years_active: 47, best_director: false})
        anderson = Director.create!({name: "Anderson, Paul Thomas", years_active: 25, best_director: false})

        expect(kubrick.format_name).to eq("Stanley Kubrick")
        expect(anderson.format_name).to eq("Paul Thomas Anderson")
      end
    end
  end
end 