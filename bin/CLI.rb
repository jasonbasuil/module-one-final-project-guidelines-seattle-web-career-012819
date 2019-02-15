class CLI
  attr_accessor :user_id

    def initialize
      puts ""
      puts "WELCOME TO THE KING COUNTY PET FINDER"
      puts ""
      puts " U ´ᴥ` U  BARK  ໒( ̿❍ ᴥ ̿❍)ʋ  BARK  υ´• ﻌ •`υ "
      puts ""
      puts " [^._.^]ﾉ彡 MEOW =＾● ㉨ ●＾= MEOW  =＾● ⋏ ●＾= "
      puts ""
    end

    def create_user
      puts "Do you have a user account? (y/n)"
      answer = gets.chomp.downcase
      if answer == "n"
        puts "Enter your name:"
        name = gets.chomp.downcase
        puts "Enter your email:"
        email = gets.chomp.downcase
        found = User.find_by(email: email)
        if found != nil
          puts "Oops! Looks like there's already an account with that email.".red
          return find_by_user()
        else
          system("clear")
          user = User.create(name: name, email: email)
          puts "Thanks #{name.capitalize}.".green
          puts ""
        end
      elsif answer == "y"
        return find_by_user()
      else
        puts "Whoa! That's not y OR n! Please choose y or n!".red
        create_user()
      end
      @user_id = user.id
    end

    def find_by_user
      puts ""
      puts "What's your email?"
      user_email = gets.chomp.downcase
      user = User.find_by(email: user_email)
      if user.nil?
        puts "Sorry, we couldn't find an account associated to that email address.  Please create a new account or try again.".red
        puts ""
        create_user()
      else
        system("clear")
        puts "Thanks #{user.name.capitalize}."
        puts ""
        @user_id = user.id
      end
    end

    def main_menu
        puts "Choose an option from the MENU below: "
        puts ""
        puts "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
        puts ""
        puts "1. BROWSE pets by species(DOG or CAT)"
        puts "2. BROWSE pets by status (ADOPTABLE, LOST, FOUND)"
        puts "3. VIEW your favorite pets"
        puts "4. UPDATE your user account"
        puts "0. EXIT"
        answer = gets.chomp.downcase
        puts ""

        if answer == "1"
          browse_pets_by_species()
        elsif answer == "2"
          browse_pets_by_status()
        elsif answer == "3"
          view_favorites()
        elsif answer == "4"
          system("clear")
          update_user_account()
        elsif answer == "0"
          puts "THANKS FOR VISITING KING COUNTY PET FINDER".green
          puts ""
          puts "Meow meow. Bark bark."
          puts ""
          puts " U ´ᴥ` U  BARK  ໒( ̿❍ ᴥ ̿❍)ʋ  BARK  υ´• ﻌ •`υ "
          puts ""
          puts " [^._.^]ﾉ彡 MEOW =＾● ㉨ ●＾= MEOW  =＾● ⋏ ●＾= "
          puts ""
          puts ""
          exit
        else
          puts "OOPS! Please choose from the given options.".red
          puts ""
          return self.main_menu
        end
      end

      def browse_pets_by_species
        puts "Please choose the species you would like to see:"
        puts "Type 1 to see CATS"
        puts "Type 2 to see DOGS"
        puts "Type 0 to go to the MENU"
        species_choice = gets.chomp
        if species_choice == "1"
            view_animal("animal_type", "Cat")
        elsif species_choice == '2'
            view_animal("animal_type", "Dog")
        elsif species_choice == '0'
            system("clear")
            main_menu()
        else
            puts ""
            puts "OOPS! Please enter a valid option of 1 or 2.".red
            puts ""
            browse_pets_by_species()
        end
      end

      def browse_pets_by_status
        puts "Please choose an option:"
        puts "Type 1 to see LOST pets"
        puts "Type 2 to see FOUND pets"
        puts "Type 3 to see ADOPTABLE pets"
        puts "Type 0 to return to the MENU"
        status_choice = gets.chomp
        if status_choice == "1"
            view_animal("record_type", "LOST")
        elsif status_choice == '2'
            view_animal("record_type", "FOUND")
        elsif status_choice == '3'
            view_animal("record_type", "ADOPTABLE")
        elsif status_choice == '0'
            system("clear")
            main_menu()
        else
            puts "Please enter a valid option of 1, 2, 3, or 0.".red
            puts ""
            self.browse_pets_by_status()
        end
      end

      def view_animal(type, option)
        response = RestClient.get("https://data.kingcounty.gov/resource/murn-chih.json")
        pets = JSON.parse(response.body)
        # binding.pry
        animals = []
        count = 1
        pets.each do |pet|
          if !pet["animal_type"].include?("Dead") && pet[type].include?(option)
            puts "Favorite Number: " "#{count}"
            puts "ID: " "#{pet["animal_id"]}"
            puts "Name: " + "#{pet["animal_name"]} "
            puts "Species: " + "#{pet["animal_type"]} "
            puts "Breed: " + "#{pet["animal_breed"]} "
            puts "Age: " + "#{pet["age"]} "
            puts "Photo: " + "#{pet["image"]} "
            puts "Information: " + "#{pet["link"]} "
            puts "Current status: " + "#{pet["record_type"]} "
            puts ""
        animals << pet
        count += 1
          end
       end
      animals
      puts "Select the number you would like to favorite or press 0000 to go back to the MENU."
      input = gets.chomp.to_i
      system("clear")
      if input == 0000
        system("clear")
        main_menu()
      elsif FaveAnimal.exists?(:animal_key => animals[input -1]["animal_id"]) == false
        favorite = FaveAnimal.create(animal_key: animals[input -1]["animal_id"], name: animals[input - 1]["animal_name"], species: animals[input - 1]["animal_type"], breed: animals[input - 1]["animal_breed"], age: animals[input - 1]["age"], image: animals[input - 1]["image"], website: animals[input - 1]["link"], status: animals[input - 1]["record_type"])
        @fave_animal_id = favorite.id
        UserFave.create(user_id: @user_id, fave_animal_id: @fave_animal_id)
        system("clear")
        puts "Favorite successfully added!".green
        puts ""
        main_menu()
      else
        found = FaveAnimal.find_by(:animal_key => animals[input -1]["animal_id"])
        @fave_animal_id = found.id
        UserFave.create(user_id: @user_id, fave_animal_id: @fave_animal_id)
        system("clear")
        puts "Favorite successfully added!".green
        puts ""
        main_menu()
      end
    end

    def my_favorites
      UserFave.all.select do |favorite|
        favorite.user_id == @user_id
      end
    end

    def view_favorites
      fav_animals = []
      my_favorites.each do |favorite|
        FaveAnimal.all.each do |animal|
          if animal.id == favorite.fave_animal_id
            fav_animals << animal
          end
        end
      end
      count = 1
      fav_animals = fav_animals.uniq
      fav_animals.each do |animal|
        puts "Favorite Number: " "#{count} "
        puts "ID: " "#{animal["animal_key"]}"
        puts "Name: " + "#{animal["name"]}"
        puts "Species: " + "#{animal["species"]} "
        puts "Breed: " + "#{animal["breed"]} "
        puts "Age: " + "#{animal["age"]} "
        puts "Photo: " + "#{animal["image"]} "
        puts "Information: " + "#{animal["website"]} "
        puts "Current status: " + "#{animal["status"]} "
        puts ""
        count += 1
      end
      if fav_animals.empty?
        system("clear")
        puts "Nothing to view here! Please add favorites to your list!".red
        puts ""
        puts ""
        main_menu()
      else
      puts "Please choose from the following choices: "
      puts "Type 1 to remove a favorited animal from your list."
      puts "Type 2 to view an image of your favorite animal."
      puts "Type 0 to return to the MENU."
      response = gets.chomp.downcase
        if response == "1"
          puts ""
          puts "Which FAVORITE NUMBER would you like to remove?"
          input = gets.chomp.to_i
          found = UserFave.find_by(:fave_animal_id => fav_animals[input - 1]["id"])
          UserFave.delete(found["id"])
          system("clear")
          puts "Successfully removed #{found["species"]} from your favorites!".green
          view_favorites()
        elsif response == "2"
          puts ""
          puts "Please enter the FAVORITE NUMBER for the image you would like to see. This will open in a new window."
          input = gets.chomp.to_i
          Launchy.open(fav_animals[input -1]["image"])
          system("clear")
          view_favorites()
    else response == "0"
      system("clear")
      main_menu()
    end
  end
end

    def update_user_account
      puts "Updating your user account information."
      puts "Please select an option below."
      puts "1. VIEW account information"
      puts "2. Update NAME and EMAIL"
      puts "0. Return to MENU"
      input = gets.chomp.to_i

      if input == 0
        system("clear")
        main_menu()

      elsif input == 1
        puts "What is your current EMAIL?"
        puts ""
        got_email = gets.chomp.downcase
        user = User.find_by(email: got_email)
        puts "Name: #{user.name}" 
        puts "Email: #{user.email}"
        # binding.pry
        main_menu

      else input == 2
        puts "What is your current EMAIL?"
        puts ""
        got_email = gets.chomp.downcase
        found = User.find_by(email: got_email)
          if found == nil
            puts "Sorry, you must've had a typo! Please try again.".red
            update_user_account()
          else
            puts ""
            puts "What would you like to update your NAME to?"
            new_name = gets.chomp.downcase
            puts "What would you like to update your EMAIL to?"
            new_email = gets.chomp.downcase
            found.update(name: new_name, email: new_email)
            system("clear")
            puts "Great! We updated your USER ACCOUNT.".green
            puts ""
            main_menu()
        
        end
      end
    end



end
# End CLI class
