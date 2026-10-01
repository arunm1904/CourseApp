//
//  Untitled.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import Foundation

final class LocalCacheService {

    private let coursesKey = "cached_courses"

    func saveCourses(_ courses: [Course]) {

        do {
            let data = try JSONEncoder().encode(courses)
            UserDefaults.standard.set(data, forKey: coursesKey)
            print("App container:", NSHomeDirectory())
        } catch {
            print("Cache save failed:", error)
        }
    }

    func getCourses() -> [Course]? {

        guard let data =
                UserDefaults.standard.data(forKey: coursesKey)
        else {
            return nil
        }

        do {
            return try JSONDecoder().decode(
                [Course].self,
                from: data
            )
        } catch {
            print("Cache read failed:", error)
            return nil
        }
    }
}
