### **README.md** - *Developer Guide for Emotional Health Tracker*

---

# **Emotional Health Tracker**
### *A SwiftUI-based iOS app for tracking emotional well-being with AI-powered analysis and music recommendations.*

---

## **📌 Overview**
The **Emotional Health Tracker** is an iOS application designed to help users monitor their emotional health by logging journal entries, analyzing emotions using **Hume AI**, and recommending mood-based music. Built with **SwiftUI** and **Supabase**, the app follows an **MVVM architecture** for scalability and maintainability.

---

## **📂 File System Overview**
```
EmotionalHealthTracker/
│── EmotionalHealthTrackerApp.swift  # Entry point of the app
│── Assets.xcassets                   # Images, icons, and color assets
│── Info.plist                         # App metadata
│── Models/                            # Data models
│   ├── JournalEntry.swift
│   ├── EmotionAnalysis.swift
│── Views/                             # SwiftUI views
│   ├── HomeView.swift
│   ├── JournalEntryView.swift
│   ├── EmotionAnalysisView.swift
│   ├── ProfileView.swift
│── ViewModels/                        # Business logic (MVVM architecture)
│   ├── JournalViewModel.swift
│   ├── EmotionAnalysisViewModel.swift
│── Services/                          # API integrations
│   ├── HumeAIService.swift            # Emotion detection API
│   ├── MusicRecommendationService.swift # Music API
│── Utils/                             # Helper functions
│   ├── DateFormatter.swift
│── Extensions/                        # SwiftUI or Foundation extensions
│── Resources/                         # Static JSON files, mock data (optional)
│── Package.swift                      # Dependencies (if using Swift Package Manager)
│── README.md                          # Project documentation
│── .gitignore                         # Ignored files in version control
```

---

## **🛠 Tech Stack**
- **Programming Language:** Swift (SwiftUI)
- **Architecture:** MVVM (Model-View-ViewModel)
- **Backend:** Supabase (Authentication, Database)
- **APIs:** 
  - **Hume AI** (Emotion Analysis)
  - **Music API** (Spotify or Apple Music for song recommendations)
- **Third-Party Libraries:**
  - `Supabase-Swift` (for authentication & data storage)
  - `SwiftUI Charts` (for data visualization)

---

## **📡 API Integrations**
### **1️⃣ Hume AI (Emotion Analysis)**
**📍 File:** `Services/HumeAIService.swift`

#### **Setup**
1. **Sign up for Hume AI API** at [Hume AI](https://www.hume.ai).
2. **Get API Key** from the dashboard.
3. **Store API Key securely** (never hardcode in the app, use environment variables).

#### **Example API Request**
```swift
import Foundation

class HumeAIService {
    private let apiKey = "YOUR_HUME_AI_API_KEY"
    
    func analyzeEmotion(fromText text: String, completion: @escaping (EmotionAnalysis?) -> Void) {
        let url = URL(string: "https://api.hume.ai/analyze")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let body = ["text": text]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching emotion data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            let decodedResponse = try? JSONDecoder().decode(EmotionAnalysis.self, from: data)
            DispatchQueue.main.async {
                completion(decodedResponse)
            }
        }.resume()
    }
}
```

---

### **2️⃣ Supabase (Authentication & Database)**
**📍 Files:**
- `ViewModels/SignInViewModel.swift`
- `ViewModels/SignUpViewModel.swift`

#### **Setup**
1. **Create a Supabase project** at [Supabase](https://supabase.com).
2. **Copy Project URL & API Key**.
3. **Modify your `SupabaseClient` instance:**
```swift
private let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://your-supabase-url.supabase.co")!,
    supabaseKey: "your-supabase-anon-key"
)
```

#### **User Authentication**
```swift
func signIn(email: String, password: String) async {
    do {
        let session = try await supabase.auth.signIn(email: email, password: password)
        print("User signed in: \(session)")
    } catch {
        print("Sign in error: \(error.localizedDescription)")
    }
}
```

---

### **3️⃣ Music API (Spotify or Apple Music)**
**📍 File:** `Services/MusicRecommendationService.swift`

#### **Setup**
- **Spotify API**: [Spotify Developer Portal](https://developer.spotify.com/)
- **Apple Music API**: [Apple Music API Docs](https://developer.apple.com/documentation/applemusicapi/)

#### **Example Spotify API Request**
```swift
import Foundation

class MusicRecommendationService {
    private let apiKey = "YOUR_SPOTIFY_API_KEY"
    
    func fetchRecommendedSongs(forMood mood: String, completion: @escaping ([String]) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/recommendations?seed_genres=\(mood)")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching music recommendations")
                completion([])
                return
            }
            let decodedResponse = try? JSONDecoder().decode([String].self, from: data)
            DispatchQueue.main.async {
                completion(decodedResponse ?? [])
            }
        }.resume()
    }
}
```

---

## **🛣 Next Steps**
### **1️⃣ Authentication & User Management**
- [ ] ✅ **Sign-In Page (Done)**
- [ ] 🔲 **Sign-Up Page**
- [ ] 🔲 **OAuth for Apple & Google**
- [ ] 🔲 **Password Reset UI & Logic**
- [ ] 🔲 **Profile Page for Users**

### **2️⃣ Core Features**
- [ ] 🔲 **Emotion Journal Logging (Text & Audio)**
- [ ] 🔲 **Connect Hume AI for Sentiment Analysis**
- [ ] 🔲 **Generate Weekly Mood Reports**
- [ ] 🔲 **Graphical Visualization of Emotional Trends**

### **3️⃣ Additional Features**
- [ ] 🔲 **Music API Integration for Mood-Based Songs**
- [ ] 🔲 **Notifications & Reminders for Daily Logs**
- [ ] 🔲 **Secure Storage & Data Privacy Implementation**

### **4️⃣ UI Enhancements**
- [ ] 🔲 **Animations for Transitions & Screen Changes**
- [ ] 🔲 **Dark Mode Optimization**
- [ ] 🔲 **Custom Loading Indicators & UI Feedback**

### **5️⃣ Deployment & Testing**
- [ ] 🔲 **Unit Tests for ViewModels**
- [ ] 🔲 **App Store Submission Process**
- [ ] 🔲 **Performance Optimization & Code Cleanup**

---

## **👨‍💻 Developer Notes**
### **1️⃣ Coding Standards**
- Follow **MVVM architecture** for better separation of concerns.
- Use `async/await` for API calls instead of completion handlers.
- Keep **UI logic in Views** and **business logic in ViewModels**.

### **2️⃣ API Keys & Security**
- **Never commit API keys** to version control (`.gitignore` them).
- Use **environment variables or a secrets manager** to store sensitive data.

### **3️⃣ Contribution Guidelines**
- Branching: Use `feature/your-feature-name`
- Commit Messages: Use meaningful commit messages (e.g., `feat: add emotion analysis API`)
- PR Reviews: Code must be reviewed before merging into `main`

---

## **📩 Contact & Support**
For any issues or questions, contact **Abraham Belayneh** or open an issue in the GitHub repository.

🚀 *Happy coding & improving mental health!* 🌿
