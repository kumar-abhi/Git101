//
//  Course.swift
//  MVC_To_MVVM
//
//  Created by Abhishek Kumar on 09/12/21.
//

import Foundation

struct Course: Decodable {
	let id: Int
	let name: String
	let number_of_lessons: Int
	
	private enum CodingKeys: String, CodingKey {
		case id
		case name
		case number_of_lessons = "numberOfLessons"
	}
}
