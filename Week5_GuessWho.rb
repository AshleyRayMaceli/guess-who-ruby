class Suspect
	attr_reader :name, :gender, :skin_color, :hair_color, :eye_color

	def initialize(record)
		attributes = record.split
		@name = attributes[0]
		@gender = attributes[1]
		@skin_color = attributes[2]
		@hair_color = attributes[3]
		@eye_color = attributes[4]
	end
end

class GuessWho
	attr_reader :suspects, :guilty_one
	attr_accessor :guess_count, :continue

	def initialize
		@guess_count = 0
		@continue = true
		play_game
	end

	private

	def create_suspects
		@suspects = []
		suspects << Suspect.new("rachel girl black auburn brown")
		suspects << Suspect.new("mac boy white black brown")
		suspects << Suspect.new("nick boy white brown blue")
		suspects << Suspect.new("angie girl white auburn green")
		suspects << Suspect.new("theo boy white blonde brown")
		suspects << Suspect.new("joshua boy white black brown")
		suspects << Suspect.new("emily girl white blonde brown")
		suspects << Suspect.new("jason boy white blonde green")
		suspects << Suspect.new("grace girl black black brown")
		suspects << Suspect.new("jake boy white brown brown")
		suspects << Suspect.new("megan girl white blonde green")
		suspects << Suspect.new("ryan boy white auburn brown")
		suspects << Suspect.new("brandon boy white blonde brown")
		suspects << Suspect.new("beth girl white blonde brown")
		suspects << Suspect.new("diane girl black brown brown")
		suspects << Suspect.new("chris boy white black green")
		suspects << Suspect.new("david boy black black brown")
		suspects << Suspect.new("michelle girl black brown brown")
		suspects << Suspect.new("tyson boy black black brown")
		suspects << Suspect.new("ursula girl white auburn green")
	end

	def set_guilty_one
		@guilty_one = suspects.shuffle.last #.last doesn't remove it like .pop
	end

	def play_game
		create_suspects
		set_guilty_one
		start_game
	end

	def start_game
		puts "=============================="
		puts "Welcome to Guess Who! Someone is guilty of a crime... But who?!"
		print_list_of_suspects

		while continue == true do
			if guess_count < 3
				puts "What attribute would you like to guess on? Choose: Hair, Gender, Eye, Skin. You can exit now by typing exit."
				choice = gets.chomp.downcase
				ask_questions(choice)
				return false if choice == "exit" or continue == false
			end
		end
	end

	def print_list_of_suspects
		puts "List of Suspects"
		puts "=============================="
		suspects.each do |suspect|
			puts suspect.name.capitalize
		end
		puts "=============================="
	end

	def ask_questions(choice)
		case choice
		when "hair"
			ask_about_hair
		when "gender"
			ask_about_gender
		when "eye"
			ask_about_eye
		when "skin"
			ask_about_skin
		when "exit"
			false
		end
	end

	def ask_about_hair
		puts "What hair color do you think the culprit has? (black / brown / auburn / blonde)"
		hair = gets.chomp.downcase

		if hair != guilty_one.hair_color
			suspects.reject! {|suspect| suspect.hair_color == hair}
			puts "The culprit's hair color is not #{hair}."
		end

		if hair == guilty_one.hair_color
			suspects.keep_if {|suspect| suspect.hair_color == hair}
			puts "Yes! The culprit's hair color is #{hair}."
		end
		take_a_guess
	end

	def ask_about_gender
		puts "What gender do you believe the culprit is? (boy / girl)"
		gender = gets.chomp.downcase

		if gender != guilty_one.gender
			suspects.reject! {|suspect| suspect.gender == gender}
			puts "The culprit is not a #{gender}."
		end

		if gender == guilty_one.gender
			suspects.keep_if {|suspect| suspect.gender == gender}
			puts "Yes! The culprit is a #{gender}."
		end
		take_a_guess
	end

	def ask_about_eye
		puts "What eye color do you think the culprit has? (black / brown / green / blue)"
		eye = gets.chomp.downcase

		if eye != guilty_one.eye_color
			suspects.reject! {|suspect| suspect.eye_color == eye}
			puts "The culprit's eye color is not #{eye}."
		end

		if eye == guilty_one.eye_color
			suspects.keep_if {|suspect| suspect.eye_color == eye}
			puts "Yes! The culprit's eye color is #{eye}."
		end
		take_a_guess
	end

	def ask_about_skin
		puts "What skin color do you think the culprit has? (black / white)"
		skin = gets.chomp.downcase

		if skin != guilty_one.skin_color
			suspects.reject! {|suspect| suspect.skin_color == skin}
			puts "The culprit's skin color is not #{skin}."
		end

		if skin == guilty_one.skin_color
			suspects.keep_if {|suspect| suspect.skin_color == skin}
			puts "Yes! The culprit's skin color is #{skin}."
		end
		take_a_guess
	end

	def take_a_guess
		puts "Based on the information you have, who do you believe did it?"
		print_list_of_suspects
		guilty_guess = gets.chomp.downcase

		if guilty_guess == guilty_one.name
		puts "You caught the culprit! It was #{guilty_guess.capitalize}!"
		self.continue = false
		end

		if guilty_guess != guilty_one.name
		suspects.reject! {|suspect| suspect.name == guilty_guess}
		puts "No, #{guilty_guess.capitalize} is completely innocent."
		self.guess_count += 1
		end

		if self.guess_count >= 3
		puts "I'm sorry you did not catch the culprit. It was #{guilty_one.name.capitalize} all along!"
		self.continue = false
		end
	end
end

GuessWho.new