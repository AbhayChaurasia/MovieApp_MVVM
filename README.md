
---

## 🧪 Unit Testing

Tests are written using **XCTest**, including:

- ✅ `SearchMovieViewModelTests`
- ✅ `MovieDetailsViewModelTests`
- ✅ `FavoriteListViewModelTests`
- ✅ ViewController tests for all 3 screens
- ✅ Mock service (`MockMovieSearchService`) to simulate API responses
- ⚠️ Core Data unit tests pending (can use in-memory stack)

---

## 🧰 Technologies Used

- Swift 5
- UIKit
- Combine
- Core Data
- SDWebImage
- MVVM + Coordinator Pattern
- XCTest (for unit testing)

---

## 🧪 How to Run

1. Clone the repo  
2. Open `MovieAppMVVM.xcodeproj`
3. Run the project on Simulator
4. You can search for movies using the search field
5. Tap any movie to view details and mark as favorite
6. Tap “Favorite Movie” from the navigation bar to view saved favorites

---

## 🧱 Requirements

- iOS 13.0+
- Xcode 15+
- Swift 5

---

## 📦 Dependencies

Installed using Swift Package Manager:

- [SDWebImage](https://github.com/SDWebImage/SDWebImage)

---

## 📌 Notes

- API Key for TMDb is already configured in `AppDelegate` via `APIConfiguration`
- All movie posters are fetched from TMDb image base URL
- SDWebImage is used for async image loading
- The app follows clean architecture and separates concerns

---

## 🧑‍💻 Author

Abhay Chaurasia

---


