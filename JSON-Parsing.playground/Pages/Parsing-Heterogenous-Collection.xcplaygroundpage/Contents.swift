import Foundation

//Parsing a JSON with a Heterogenous property. This means that a property is one type in one object, and another type in a different object. Example: A postal code could be given as an Int for one place, but a String for another.

let jsonData = """
{
  "results": [{
      "gender": "male",
      "name": {
        "title": "Mr",
        "first": "Asher",
        "last": "King"
      },
      "location": {
        "street": {
          "number": 6848,
          "name": "Madras Street"
        },
        "city": "Whanganui",
        "state": "Manawatu-Wanganui",
        "country": "New Zealand",
        "postcode": 83251,
        "coordinates": {
          "latitude": "64.3366",
          "longitude": "-140.5100"
        },
        "timezone": {
          "offset": "0:00",
          "description": "Western Europe Time, London, Lisbon, Casablanca"
        }
      },
      "email": "asher.king@example.com",
      "login": {
        "uuid": "157a7e5d-6023-40bc-8b72-d391c5a20e73",
        "username": "lazycat871",
        "password": "punkin",
        "salt": "xchlaTXG",
        "md5": "1de85cd9e9fb19e4932fa2d94397f9f7",
        "sha1": "695dbe4886625b61d766320f4c759d920bd03c06",
        "sha256": "7df1eb54d38a127e7f181590f802c8ee5a6c887b141b5e90ee981eee719b9f71"
      },
      "dob": {
        "date": "1955-07-04T19:24:43.057Z",
        "age": 65
      },
      "registered": {
        "date": "2012-04-01T10:07:09.601Z",
        "age": 8
      },
      "phone": "(736)-108-4205",
      "cell": "(736)-836-4316",
      "id": {
        "name": "",
        "value": null
      },
      "picture": {
        "large": "https://randomuser.me/api/portraits/men/6.jpg",
        "medium": "https://randomuser.me/api/portraits/med/men/6.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/6.jpg"
      },
      "nat": "NZ"
    },
    {
      "gender": "female",
      "name": {
        "title": "Ms",
        "first": "Madison",
        "last": "Williams"
      },
      "location": {
        "street": {
          "number": 64,
          "name": "Argyle St"
        },
        "city": "Kingston",
        "state": "Ontario",
        "country": "Canada",
        "postcode": "L7J 7K7",
        "coordinates": {
          "latitude": "-80.5612",
          "longitude": "2.7939"
        },
        "timezone": {
          "offset": "+4:00",
          "description": "Abu Dhabi, Muscat, Baku, Tbilisi"
        }
      },
      "email": "madison.williams@example.com",
      "login": {
        "uuid": "b5ad5a75-2a2c-4bfb-9028-a6ef95f85068",
        "username": "lazyostrich722",
        "password": "genesis1",
        "salt": "58Mw0Gvb",
        "md5": "af2a89591d1be11120ac0de395818eb7",
        "sha1": "63c2a6c7ddf7051a56c88ca767bc1579d88472fe",
        "sha256": "509e975c1f0ef8720b6990b6922e8c30a7f589e728b001bcd6092b4a6a55b234"
      },
      "dob": {
        "date": "1977-01-11T04:47:50.049Z",
        "age": 43
      },
      "registered": {
        "date": "2003-01-06T04:41:11.111Z",
        "age": 17
      },
      "phone": "326-431-8326",
      "cell": "042-933-3343",
      "id": {
        "name": "",
        "value": null
      },
      "picture": {
        "large": "https://randomuser.me/api/portraits/women/9.jpg",
        "medium": "https://randomuser.me/api/portraits/med/women/9.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/women/9.jpg"
      },
      "nat": "CA"
    }
  ]
}
""".data(using: .utf8)!


//===========================================
//Creating Model(s)
//===========================================

struct Results: Decodable {
    let results: [User]
    
}

struct User: Decodable {
    let gender: String
    let name: Name
    let location: Location
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Location: Decodable {
    let street: Street
    let postcode: Postcode
}

struct Street: Decodable {
    let number: Int
    let name: String
}

//===========================================
// Handling the heterogenous property
//===========================================
enum DecodingError: Error {
  case missingValue
}

enum Postcode: Decodable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        if let intVal = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(intVal)
            return
        }
        
        if let stringVal = try? decoder.singleValueContainer().decode(String.self){
            self = .string(stringVal)
            return
        }
        throw DecodingError.missingValue
    }
}

//===========================================
//Decode the JSON data to our Swift model
//===========================================

do {
    let results = try JSONDecoder().decode(Results.self, from: jsonData)
    dump(results.results)
} catch {
    print("Decoding error: \(error)")
}
