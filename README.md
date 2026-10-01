# Course App — SwiftUI

## 1. Architecture

I used **SwiftUI + MVVM with a Repository layer**.

* **Views** handle UI and user interaction.
* **ViewModels** manage UI state and business logic.
* **Repository** abstracts data access from the ViewModels.
* **API Service** handles network communication.
* **Local Cache** stores previously loaded course data.

This keeps responsibilities separated, makes the code easier to test and maintain, and allows the data source to be changed without affecting the UI.

---

## 2. Offline Support

Course data is cached locally after a successful API response.

For this assignment, I use **UserDefaults with Codable/JSON** as a simple local cache.

When courses are requested:

1. Try to fetch data from the API.
2. Save the successful response to local cache.
3. If the API fails, load the previously cached courses.
4. Display the cached courses when available.

For a production application with larger datasets, I would use **SwiftData/Core Data** or another persistent database.

---

## 3. Security

In a production application, authentication tokens should be stored securely in the **iOS Keychain**, not in `UserDefaults` or plain files.

Sensitive communication should use **HTTPS/TLS**. Tokens should also have appropriate expiration and refresh mechanisms.

---

## 4. Scale

For an application with **1 million users and hundreds of courses**, I would improve:

1. **Backend/API scalability** — use stateless APIs, load balancing, caching and horizontal scaling.
2. **Database** — use proper indexing, pagination and optimized queries rather than loading all courses at once.
3. **Client-side performance** — implement pagination/lazy loading and efficient image/data caching.
4. **Offline synchronization** — introduce a more robust local database and synchronization/conflict-handling strategy.
5. **Monitoring and reliability** — add logging, crash reporting, API monitoring and retry/rate-limit handling.

---

## 5. Second Platform

Since this application is implemented using SwiftUI for iOS, for a second platform I would consider Flutter to support both Android and iOS with a shared codebase.
