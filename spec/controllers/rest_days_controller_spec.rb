require File.expand_path('../../spec_helper', __FILE__)

describe RestDaysController, type: :controller do
  describe 'POST create' do
    login_user

    context '登録が正常終了する場合' do
      let(:params){ build(:rest_day_right) }

      it 'RestDayが1増加' do
        expect {
          post :create, params
        }.to change(RestDay, :count).by(1)
      end
    end
  end
end
