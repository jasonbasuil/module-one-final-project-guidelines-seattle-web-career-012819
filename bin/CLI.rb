class CLI
  attr_accessor :user_id

    def initialize
      puts ""
      puts "Welcome to the King County Pet Finder"
      puts ""
      puts " U ´ᴥ` U   ໒( ̿❍ ᴥ ̿❍)ʋ  υ´• ﻌ •`υ"
      puts ""
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
        #binding.pry
        user = User.create(name: name, email: email)
        # binding.pry
        puts "Thanks #{name.capitalize}."
      elsif answer == "y"
        return find_by_user()
      else
        puts "Whoa! That's not y OR n! Please choose y or n!"
        create_user()
      end
      @user_id = user.id
    end




    def find_by_user
      puts "What's your email?"
      user_email = gets.chomp.downcase
      user = User.find_by(email: user_email)
      puts "Thanks #{user.name.capitalize}."
      if user.nil?
        puts "Sorry, I we couldn't find an account associated to that email address.  Please create a new account or try again."
        create_user()
      else
        @user_id = user.id
      end
    end

    def main_menu
        puts "What would you like to do?"
        puts "0. exit"
        puts "1. browse pets by species(dog or cat)"
        puts "2. browse pets by status (Adoptable, lost, found)"
        puts "3. View your favorite pets!"
        answer = gets.chomp.downcase
        puts ""

        if answer == "1"
          browse_pets_by_species
        elsif answer == "2"
          browse_pets_by_status
        elsif answer == "3"
          view_favorite_pets
        elsif answer == "0"
          puts "Thanks for visiting King County Pet Finder!"
          exit
        else
          puts "Wrong Choice!"
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
            view_species_by_cat()
        elsif species_choice == '2'
            view_species_dog()
        elsif species_choice == '0'
            main_menu()
        else
            puts "Please enter a valid option of 1 or 2."
            self.browse_pets_species()
        end
      end

      def view_species_by_cat
        response = RestClient.get("https://data.kingcounty.gov/resource/murn-chih.json")
        pets = JSON.parse(response.body)
        # binding.pry
        pets.each do |pet|
          if !pet["animal_type"].include?("Dead") && pet["animal_type"].include?("Cat")
            puts "Name: " + "#{pet["animal_name"]} "
            puts "Species: " + "#{pet["animal_type"]} "
            puts "Breed: " + "#{pet["animal_breed"]} "
            puts "Age: " + "#{pet["age"]} "
            puts "Photo: " + "#{pet["image"]} "
            puts "Information: " + "#{pet["link"]} "
            puts "Current status: " + "#{pet["record_type"]} "
            puts ""
        # binding.pry
        end
      end
      main_menu()
    end

    def view_species_dog
        response = RestClient.get("https://data.kingcounty.gov/resource/murn-chih.json")
        pets = JSON.parse(response.body)
        # binding.pry
        pets.each do |pet|
            if !pet["animal_type"].include?("Dead") && pet["animal_type"].include?("Dog")
              puts "Name: " + "#{pet["animal_name"]} "
              puts "Species: " + "#{pet["animal_type"]} "
              puts "Breed: " + "#{pet["animal_breed"]} "
              puts "Age: " + "#{pet["age"]} "
              puts "Photo: " + "#{pet["image"]} "
              puts "Information: " + "#{pet["link"]} "
              puts "Current status: " + "#{pet["record_type"]} "
              puts ""
          # binding.pry
          end
        end
        main_menu()
    end

    def browse_pets_by_status
      puts "Please choose an option:"
      puts "Type 1 to see LOST pets"
      puts "Type 2 to see FOUND pets"
      puts "Type 3 to see ADOPTABLE pets"
      puts "Type 0 to return to the MENU"
      status_choice = gets.chomp
      if status_choice == "1"
          view_status_by_lost()
      elsif status_choice == '2'
          view_status_by_found()
      elsif status_choice == '3'
          view_status_by_adopted()
      elsif status_choice == '0'
          main_menu()
      else
          puts "Please enter a valid option of 1 or 2."
          self.browse_pets_by_status()
      end
    end

    def view_status_by_lost
      response = RestClient.get("https://data.kingcounty.gov/resource/murn-chih.json")
      pets = JSON.parse(response.body)
      # binding.pry
      pets.each do |pet|
        if !pet["animal_type"].include?("Dead") && pet["record_type"].include?("LOST")
          puts "Name: " + "#{pet["animal_name"]} "
          puts "Species: " + "#{pet["animal_type"]} "
          puts "Breed: " + "#{pet["animal_breed"]} "
          puts "Age: " + "#{pet["age"]} "
          puts "Photo: " + "#{pet["image"]} "
          puts "Information: " + "#{pet["link"]} "
          puts "Current status: " + "#{pet["record_type"]} "
          puts ""
      # binding.pry
      end
    end
    main_menu()
  end

    def view_status_by_found
      response = RestClient.get("https://data.kingcounty.gov/resource/murn-chih.json")
      pets = JSON.parse(response.body)
      # binding.pry
      pets.each do |pet|
        if !pet["animal_type"].include?("Dead") && pet["record_type"].include?("FOUND")
          puts "Name: " + "#{pet["animal_name"]} "
          puts "Species: " + "#{pet["animal_type"]} "
          puts "Breed: " + "#{pet["animal_breed"]} "
          puts "Age: " + "#{pet["age"]} "
          puts "Photo: " + "#{pet["image"]} "
          puts "Information: " + "#{pet["link"]} "
          puts "Current status: " + "#{pet["record_type"]} "
          puts ""
      # binding.pry
      end
    end
    main_menu()
    end

    def view_status_by_adopted
      response = RestClient.get("https://data.kingcounty.gov/resource/murn-chih.json")
      pets = JSON.parse(response.body)
      # binding.pry
      adopted = []
      pets.each do |pet|
        if !pet["animal_type"].include?("Dead") && pet["record_type"].include?("ADOPTABLE")
          puts "Number: " "#{pet["animal_id"]}"
          puts "Name: " + "#{pet["animal_name"]} "
          puts "Species: " + "#{pet["animal_type"]} "
          puts "Breed: " + "#{pet["animal_breed"]} "
          puts "Age: " + "#{pet["age"]} "
          puts "Photo: " + "#{pet["image"]} "
          puts "Information: " + "#{pet["link"]} "
          puts "Current status: " + "#{pet["record_type"]} "
          puts ""
      adopted << pet
      end
    end
    adopted
    puts "Select the number you would like to favorite or press 0 to exit."
    input = gets.chomp.to_i
      if input == 0
        main_menu()
      elsif
        FaveAnimal.exists?(:animal_key => adopted[input -1]["animal_id"]) == false

        favorite = FaveAnimal.create(animal_key: adopted[input -1]["animal_id"], name: adopted[input - 1]["animal_name"], species: adopted[input - 1]["animal_type"], breed: adopted[input - 1]["animal_breed"],
        age: adopted[input - 1]["age"], image: adopted[input - 1]["image"], website: adopted[input - 1]["link"], status: adopted[input - 1]["record_type"])
            # binding.pry
        UserFave.create(user_id: @user_id, fave_animal_id: favorite.id)

      else
        FaveAnimal.exists?(:animal_key => adopted[input -1]["animal_id"]) == true
        UserFave.create(user_id: @user_id, fave_animal_id: favorite.id)
      end

    end



  # def add_favorite
  #   puts "Select the number you would like to favorite or press 0 to exit."
  #   input = gets.chomp
  #     if input == "0"
  #       main_menu()
  #     else
  #     favorite = FaveAnimal.find_or_create(adopted[input -1]["animal_name"], adopted[input -1]["animal_type"], adopted[input -1]["animal_breed"],
  #     adopted[input -1]["age"],adopted[input -1]["image"], adopted[input -1]["link"]), adopted[input -1]["record_type"]
  #
  #     UserFave.find_or_create(user.id, favorite.faveanimal_id)
  #     end
  #   end


end # End CLI
