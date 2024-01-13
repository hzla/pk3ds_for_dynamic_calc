const TinyMT = require('./TinyMT')
const natures = require('./output/nature.json');
const sets = require('./output/sets.json');
const mons = require('./output/mons.json')
const { writeFileSync } = require('fs');
const Nature = {
	0: "Hardy",
	1: "Lonely",
	2: "Brave",
	3: "Adamant",
	4: "Naughty",
	5: "Bold",
	6: "Docile",
	7: "Relaxed",
	8: "Impish",
	9: "Lax",
	10: "Timid",
	11: "Hasty",
	12: "Serious",
	13: "Jolly",
	14: "Naive",
	15: "Modest",
	16: "Mild",
	17: "Quiet",
	18: "Bashful",
	19: "Rash",
	20: "Calm",
	21: "Gentle",
	22: "Sassy",
	23: "Careful",
	24: "Quirky",
}

	
for (let i = 0; i < natures.length; i++) {
	let level = natures[i][2];
	let IVs = natures[i][3];
	let trainer_class = natures[i][4];
	let species = natures[i][5];

	let mt = new TinyMT.TinyMT(IVs + level + species);
	for (let i = 0; i < trainer_class; ++i) {
		mt.GetNext32Bit();
	}

	let personal_rand = mt.GetNext32Bit();
	let p_rand_bigInt = BigInt(personal_rand);
	let p_rand_rshift_8 = p_rand_bigInt >> BigInt(8);

	let nature_int = p_rand_rshift_8 % BigInt(25);

	let nature = Nature[nature_int.toString()];

	sets[natures[i][0]][natures[i][1]]["nature"] = nature

	if (sets[natures[i][0]][natures[i][1]]["ability"] == "Any") {
		ability = mons[natures[i][0]]["abilities"][Number(p_rand_rshift_8) & 1]
		sets[natures[i][0]][natures[i][1]]["ability"] = ability
	}
}

writeFileSync("./output/new_sets.json", JSON.stringify(sets))
console.log("Natures calculated successfully")
