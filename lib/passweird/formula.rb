require 'capybara'
require 'capybara/dsl'
require 'keychains/keychain'
require 'keychains/stdio'
require 'keychains/one_password'

module Passweird
  class Formula
    SignInFailure = Class.new(StandardError)

    include Capybara::DSL

    attr_reader :keychain

    def initialize
      Capybara.run_server = false
      Capybara.current_driver = :selenium
      @keychain = Keychains::OnePassword.new('trello')
    end

    def self.change_password
      new.change_password
    end

    def self.root_url(url)
      Capybara.app_host = url
    end

    def self.get(formula_name)
      require "passweird/formulas/#{ formula_name }"
      Passweird::Formulas.const_get(formula_name.capitalize)
    end
  end
end
