require './spec/spec_helper'

describe AppleStoreController do

  context 'ranking by genreId and monetizationType' do

    subject { get '/apple-store/category', params }

    context 'when params are invalid' do
      let!(:expected_result) { { "message" => ["genreId is required.", "monetizationType is required."] } }
      let!(:params) { {} }

      it { expect(subject.status).to eql(422) }
      it { expect(JSON.parse(subject.body)).to include(expected_result) }
    end

    context 'when params valid' do
      let!(:params) { {} }

      context 'and it does not exists on API' do

        let!(:params) { { genreId: '1', monetizationType: '2' } }

        it 'should return not found' do
          VCR.use_cassette('genreId or monetizationType not found') do
            expect(subject.status).to eql(404)
          end
        end

        it 'should return the error message' do
          VCR.use_cassette('genreId or monetizationType not found') do
            expect(JSON.parse(subject.body)).to include({ "message" => "genreId or MonetizationType not found." })
          end
        end

      end # and it does not exists on API

      context 'and it exists on API' do

        let!(:params) { { genreId: '6001', monetizationType: '30' } }

        it 'should return ok' do
          VCR.use_cassette('valid category result') do
            expect(subject.status).to eql(200)
          end
        end

        it 'should return the content' do
          VCR.use_cassette('valid category result') do
            expect(subject).to match_response_schema('results_by_category')
          end
        end

      end # and it exists on API
    end

  end # ranking by categories
end