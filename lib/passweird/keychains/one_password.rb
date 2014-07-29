require 'one_password'

module Passweird
  module Keychains
    class OnePassword < Keychain
      def initialize(service)
        @service = service
        @one_password = ::OnePassword::Keychain.new('spec/fixtures/Test Vault.agilekeychain')
        print 'Master password: '
        @one_password.password = STDIN.noecho(&:gets).chomp
      end

      def username
        item.login_username
      end

      def password
        item.login_password
      end

      private

      def item
        @item ||= @one_password.
          current_profile.
          all.
          find { |id, item| item.title =~ /#{ @service }/i }.
          fetch(1).
          tap(&:decrypt_data)
      end
    end
  end
end
