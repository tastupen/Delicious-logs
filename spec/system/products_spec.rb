require "rails_helper"

RSpec.describe '商品投稿機能', type: :system do
  let(:user) { create(:user) }
  let!(:genre) { create(:genre) }
  let!(:category) { create(:category) }
  let!(:taste) { create(:taste) }
  describe "商品投稿"  do
    before { sign_in(user) }
    context 'フォームの入力値が正常' do
      it "投稿に成功" do
        visit new_product_path
        fill_in '商品名', with: "ポテチ"
        find('#recommendid').find("option[value='1']").select_option
        fill_in 'おすすめポイント', with: "塩気がちょうど良い"
        fill_in '値段', with: "100"
        find('#genreid').find("option[value='1']").select_option
        find('#categoryid').find("option[value='1']").select_option
        find('#tasteid').find("option[value='1']").select_option
        fill_in '会社名', with: "カルビー"
        click_button '登録する'
        expect(page).to have_content("投稿に成功しました")
      end
    end
  end
end