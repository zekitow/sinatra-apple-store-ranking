require './spec/spec_helper'

describe AppleStoreController do

  context 'all rankings' do

    subject { get '/apple-store/ranking', params }

    context 'when params are invalid' do
      let!(:params) { {} }

      it { expect(subject.status).to eql(422) }
      it { expect(JSON.parse(subject.body)).to include({ "message" => ["genreId is required."] }) }
    end # when params are valid

    context 'when params are valid' do

      context 'and it does not exists on API' do
        let!(:params) { { genreId: '1' } }

        it 'should return not found' do
          VCR.use_cassette('genreId not found') do
            expect(subject.status).to eql(404)
          end
        end

        it 'should return the error message' do
          VCR.use_cassette('genreId not found') do
            expect(JSON.parse(subject.body)).to include({ "message" => "genreId not found." })
          end
        end
      end # and it does not exists on API

      context 'and it exists on API' do
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
      end # and it exists on API

    end # when params are valid

  end # all rankings

  context 'ranking by categories' do

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
            expect(JSON.parse(subject.body)).to_not be_empty
          end
        end

      end # and it exists on API
    end

  end # ranking by categories
end