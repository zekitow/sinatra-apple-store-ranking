require './spec/spec_helper'

describe AppleStoreController do

  context 'rankings' do

    subject { get '/apple-store/by-ranking', params }

    context 'when params are invalid' do
      let!(:expected_result) { { "message" => ["genreId is required."] } }
      let!(:params) { {} }

      it { expect(subject.status).to eql(422) }
      it { expect(JSON.parse(subject.body)).to include(expected_result) }
    end

    context 'when params are valid' do

      let!(:params) { { genreId: '6001' } }

      it 'should return ok' do
        VCR.use_cassette('valid ranking results') do
          expect(subject.status).to eql(200)
        end
      end

      it 'should return the content' do
        VCR.use_cassette('valid ranking results') do
          expect(JSON.parse(subject.body)).to_not be_empty
        end
      end

    end

  end

  context 'categories' do

    subject { get '/apple-store/category', params }

    context 'when params are invalid' do
      let!(:expected_result) { { "message" => ["genreId is required.", "monetizationType is required."] } }
      let!(:params) { {} }

      it { expect(subject.status).to eql(422) }
      it { expect(JSON.parse(subject.body)).to include(expected_result) }
    end

  end
end