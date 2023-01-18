# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Pokedex.destroy_all
Pokedex.create!([{
    name: "Charmander",
    max_hp: 39,
    max_exp: 100,
    attack: 52,
    defence: 43,
    speed: 65,
    special: 50,
    element_1: "Fire",
    element_2: nil,
    image: "004Charmander.png"
},
{
    name: "Bulbasaur",
    max_hp: 45,
    max_exp: 100,
    attack: 49,
    defence: 49,
    speed: 45,
    special: 65,
    element_1: "Grass",
    element_2: nil,
    image:"001Bulbasaur.png"
},
{
    name: "Squirtle",
    max_hp: 44,
    max_exp: 100,
    attack: 48,
    defence: 65,
    speed: 43,
    special: 50,
    element_1: "Water",
    element_2: nil,
    image: "007Squirtle.png"
},
{
    name: "Pidgey",
    max_hp: 40,
    max_exp: 100,
    attack: 45,
    defence: 40,
    speed: 56,
    special: 35,
    element_1: "Normal",
    element_2: nil,
    image: "016Pidgey.png"  
},
])

p "Created #{Pokedex.count} Pokedex"


Skill.destroy_all
Skill.create!([{
    name: "Fire Punch",
    element: "Fire",
    pp: 15,
    power: 18,
    level: 1,
},
{
    name: "Flamethrower",
    element: "Fire",
    pp: 15,
    power: 12,
    level: 1,
},
{
    name: "Fire Spin",
    element: "Fire",
    pp: 15,
    power: 15,
    level: 5,
},
{
    name: "Fire Blast",
    element: "Fire",
    pp: 5,
    power: 60,
    level: 5,
},
{
    name: "Flame Wheel",
    element: "Fire",
    pp: 25,
    power: 5,
    level: 10,
},
{
    name: "Sacred Fire",
    element: "Fire",
    pp: 5,
    power: 100,
    level: 15,
},

])

p "Created #{Skill.count} Skill"


InitiateSkill.destroy_all
InitiateSkill.create!([{
    pokedex_id: 1,
    skill_id: 1,
},
{
    pokedex_id: 1,
    skill_id: 2,
},
])

p "Created #{InitiateSkill.count} InitiateSkill"

# Battle.destroy_all

# Pokemon.destroy_all
