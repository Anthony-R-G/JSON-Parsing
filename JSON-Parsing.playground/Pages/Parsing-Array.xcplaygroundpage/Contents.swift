import Foundation

//Parsing JSON with an array top-level

let jsonData = """
[
    {
        "title": "New York",
        "location_type": "City",
        "woeid": 2459115,
        "latt_long": "40.71455,-74.007118"
    }
]
""".data(using: .utf8)!

//===========================================
//Create model(s)
//===========================================

//Top level JSON is an array

struct City: Decodable {
    let title: String
    
    //NOTE: Once property names changed using CodingKeys, they must both match
    let locationType: String
    //Prev: let location_type: String
    let woeid: Int
    
    let coordinate: String
    //Prev: let latt_long: let coordinate: String
    
    //Use this to make property names more Swift-y
    
    private enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case coordinate = "latt_long"
    }
}

//===========================================
//Decode the data to Swift model
//===========================================
do {
    let weatherArray = try JSONDecoder().decode([City].self, from: jsonData)
    dump(weatherArray)
} catch {
    print("Decoding error: \(error)")
}

/* Result:
 1 element
  ▿ __lldb_expr_12.City
    - title: "New York"
    - locationType: "City"
    - woeid: 2459115
    - coordinate: "40.71455,-74.007118"
 */
