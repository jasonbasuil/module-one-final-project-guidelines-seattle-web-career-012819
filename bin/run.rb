require_relative '../config/environment'
require_relative '../bin/CLI.rb'


cli = CLI.new
cli.create_user()
cli.main_menu()
