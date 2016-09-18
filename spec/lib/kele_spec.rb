require 'spec_helper'

describe Kele, type: :request do
  context '.kele' do
    let (:kele) { Kele.new(ENV['EMAIL'], ENV['PASSWORD']) }

    it "has a version number" do
      expect(Kele::VERSION).not_to be nil
    end

    describe '#initialize' do
      it 'authenticates user' do
        expect(kele.instance_variable_get(:@auth_token)).to be_a String
      end

      it 'rejects incorrect email/password' do
        expect { Kele.new("test@example.com", "password") }.to raise_error(RuntimeError)
      end
    end

    describe '#get_me' do
      it 'returns an object with id' do
        result = kele.get_me
        expect(result).to be_a Object
        expect(result).to include("id")
      end
    end
  end
end
