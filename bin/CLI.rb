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
        else
          puts "Wrong Choice!"
          return self.main_menu
        end
      end

      def browse_pets_by_species
        puts "Please choose the species you would like to see:"
        puts "Type 1 to see CATS"
        puts "Type 2 to see DOGS"
        species_choice = gets.chomp
        if species_choice == "1"
            view_species_by_cat()
        elsif species_choice == '2'
            view_species_dog()
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
    end



end # End CLI
