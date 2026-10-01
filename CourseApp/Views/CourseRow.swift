//
//  Untitled.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import SwiftUI

struct CourseRow: View {

    let course: Course

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(course.title)
                .font(.headline)

            Text("Instructor: \(course.instructor)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            ProgressView(
                value: Double(course.progress),
                total: 100
            )

            HStack {

                Text("\(course.progress)% complete")

                Spacer()

                Text("\(course.lessons) lessons")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)

            HStack {

                Spacer()

                Text("Continue")
                    .font(.subheadline)
                    .fontWeight(.medium)

                Image(systemName: "arrow.right")

            }
        }
        .padding(.vertical, 8)
    }
}
