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

  describe 'POST import' do
    before { login_user }

    context 'CSVインポートが成功する場合' do
      let(:import_file) { File.expand_path('../../fixtures/rest_days.csv', __FILE__) }
      let(:params) { { rest_day_csv: { file: create_uploaded_file(import_file, 'text/csv') } } }
      subject { post :import, params }

      it 'RestDayが4増加' do
        subject
        expect(RestDay.count).to eq(4)
      end
    end

    context 'CSVインポートが失敗する場合' do
      context '入力ファイルの拡張子がcsv以外の場合' do
        render_views

        let(:import_file) { File.expand_path('../../fixtures/rest_days.txt', __FILE__) }
        let(:params) { { rest_day_csv: { file: create_uploaded_file(import_file, 'text/plain') } } }
        subject { post :import, params }

        it 'RestDayが登録されない' do
          subject
          expect(RestDay.count).to eq(0)
        end

        it 'フラッシュメッセージを含んだindex画面を表示する' do
          subject
          expect(response).to render_template(:index)
          expect(response).to be_success
          expect(response.body).to have_selector '#errorExplanation'
        end
      end
    end
  end
end
