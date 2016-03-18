require './spec/spec_helper'

describe Request::Ranking do
  subject { Request::Ranking.new(params) }

  context 'validations' do

    context 'without params' do
      let!(:params) { {} }

      it { expect(subject.valid?).to be false }
      it { expect(subject.reason).to include('genreId is required.') }
    end

    context 'with params' do
      let!(:params) { { genreId: '6001' } }

      it { expect(subject.valid?).to be true }
      it { expect(subject.reason).to_not include('genreId is required.') }
      it { expect(subject.reason).to be_empty }
    end
  end
end