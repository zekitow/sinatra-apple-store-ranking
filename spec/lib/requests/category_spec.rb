require './spec/spec_helper'

describe Request::Category do
  subject { Request::Category.new(params) }

  context 'validations' do

    context 'without params' do

      context 'without any' do
        let!(:params) { {} }

        it { expect(subject.valid?).to be false }
        it { expect(subject.reason).to include('genreId is required.') }
        it { expect(subject.reason).to include('monetizationType is required.') }
      end

      context 'without monetizationType params' do
        let!(:params) { { genreId: '6001' } }

        it { expect(subject.valid?).to be false }
        it { expect(subject.reason).to_not include('genreId is required.') }
        it { expect(subject.reason).to     include('monetizationType is required.') }
      end

      context 'without genreId params' do
        let!(:params) { { monetizationType: '6001' } }

        it { expect(subject.valid?).to be false }
        it { expect(subject.reason).to     include('genreId is required.') }
        it { expect(subject.reason).to_not include('monetizationType is required.') }
      end

    end

    context 'with params' do
      let!(:params) { {  monetizationType: '6001', genreId: '6001' } }

      it { expect(subject.valid?).to be true }
      it { expect(subject.reason).to_not include('genreId is required.') }
      it { expect(subject.reason).to_not include('monetizationType is required.') }
      it { expect(subject.reason).to be_empty }
    end
  end
end