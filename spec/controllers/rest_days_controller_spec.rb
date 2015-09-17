require File.expand_path('../../spec_helper', __FILE__)

describe RestDaysController, type: :controller do
  describe 'POST create' do
    before { login_user }

    context '登録が正常終了する場合' do
      let(:params){ {rest_day: { day: '2015-05-13', description: 'testdata' }} }
      subject { post :create, params }

      it 'RestDayが1増加' do
        subject
        expect(RestDay.count).to eq(1)
      end
    end
  end
end
