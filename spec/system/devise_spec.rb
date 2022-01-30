require 'selenium-webdriver'
require "rails_helper"

RSpec.describe User, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe 'ユーザーログイン' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規登録が成功' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            fill_in 'ニックネーム', with: "テスト２"
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'メールアドレス', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認用)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登録する'
            # 遷移されたページに'User was successfully created.'の文字列があることを期待する
            expect(page).to have_content 'アカウント登録が完了しました'
          end
        end
        
        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            fill_in 'ニックネーム', with: "テスト２"
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'メールアドレス', with: nil
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認用)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登録する'
            # 遷移されたページに'User was successfully created.'の文字列があることを期待する
            expect(page).to have_content 'Emailを入力してください'
          end
        end
        
        context '名前の未記入' do
          it 'ユーザーの新規作成が失敗' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            fill_in 'ニックネーム', with: nil
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'メールアドレス', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認用)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登録する'
            # 遷移されたページに'User was successfully created.'の文字列があることを期待する
            expect(page).to have_content 'Nameを入力してください'
          end
        end
        
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            fill_in 'ニックネーム', with: "テスト２"
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'メールアドレス', with: user.name
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認用)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登録する'
            # 遷移されたページに'User was successfully created.'の文字列があることを期待する
            expect(page).to have_current_path new_user_registration_path
          end
        end
      end
    end
    
    describe 'ログイン後' do
      before { sign_in(user) }
      describe 'ユーザー編集' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの編集が成功' do
            visit mypage_edit_users_path
            fill_in 'ニックネーム', with: "テスト2"
            fill_in 'メールアドレス', with: 'test1@example.com'
            click_button '保存する'
            expect(page).to have_content 'アカウント更新に成功しました'
          end
        end
      end
      
      describe 'パスワードを変更する' do
        context 'パスワードの入力値が正常' do
          it 'パスワードの編集に成功' do
            visit mypage_edit_password_users_path
            fill_in '新しいパスワード', with: 'password1'
            fill_in '確認用', with: 'password1'
            click_button 'パスワード更新'
            expect(page).to have_content 'パスワードは正しく更新されました。'
          end
        end
        context '新しいパスワードが未記入' do
          it 'パスワードの更新に失敗' do
            visit mypage_edit_password_users_path
            fill_in '新しいパスワード', with: nil
            fill_in '確認用', with: 'password1'
            click_button 'パスワード更新'
            expect(page).to have_content ''
          end
        end
        context '確認が未記入' do
          it 'パスワードの更新に失敗' do
            visit mypage_edit_password_users_path
            fill_in '新しいパスワード', with: 'password1'
            fill_in '確認用', with: nil
            click_button 'パスワード更新'
            expect(page).to have_content ''
          end
        end
      end
    end
  end
end