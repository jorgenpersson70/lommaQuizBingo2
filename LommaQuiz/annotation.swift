//
//  LommaQuiz
//
//  Created by jörgen persson on 2021-12-20.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import Firebase

class AnnotationPin:  NSObject, MKAnnotation {
let coordinate: CLLocationCoordinate2D
let title: String?
let subtitle: String?
let image: UIImage?

    
init(title:String, subtitle: String, image: UIImage, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    self.image = image
    super.init()
 }}
