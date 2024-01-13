class String

	
	def parse encoding='utf-16le'
		begin
			force_encoding(encoding).encode("UTF-8").strip
		rescue
			force_encoding(encoding).encode("UTF-8")
		end
	end

	def parse_species_name subs
		entry_id = self.split(" - ")[0].to_i
		species_name = self.split(" - ")[1]
		
		if subs[entry_id]
			if subs[entry_id] != "Mega"
				return subs[entry_id]
			else
				return species_name.split(" ")[0..-2].join("") + "-Mega"
			end
		end
		species_name
	end

	def get_trainer_info gen=6
		info = split(" - ")

		if gen == 6
			{class_name: info[1], class_id: info[2][0..2].to_i, trainer_name: info[2][4..-1]}
		else
			{class_name: nil, class_id: nil, trainer_name: info[1]}
		end
	end
end

class Calc

	def self.get_subs gen
		if gen == 6
			gen_6_subs
		else
			gen_7_subs
		end
	end

	def self.gen_6_subs
		subs = {}
		subs[722] = "Deoxys-Attack"
		subs[723] = "Deoxys-Defense"
		subs[724] = "Deoxys-Speed"
		subs[725] = "Wormadam-Sandy"
		subs[726] = "Deoxys-Attack"
		subs[727] = "Wormadam-Trash"
		subs[728] = "Shaymin-Sky"	
		subs[729] = "Giratina-Origin"
		subs[730] = "Rotom-Heat"
		subs[731] = "Rotom-Wash"
		subs[732] = "Rotom-Frost"
		subs[733] = "Rotom-Fan"
		subs[734] = "Rotom-Mow"
		subs[735] = "Castform-Sunny"
		subs[736] = "Castform-Rainy"
		subs[737] = "Castform-Snowy"
		subs[738] = "Basculin-Blue-Striped"
		subs[739] = "Darmanitan-Zen"
		subs[740] = "Meloetta-Pirouette"
		subs[741] = "Kyurem-White"
		subs[742] = "Kyurem-Black"
		subs[743] = "Keldeo-Resolute"
		subs[744] = "Tornadus-Therian"
		subs[745] = "Thundurus-Therian"
		subs[746] = "Landorus-Therian"
		subs[747] = "Mega"
		subs[748] = "Meowstic-F"
		subs[758] = "Mega"
		subs[759] = "Mega"
		subs[760] = "Mega"
		subs[761] = "Charizard-Mega-X"
		subs[762] = "Charizard-Mega-Y"
		subs[763] = "Mewtwo-Mega-X"
		subs[764] = "Mewtwo-Mega-Y"
		(1..23).each do |n|
			subs[764 + n] = "Mega"
		end
		subs[776] = "Aegislash-Blade"
		subs[788] = "Pumpkaboo-Small"
		subs[789] = "Pumpkaboo-Large"
		subs[790] = "Pumpkaboo-Super"
		subs[791] = "Gourgeist-Small"
		subs[792] = "Gourgeist-Large"
		subs[793] = "Gourgeist-Super"
		subs[798] = "Floette-Eternal"

		(1..13).each do |n|
			subs[798 + n] = "Mega"
		end

		subs[812] = "Kyogre-Primal"
		subs[813] = "Groudon-Primal"
		subs[814] = "Mega"
		subs[815] = "Pikachu-Rock-Star"
		subs[816] = "Pikachu-Belle"
		subs[817] = "Pikachu-Pop-Star"
		subs[818] = "Pikachu-PhD"
		subs[819] = "Pikachu-Libre"
		subs[820] = "Pikachu-Cosplay"
		subs[821] = "Hoopa-Unbound"
		(1..4).each do |n|
			subs[821 + n] = "Mega"
		end

		subs

	end

	def self.gen_7_subs
		subs = {}
		subs[88 + 722] = "Deoxys-Attack"
		subs[88 + 723] = "Deoxys-Defense"
		subs[88 + 724] = "Deoxys-Speed"
		subs[88 + 725] = "Wormadam-Sandy"
		subs[88 + 726] = "Deoxys-Attack"
		subs[88 + 727] = "Wormadam-Trash"
		subs[88 + 728] = "Shaymin-Sky"	
		subs[88 + 729] = "Giratina-Origin"
		subs[88 + 730] = "Rotom-Heat"
		subs[88 + 731] = "Rotom-Wash"
		subs[88 + 732] = "Rotom-Frost"
		subs[88 + 733] = "Rotom-Fan"
		subs[88 + 734] = "Rotom-Mow"
		subs[88 + 735] = "Castform-Sunny"
		subs[88 + 736] = "Castform-Rainy"
		subs[88 + 737] = "Castform-Snowy"
		subs[88 + 738] = "Basculin-Blue-Striped"
		subs[88 + 739] = "Darmanitan-Zen"
		subs[88 + 740] = "Meloetta-Pirouette"
		subs[88 + 741] = "Kyurem-White"
		subs[88 + 742] = "Kyurem-Black"
		subs[88 + 743] = "Keldeo-Resolute"
		subs[88 + 744] = "Tornadus-Therian"
		subs[88 + 745] = "Thundurus-Therian"
		subs[88 + 746] = "Landorus-Therian"
		subs[88 + 747] = "Mega"
		subs[88 + 748] = "Meowstic-F"
		subs[88 + 758] = "Mega"
		subs[88 + 759] = "Mega"
		subs[88 + 760] = "Mega"
		subs[88 + 761] = "Charizard-Mega-X"
		subs[88 + 762] = "Charizard-Mega-Y"
		subs[88 + 763] = "Mewtwo-Mega-X"
		subs[88 + 764] = "Mewtwo-Mega-Y"
		(1..23).each do |n|
			subs[88 + 764 + n] = "Mega"
		end
		subs[88 + 776] = "Aegislash-Blade"
		subs[88 + 788] = "Pumpkaboo-Small"
		subs[88 + 789] = "Pumpkaboo-Large"
		subs[88 + 790] = "Pumpkaboo-Super"
		subs[88 + 791] = "Gourgeist-Small"
		subs[88 + 792] = "Gourgeist-Large"
		subs[88 + 793] = "Gourgeist-Super"
		subs[88 + 798] = "Floette-Eternal"

		(1..13).each do |n|
			subs[88 + 798 + n] = "Mega"
		end

		subs[88 + 812] = "Kyogre-Primal"
		subs[88 + 813] = "Groudon-Primal"
		subs[88 + 814] = "Mega"

		subs[88 + 821] = "Hoopa-Unbound"
		(1..4).each do |n|
			subs[88 + 821 + n] = "Mega"
		end

		subs[908] = "Wishiwashi-School"
		subs[909] = "Oricorio-Pa'u"
		subs[910] = "Oricorio-Pom-Pom"
		subs[911] = "Oricorio-Sensu"
		subs[912] = "Lycanroc-Midnight"
		subs[913] = "Lycanroc-Dusk"

		(1..18).each do |n|
			subs[913 + n] = "Alola"
		end

		subs[916] = "Raticate-Alola-Totem"

		subs[932] = "Greninja-Bond"
		subs[933] = "Greninja-Ash"

		subs[934] = "Zygarde-10%"
		subs[935] = "Zygarde-10%"
		subs[936] = "Zygarde-50%"
		subs[937] = "Zygarde-Complete"

		subs[938] = "Minior-Meteor"

		subs[951] = "Alola"
		subs[952] = "Alola"

		subs[953] = "Mimikyu-Busted"
		subs[954] = "Mimkyu-Totem"
		subs[955] = "Mimkyu-Busted-Totem"

		subs[956] = "Magearna-Original"

		subs[957] = "Pikachu-Original"
		subs[958] = "Pikachu-Hoenn"
		subs[959] = "Pikachu-Sinnoh"
		subs[960] = "Pikachu-Unova"
		subs[961] = "Pikachu-Kalos"
		subs[962] = "Pikachu-Alola"
		subs[963] = "Pikachu-Partner"

		subs[964] = "Gumshoos-Totem"
		subs[965] = "Vikavolt-Totem"
		subs[966] = "Lurantis-Totem"
		subs[967] = "Salazzle-Totem"
		subs[968] = "Kommo-o-Totem"

		subs[969] = "Necrozma-Dawn-Wings"
		subs[970] = "Necrozma-Dusk-Mane"
		subs[971] = "Necrozma-Ultra"

		subs[972] = "Araquanid-Totem"
		subs[973] = "Togedemaru-Totem"
		subs[974] = "Ribombee-Totem"

		subs

	end

	def self.stones
		stones = ["Gengarite",
		"Gardevoirite",
		"Ampharosite",
		"Venusaurite",
		"Charizardite X",
		"Blastoisinite",
		"Mewtwonite X",
		"Mewtwonite Y",
		"Blazikenite",
		"Medichamite",
		"Houndoominite",
		"Aggronite",
		"Banettite",
		"Tyranitarite",
		"Scizorite",
		"Pinsirite",
		"Aerodactylite",
		"Lucarionite",
		"Abomasite",
		"Kangaskhanite",
		"Gyaradosite",
		"Absolite",
		"Charizardite Y",
		"Alakazite",
		"Heracronite",
		"Mawilite",
		"Manectite",
		"Garchompite",
		"Latiasite",
		"Latiosite",
		"Swampertite",
		"Sceptilite",
		"Sablenite",
		"Altarianite",
		"Galladite",
		"Audinite",
		"Metagrossite",
		"Sharpedonite",
		"Slowbronite",
		"Steelixite",
		"Pidgeotite",
		"Glalitite",
		"Diancite",
		"Cameruptite",
		"Lopunnite",
		"Salamencite",
		"Beedrillite"]
	end
end

