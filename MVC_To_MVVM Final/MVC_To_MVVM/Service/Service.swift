//
//  Service.swift
//  MVC_To_MVVM
//
//  Created by Abhishek Kumar on 09/12/21.
//

import Combine
import Foundation

enum ServiceError: Error {
	case NoCoursesFound
	case SomeOtherError
}

class Service: NSObject {
	static let shared = Service()
	
	func fetchCourses() -> Future<[Course], ServiceError> {
		let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
		guard let url = URL(string: urlString) else {
			return Future { promixe in
				promixe(.failure(.SomeOtherError))
			}
		}
		
		return Future { promixe in
			
			URLSession.shared.dataTask(with: url) { data, response, error in
				
				if let _ = error {
					DispatchQueue.main.async {
						promixe(.failure(.SomeOtherError))
					}
				}
				
				guard let data = data else {
					DispatchQueue.main.async {
						promixe(.failure(.NoCoursesFound))
					}
					return
				}
				
				do {
					let courses = try JSONDecoder().decode([Course].self, from: data)
					DispatchQueue.main.async {
						promixe(.success(courses))
					}
				} catch let jsonError {
					debugPrint("Decoding failed: \(jsonError)")
					DispatchQueue.main.async {
						promixe(.failure(.SomeOtherError))
					}
				}
			}.resume()
			
		}
	}
}
