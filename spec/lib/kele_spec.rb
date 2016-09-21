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

    describe '#get_mentor_id' do
      it 'returns a number' do
        result = kele.get_mentor_id
        expect(result).to be_a(Numeric)
      end
    end

    describe '#get_mentor_availability' do
      it 'returns an object' do
        result = kele.get_mentor_id
        expect(result).to be_a Object
      end
    end

    describe '#get_roadmap' do
      it 'returns an object with id' do
        result = kele.get_roadmap(31)
        expect(result).to be_a Object
        expect(result).to include("id")
      end
    end

    describe '#get_checkpoint' do
      it 'returns an object with id' do
        result = kele.get_checkpoint(1606)
        expect(result).to be_a Object
        expect(result).to include("id")
      end
    end

    describe '#get_messages' do
      it 'returns an object with count with page' do
        result = kele.get_messages(1)
        expect(result).to be_a Object
        expect(result).to include("count")
      end

      it 'returns an object with count without page' do
        result = kele.get_messages
        expect(result).to be_a Object
        expect(result).to include("count")
      end
    end
  end
end
