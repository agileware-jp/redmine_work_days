require File.expand_path('../../spec_helper', __FILE__)

describe RestDaysController, type: :controller do
  describe 'POST create' do
    context '登録が正常終了する場合' do
      let(:params){ create(:rest_day_right) }

      it 'RestDayが1増加' do
        expect {
          post RestDaysController.new.create, params
        }.to change(RestDay, :count).by(1)
      end
    end
  end
end
