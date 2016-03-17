require './spec/spec_helper'

describe PostsController do

  context 'GET /' do
    subject { get '/' }

    context 'when do not have posts' do
      it { expect(subject.status).to eql(200) }
      it { expect(JSON.parse(subject.body)).to be_empty }
    end
  end
end