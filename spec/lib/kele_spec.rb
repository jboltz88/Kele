require 'spec_helper'

describe Kele, type: :request do
  context '.kele' do

    it "has a version number" do
      expect(Kele::VERSION).not_to be nil
    end

    describe '#initialize' do
      it 'authenticates user' do
        kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
        expect(kele.instance_variable_get(:@auth_token)).to be_a String
      end
    end
  end
end
