//
//  CourseCell.swift
//  MVC_To_MVVM
//
//  Created by Abhishek Kumar on 09/12/21.
//

import Foundation
import UIKit

class CourseCell: UITableViewCell {
	
	var course: Course? {
		didSet {
			
			guard let course = self.course else {
				self.textLabel?.text = ""
				self.detailTextLabel?.text = ""
				self.accessoryType = .none
				self.backgroundColor = .red
				return
			}
			
			self.textLabel?.text = course.name
			if course.number_of_lessons > 35 {
				self.detailTextLabel?.text = "Lessons 30+ Check it Out!"
				self.accessoryType = .detailDisclosureButton
			} else {
				self.detailTextLabel?.text = "Lessons: \(course.number_of_lessons)"
				self.accessoryType = .none
			}
		}
	}
	
	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		contentView.backgroundColor = isHighlighted ? .highlightColor : .white
		textLabel?.textColor = isHighlighted ? UIColor.white : .mainTextBlue
		detailTextLabel?.textColor = isHighlighted ? .white : .black
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		
		// cell customization
		textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
		textLabel?.numberOfLines = 0
		detailTextLabel?.textColor = .black
		detailTextLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}
}
