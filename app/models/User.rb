class User < ActiveRecord::Base
  has_many :user_faves
  has_many :fave_animals, through: :user_faves
end

def create_user
    puts "Hello, Would you like to create a user account? (y/n)"
    answer = gets.chomp.downcase
        if answer == "y"
            puts "Enter your name:"
            name = gets.chomp.downcase
            puts "Enter your email:"
            email = gets.chomp.downcase
           user = User.create(name: name, email: email)
            puts "Thanks #{name.capitalize}, welcome to King County Pet Finder!"
        elsif answer == "n"
    puts "Great, you may browse inventory but you will not be able to save any animals to your favorites!"
        else
    puts "Whoa! That's not y OR n! Please choose y or n!"
        return self.create_user
    end
    return user
end

def find_by_user
  puts "Are you a registered user? (y/n)"
  ans = gets.chomp.downcase
  if ans == 'y'
      puts "What's your email?"
      user_email = gets.chomp.downcase
      user = User.find_by(email: user_email)
      if user.nil?
          create_user()
      else
          return user.user_id
      end
  elsif ans == 'n'
      create_user()
  else
      puts "WOW, please tell me your user name"
      create_intro()
  end
end
