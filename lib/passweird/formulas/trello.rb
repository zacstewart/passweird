module Passweird
  module Formulas
    class Trello < Formula
      root_url 'https://trello.com'

      def error
        find('.error').text
      end

      def change_password
        sign_in
        find('.js-open-header-member-menu').click
        click_link 'Settings'
        click_link 'Change Password'
        fill_in 'Old Password', with: keychain.password
        keychain.generate_and_save_password
        fill_in 'New Password', with: keychain.password
        fill_in 'New Password (again)', with: keychain.password
        click_button 'Save'
      end

      def sign_in
        visit '/'
        click_link 'Log In'
        fill_in 'Email', with: keychain.username
        fill_in 'Password', with: keychain.password
        click_button 'Log In'
        raise SignInFailure, error unless signed_in?
      end

      def signed_in?
        has_css?('.js-open-header-member-menu')
      end
    end
  end
end
