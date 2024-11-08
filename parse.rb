require 'json'
require_relative 'calc'



stones = Calc.stones
gen = ARGV[0].to_i
subs = Calc.get_subs gen


=begin
####### REQUIREMENTS ###################
install node.js
install ruby

from pk3ds.exe export the following to the folder containing this file
Lvl_up_moves.txt from learnset editor
Mons.txt from personal editor
Moves.txt from move editor
Battles.txt from trainer editor

navigate to the folder with this file in terminal/powershell and run "ruby parse.rb GEN"
GEN is either 6 or 7
upload copy paste the contents of npoint.json to npoint.io and link to dynamic calc


=end





def get_lvl_up_learnset learnset_data, species_name, lvl
	learnset = learnset_data[species_name]
	moves = []

	if species_name == "---"
		return []
	end

	learnset.each do |ls|
		if ls[0] <= lvl
			moves << ls[1]
		else
			break
		end
	end

	moves[-4..-1]
end

############ PARSE LEARNSETS ############ 
p "parsing learnsets"

learnsets = File.open("Lvl_up_moves.txt","rb:utf-16le"){ |file| file.readlines }
learnset_data = {}
learnsets.each_with_index do |line, i|
	if i % 2 == 0
		species = line.parse.strip
		if i == 0 
			species = "Abomasnow"
		end
		species_learnset = []
		moves = learnsets[i + 1].force_encoding('utf-16le').encode("UTF-8").strip[0..-2].split(" @ ")

		moves.each do |move|
			lvl_learned = move.split(" -- ")[0].to_i
			move_name = move.split(" -- ")[1]
			species_learnset << [lvl_learned, move_name.strip]
		end
		learnset_data[species] = species_learnset
	else
		next
	end
end

File.write("./output/learnsets.json", JSON.pretty_generate(learnset_data))

#########################################

############ PARSE MONS ############ 

p "parsing pokedex"

mons = File.open("Mons.txt","rb:utf-16le"){ |file| file.readlines }
mon_data = {}

mons.each_with_index do |line, i|
	if i % 7 == 0
		species = line.parse.strip.parse_species_name(subs)

		
		mon_data[species] = {}
		
		base_stats = mons[i + 1].parse[12..-1].split(".")
		
		mon_data[species]["bs"] = {}
		["hp", "at", "df", "sa", "sd", "sp"].each_with_index do |stat, j|
			mon_data[species]["bs"][stat] = base_stats[j].to_i
		end

		abilities = mons[i + 3].parse[11..-1].split(" | ")
		mon_data[species]["abilities"] = abilities

		types = mons[i + 4].parse[6..-1].split (' / ')
		mon_data[species]["types"] = types
		mon_data[species]["learnset_info"] = learnset_data[species]
		mon_data[species]["id"] = i / 7 + 1
		
	else
		next
	end
end

File.write("./output/mons.json", JSON.pretty_generate(mon_data))

#########################################

############ PARSE MOVES ############ 

p "parsing moves"

moves = File.open("Moves.txt","rb:utf-16le"){ |file| file.readlines }
move_data = {}

moves.each_with_index do |line, i|
	move_info = line.parse.split( " | ")
	move_name = move_info[0]
	if i == 0
		move_name = "Pound"
	end
	type = move_info[1]
	base_power = move_info[2].to_i
	category = move_info[3]

	move_data[move_name] = {}

	move_data[move_name]["type"] = type
	move_data[move_name]["basePower"] = base_power
	move_data[move_name]["category"] = category
end

File.write("./output/moves.json", JSON.pretty_generate(move_data))


########################################

########### PARSE SETS ############ 

p "parsing sets"

encoding = gen == 6 ? "utf-16le" : "utf-8"


trainers = File.open("Battles.txt", "rb:#{encoding}"){ |file| file.readlines }
sets = {}
current_trainer = nil

nature_queue = []

i = 0

trainer_counts = {}

while i < trainers.length
	line = trainers[i]

	p line.parse(encoding)
	current_trainer = line.parse(encoding).get_trainer_info gen
	p current_trainer
	trainer_title = "#{current_trainer[:class_name]} #{current_trainer[:trainer_name]}".strip.gsub("[", "|").gsub("]","|")

	if !trainer_counts[trainer_title]
		trainer_counts[trainer_title] = 1
	else
		trainer_counts[trainer_title] += 1
		trainer_title += "#{trainer_counts[trainer_title]} "
	end

	if trainer_title.include?("Hau")
		starter_count = trainer_counts["#{current_trainer[:class_name]} #{current_trainer[:trainer_name]}".strip.gsub("[", "|").gsub("]","|")] % 3
		if starter_count == 0
			starter_count = 3
		end
		trainer_title += "|Starter #{starter_count}|"
	end

	i += 1
	num_pokemon = trainers[i].parse(encoding).to_i
	i += 1

	
	(0..num_pokemon - 1).each do |n|
		species_name = trainers[i].parse(encoding)
		p trainers[i]
		sets[species_name] ||= {}
		i += 1
		level = trainers[i].parse(encoding).to_i
		i += 1
		item = trainers[i].parse(encoding).strip
		i += 1
		
		if gen == 7 
			nature = trainers[i].parse(encoding).strip
			i += 1
		end

		ability = trainers[i].parse(encoding).split(" (")[0]
		i += 1
		moves = trainers[i].parse(encoding).split(" / ")
		if moves == ["lvl up learnset"]
			moves = get_lvl_up_learnset(learnset_data, species_name, level)
		end
		i += 1
		
		if gen == 6
			ivs_raw = trainers[i].parse(encoding).to_i
			ivs_all = ivs_raw & 31
			ivs = {"hp" => ivs_all,"at" => ivs_all,"df" => ivs_all,"sa" => ivs_all,"sd" => ivs_all,"sp" => ivs_all}
			evs = {}
		else
			ivs_raw = trainers[i].parse("utf-8").split("/").map(&:to_i)
			ivs = {"hp" => ivs_raw[0],"at" => ivs_raw[1],"df" => ivs_raw[2],"sa" => ivs_raw[3],"sd" => ivs_raw[4],"sp" => ivs_raw[5]}
			i += 1

			evs_raw = trainers[i].parse("utf-8").split("/").map(&:to_i)
			evs = {"hp" => evs_raw[0],"at" => evs_raw[1],"df" => evs_raw[2],"sa" => evs_raw[3],"sd" => evs_raw[4],"sp" => evs_raw[5]}


		end
		i += 1
		set_name = "Lvl #{level} #{trainer_title}"
		sets[species_name][set_name] = {"evs" => evs, "level" => level,"ivs" =>ivs,"item" => item,"class_id" =>current_trainer[:class_id],"moves" =>moves,"sub_index" => n,"ability" =>ability, "ivs_raw" => ivs_raw}

		
		if gen == 6

			base_form_id = mon_data[species_name]["id"] if species_name != "---"

			#change to mega if using mega stone
			if stones.include? item
				mega_name = species_name + "-Mega"
				mega_name += "-X" if item[-1] == "X"
				mega_name += "-Y" if item[-1] == "Y"
				sets[mega_name] ||= {}
				sets[mega_name][set_name] = sets[species_name][set_name]
				sets[species_name].delete(set_name)
				species_name = mega_name
			end

			if species_name != "---"
				sets[species_name][set_name]["p_id"] = base_form_id
				nature_queue << [species_name, set_name, level, ivs_raw, current_trainer[:class_id], base_form_id]
			end
		end

		if gen == 7 
			i += 1
		end
	
	end
	if gen == 6
		i += 1
	end

end

File.write("./output/nature.json", JSON.pretty_generate(nature_queue)) if gen == 6
File.write("./output/sets.json", JSON.pretty_generate(sets))

if gen == 6 
	p `node ./calcNature.js`

	formatted_sets = JSON.parse(File.open("./output/new_sets.json"){ |file| file.read})
else
	formatted_sets = sets
end

npoint = {"moves" => move_data, "poks" => mon_data, "formatted_sets" => formatted_sets}

File.write("./output/npoint.json", npoint.to_json)
