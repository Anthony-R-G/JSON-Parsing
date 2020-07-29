import Foundation

//Parsing JSON with a dictionary top-level

let jsonData = """
{
 "results": [
   {
     "firstName": "John",
     "lastName": "Appleseed"
   },
  {
    "firstName": "Anthony",
    "lastName": "Gonzalez"
  }
 ]
}
""".data(using: .utf8)! // <- Character encoder

//===========================================
//Create Model(s)
//===========================================

//Codable: Decodable & Codable
//Decodable: Converts JSON data
//Encodable: Converts to JSON data (ex: to POST to a web API)

//Top Level JSON is a Dictionary
struct ResultsWrapper: Decodable {
    let results: [Contact]
}

struct Contact: Decodable {
    let firstName: String
    let lastName: String
}

//===========================================
//Decode the JSON data to our Swift model
//===========================================

do {
    let dictionary = try JSONDecoder().decode(ResultsWrapper.self, from: jsonData)
    let contacts = dictionary.results
    dump(contacts)
} catch {
    print("Decoding error: \(error)")
}

/* Result:
 ▿ 2 elements
 ▿ __lldb_expr_3.Contact
   - firstName: "John"
   - lastName: "Appleseed"
 ▿ __lldb_expr_3.Contact
   - firstName: "Anthony"
   - lastName: "Gonzalez"
 */


