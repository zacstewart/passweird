require 'io/console'
require 'securerandom'

module Passweird
  module Keychains
    class Stdio
      def username
        print 'Username: '
        gets.chomp
      end

      def password
        @password ||= get_password_input
      end

      def get_password_input
        print 'Enter password: '
        STDIN.noecho(&:gets).chomp
        puts
      end

      def password=(new_password)
        @password = new_password
        puts new_password
      end

      def generate_and_save_password
        self.password = SecureRandom.hex(16)
      end
    end
  end
end
