# How to export json for use in Dynamic Calc:

### Step 1: 
Install Ruby https://rubyinstaller.org/


### Step 2: 
Install Node: https://nodejs.org/en/download


### Step 3: 
Open your rom in the included pk3ds.exe


### Step 4: 
Export the following to the folder containing this file

Lvl_up_moves.txt from learnset editor

Mons.txt from personal editor

Moves.txt from move editor

Battles.txt from trainer editor

Do not change any file names

### Step 5: 
Navigate to the folder containing your exported txt files in terminal/command line. Make sure parse.rb is also in this folder

create a new empty folder titled `output`

run `ruby parse.rb GEN` 

GEN is either `6` or `7`

For example `ruby parse.rb 7`


### Step 6: 
copy paste contents of `output/npoint.json` to npoint.io 
Save your json document and copy the document id in the url 
![image](https://github.com/hzla/pk3ds_for_dynamic_calc/assets/5680299/f8e9dac8-2737-49e9-bce6-914f2bf4a912)

Your calc is now viewable at https://hzla.github.io/Dynamic-Calc/?data=COPY_DOCUMENT_ID_TO_HERE&dmgGen=GEN&gen=GEN

replace GEN with 6, 7, 8 depending on your game. If you have added in moves from past your game's generation, set GEN to 8. If you are making a calc for gen 7, set dmgGen to 8.

replace COPY_DOCUMENT_ID_TO_HERE with your document id you copied earlier


