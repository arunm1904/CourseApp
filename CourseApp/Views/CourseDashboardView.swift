//
//  Untitled.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import SwiftUI

struct CourseDashboardView: View {

    @StateObject private var viewModel =
        CourseDashboardViewModel()

    var body: some View {

        NavigationStack {

            Group {

                switch viewModel.state {

                case .idle, .loading:

                    ProgressView("Loading courses...")

                case .success:

                    courseList

                case .empty:

                    ContentUnavailableView(
                        "No Courses",
                        systemImage: "book.closed",
                        description: Text(
                            "No courses are currently available."
                        )
                    )

                case .failure(let message):

                    VStack(spacing: 16) {

                        Image(systemName: "wifi.slash")
                            .font(.largeTitle)

                        Text(message)
                            .multilineTextAlignment(.center)

                        Button("Retry") {

                            Task {
                                await viewModel.loadCourses()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .navigationTitle("Courses")
            .task {
                await viewModel.loadCourses()
            }
        }
    }

    private var courseList: some View {

        List(viewModel.courses) { course in

            NavigationLink {

                CourseDetailsView(course: course)

            } label: {

                CourseRow(course: course)
            }
        }
    }
}
