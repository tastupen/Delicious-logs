require "rails_helper"

RSpec.describe '商品投稿機能', type: :system do
  describe "商品投稿"
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: "test4@example.com")
      products = FactoryBot.create(:product)
    end
    
    context 'ユーザーがログインしても投稿がみれる' do
      before do
        visit new_user_session_path
          fill_in "メールアドレス", with: "test4S@example.com"
          fill_In "パスワード", with: "password"
          click_button "ログインする"
      end
      it "商品が表示されている" do
        expect(page).to have_content("ぽてち")
      end
    end
end