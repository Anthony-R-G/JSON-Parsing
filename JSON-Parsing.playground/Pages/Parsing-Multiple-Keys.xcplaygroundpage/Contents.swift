import Foundation

//Parsing JSON with multiple keys

let json = """
{
    "Afpak": {
        "id": 1,
        "race": "hybrid",
        "flavors": [
            "Earthy",
            "Chemical",
            "Pine"
        ],
        "effects": {
            "positive": [
                "Relaxed",
                "Hungry",
                "Happy",
                "Sleepy"
            ],
            "negative": [
                "Dizzy"
            ],
            "medical": [
                "Depression",
                "Insomnia",
                "Pain",
                "Stress",
                "Lack of Appetite"
            ]
        }
    },
    "African": {
        "id": 2,
        "race": "sativa",
        "flavors": [
            "Spicy/Herbal",
            "Pungent",
            "Earthy"
        ],
        "effects": {
            "positive": [
                "Euphoric",
                "Happy",
                "Creative",
                "Energetic",
                "Talkative"
            ],
            "negative": [
                "Dry Mouth"
            ],
            "medical": [
                "Depression",
                "Pain",
                "Stress",
                "Lack of Appetite",
                "Nausea",
                "Headache"
            ]
        }
    },
    "Afternoon Delight": {
        "id": 3,
        "race": "hybrid",
        "flavors": [
            "Pepper",
            "Flowery",
            "Pine"
        ],
        "effects": {
            "positive": [
                "Relaxed",
                "Hungry",
                "Euphoric",
                "Uplifted",
                "Tingly"
            ],
            "negative": [
                "Dizzy",
                "Dry Mouth",
                "Paranoid"
            ],
            "medical": [
                "Depression",
                "Insomnia",
                "Pain",
                "Stress",
                "Cramps",
                "Headache"
            ]
        }
    }
}
""".data(using: .utf8)!

//NOTE: Each key has a different name. You can't simply call it something like "Results: [Strain]"

//===========================================
//Create Model(s)
//===========================================

struct Strain: Decodable {
    let id: Int
    let race: String
    let flavors: [String]
    let effects: [String:  [String]] // <- Can make this its own model
}

do {
    let dictionary = try JSONDecoder().decode([String: Strain].self, from: json)
    //Use a for-loop to create [Strain] or use map {}
    var strains: [Strain] = []
    for (_, val) in dictionary {
        let strain = Strain(id: val.id, race: val.race, flavors: val.flavors, effects: val.effects)
        strains.append(strain)
    }
    
    /*
     Alternative Method 1:
     for strainData in dictionary.values {
        strains.append(strainData)
     
     Alternative Method 2:
     strains = dictionary.map({$0.value})
     */
    dump(strains)
} catch {
    print("Decoding error: \(error)")
}
