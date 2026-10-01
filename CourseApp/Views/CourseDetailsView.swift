//
//  Untitled.swift
//  CourseApp
//
//  Created by Arun on 30/09/26.
//

import SwiftUI

struct CourseDetailsView: View {

    @StateObject private var viewModel: CourseDetailsViewModel

    init(course: Course) {

        _viewModel = StateObject(
            wrappedValue:
                CourseDetailsViewModel(course: course)
        )
    }

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                Text(viewModel.course.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(
                    "Instructor: \(viewModel.course.instructor)"
                )
                .foregroundStyle(.secondary)

                progressSection

                Divider()

                Text("Lessons")
                    .font(.title2)
                    .fontWeight(.bold)

                if viewModel.isLoading {

                    ProgressView("Loading lessons...")

                } else if let error =
                            viewModel.errorMessage {

                    Text(error)
                        .foregroundStyle(.red)

                } else {

                    lessonsList
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadLessons()
        }
    }

    private var progressSection: some View {

        VStack(alignment: .leading, spacing: 8) {

            HStack {

                Text("Current Progress")
                    .fontWeight(.medium)

                Spacer()

                Text("\(viewModel.progress)%")
                    .fontWeight(.bold)
            }

            ProgressView(
                value: Double(viewModel.progress),
                total: 100
            )
        }
    }

    private var lessonsList: some View {

        VStack(spacing: 0) {

            ForEach(viewModel.lessons) { lesson in

                Button {

                    viewModel.toggleLesson(lesson)

                } label: {

                    HStack {

                        Image(
                            systemName:
                                lesson.isCompleted
                                ? "checkmark.circle.fill"
                                : "circle"
                        )

                        Text(lesson.title)

                        Spacer()

                        Text(
                            lesson.isCompleted
                            ? "Completed"
                            : "Pending"
                        )
                        .font(.caption)
                        .foregroundStyle(
                            lesson.isCompleted
                            ? .green
                            : .secondary
                        )
                    }
                    .contentShape(Rectangle())
                    .padding(.vertical, 14)
                }
                .buttonStyle(.plain)

                Divider()
            }
        }
    }
}
