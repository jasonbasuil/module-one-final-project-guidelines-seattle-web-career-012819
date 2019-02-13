class CLI
    def initialize
      puts "Initializing new CLI"
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

    #   def viewer
    #     puts "#{index}. " + "#{pet["Animal_Name"]}", + "#{pet["animal_type"]}" + "#{pet["Animal_Breed"]}", + "#{pet["Age"]}", + "#{pet["Image"]}", + "#{pet["Link"]}",+ "#{pet["Record_Type"]}"
    #   end


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
      pets.each do |pet|
        if !pet["animal_type"].include?("Dead") && pet["record_type"].include?("ADOPTABLE")
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
end # End CLI
