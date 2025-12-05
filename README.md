# 📝 Notes Manager - iOS Application

A fully functional iOS notes management application built with SwiftUI and Firebase, featuring real-time data synchronization, image display, and CRUD operations.

![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=for-the-badge&logo=swift&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)

## 📋 Table of Contents
- [About the Project](#about-the-project)
- [Key Features](#key-features)
- [Technologies Used](#technologies-used)
- [Architecture](#architecture)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [API Documentation](#api-documentation)
- [Firebase Integration](#firebase-integration)
- [Screenshots](#screenshots)
- [What I Learned](#what-i-learned)
- [Academic Context](#academic-context)
- [Author](#author)

## 📖 About the Project

**Notes Manager** is a native iOS application developed as the final project for the iOS Mobile Development 1 course at LaSalle College. The app demonstrates proficiency in modern iOS development practices, including SwiftUI, Firebase integration, RESTful API consumption, and data persistence strategies.

The application allows users to view, edit, and delete notes fetched from a remote API, with all data synchronized to Firebase Firestore for real-time updates and offline persistence.

### Project Objectives
- Demonstrate competency in iOS application development
- Integrate Firebase services for cloud data storage
- Implement RESTful API consumption
- Create intuitive user interfaces with SwiftUI
- Apply CRUD operations with Firebase Firestore
- Implement proper navigation and state management

### Course Competency
This project evaluates the competency: **"Develop applications for connected objects"** (00SX) with focus on:
- Analyzing application development requirements
- Generating and programming user interfaces
- Programming application logic and control mechanisms
- Implementing data exchange services

## ✨ Key Features

### 📱 Core Functionality
- **Notes List Display**: View all notes with titles and images in a scrollable list
- **Image Handling**: Remote image loading using SDWebImage for efficient caching
- **Swipe to Delete**: Intuitive gesture-based note deletion
- **Edit Notes**: Tap any note to open an edit sheet with pre-filled data
- **Real-time Sync**: Automatic Firebase Firestore synchronization
- **First Launch Setup**: Automatic data fetching and Firebase upload on first app launch

### 🔥 Firebase Integration
- **Firestore Database**: Cloud-based NoSQL database for note storage
- **Real-time Updates**: Instant data synchronization across devices
- **CRUD Operations**: Complete Create, Read, Update, Delete functionality
- **Auto-fetch on Init**: Automatic data loading when app launches
- **Document ID Management**: Proper Firebase document reference handling

### 🌐 API Integration
- **RESTful API Consumption**: Fetch notes from external API endpoint
- **Data Parsing**: JSON decoding with Codable protocol
- **Network Layer**: Structured web service architecture
- **Error Handling**: Robust error management for network operations

### 🎨 User Interface
- **SwiftUI Framework**: Modern declarative UI development
- **Navigation View**: Clean navigation structure
- **Sheet Presentations**: Modal editing interface
- **Form Validation**: Input validation for note titles
- **Responsive Design**: Adapts to different iOS device sizes

### 💾 Data Persistence
- **UserDefaults**: Flag for first-launch detection
- **Firebase Firestore**: Primary data storage solution
- **Offline Capability**: Data accessible even without network connection
- **State Management**: Environment objects for app-wide state

## 🛠️ Technologies Used

### iOS Development
- **Language**: Swift 5.x
- **UI Framework**: SwiftUI
- **IDE**: Xcode 14+
- **Minimum iOS Version**: iOS 15.0+
- **Package Manager**: Swift Package Manager (SPM)

### Backend & Services
- **Firebase Services**:
  - Firebase Firestore (Database)
  - Firebase Core
- **Image Loading**: SDWebImageSwiftUI
- **REST API**: Custom API endpoint for data fetching

### Networking
- **URLSession**: Native iOS networking
- **Codable**: Swift's built-in JSON encoding/decoding
- **Async/Await**: Modern Swift concurrency

### State Management
- **@ObservedObject**: For Firebase manager observation
- **@State**: Local view state management
- **@EnvironmentObject**: App-wide state sharing (optional implementation)
- **UserDefaults**: Simple key-value storage

## 🏗️ Architecture

### Design Pattern
The application follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Model**: Data structures representing notes
- **View**: SwiftUI views for UI presentation
- **ViewModel**: Firebase manager acting as data source and business logic handler

### Data Flow
```
API → Web Service → Model → Firebase → Firebase Manager → SwiftUI Views
       ↓                                      ↓
   First Launch                         Real-time Updates
```

### Component Structure
```
App Entry Point
    ↓
NavigationView (Main Structure)
    ↓
Notes List View (First Screen)
    ├── List of Notes (API Data → Firebase)
    ├── Swipe to Delete (Firebase deletion)
    └── Edit Sheet (Firebase update)
        ↓
Firebase Manager (Observable Object)
    ├── Fetch Notes
    ├── Update Note
    ├── Delete Note
    └── Auto-fetch on Init
```

## 📂 Project Structure

```
NotesManagerApp/
├── NotesManagerApp.swift              # App entry point
├── Models/
│   └── Note.swift                     # Note data model with Firebase support
├── Views/
│   ├── ContentView.swift             # Main navigation structure
│   ├── NotesListView.swift           # Notes list display
│   └── EditNoteView.swift            # Edit note sheet
├── Services/
│   ├── WebService.swift              # API networking layer
│   └── FirebaseManager.swift        # Firebase operations manager
├── Utils/
│   └── Constants.swift               # App constants and configurations
├── Resources/
│   ├── GoogleService-Info.plist     # Firebase configuration
│   └── Assets.xcassets              # App images and colors
└── Info.plist                        # App configuration
```

## 🚀 Installation

### Prerequisites
- macOS with Xcode 14.0 or later
- Active Apple Developer account (for device testing)
- Firebase account
- CocoaPods or Swift Package Manager
- Internet connection for API and Firebase access

### Step-by-Step Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/250evelyne/ios-notes-manager.git
cd ios-notes-manager
```

#### 2. Set Up Firebase

**Create Firebase Project:**
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add Project"**
3. Follow the setup wizard
4. Add an iOS app to your project

**Download Configuration:**
1. Register your app bundle identifier
2. Download `GoogleService-Info.plist`
3. Add it to your Xcode project (drag into project navigator)
4. Ensure it's included in the app target

**Configure Firestore:**
1. In Firebase Console, go to **Firestore Database**
2. Click **"Create Database"**
3. Start in **Test Mode** (for development)
4. Choose your preferred location
5. Your database is ready!

#### 3. Install Dependencies

**Using Swift Package Manager (Recommended):**

1. Open the project in Xcode
2. Go to **File → Add Packages**
3. Add the following packages:

**Firebase:**
```
https://github.com/firebase/firebase-ios-sdk
```
Select these products:
- FirebaseFirestore
- FirebaseFirestoreSwift

**SDWebImageSwiftUI:**
```
https://github.com/SDWebImage/SDWebImageSwiftUI
```

4. Click **Add Package**
5. Wait for packages to resolve

#### 4. Configure the Project

**Update Bundle Identifier:**
1. Select project in navigator
2. Go to **Signing & Capabilities**
3. Change bundle identifier to match Firebase registration

**Verify Firebase Setup:**
```swift
// In your App file, ensure Firebase is configured
import Firebase

@main
struct NotesManagerApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

#### 5. Build and Run

1. Select a simulator or connected device
2. Press **Cmd + R** or click the **Play** button
3. The app will build and launch
4. On first launch, notes will be fetched from API and uploaded to Firebase

### Test the Setup

1. **Verify API Connection**: Check console logs for successful API fetch
2. **Check Firebase**: Open Firebase Console → Firestore to see "tasks" collection
3. **Test CRUD Operations**:
   - Swipe to delete a note
   - Tap a note to edit
   - Verify changes appear in Firebase Console

## 📡 API Documentation

### Base URL
```
https://api.jerryjoy.me
```

### Endpoint: Get Notes

**GET** `/notes`

Fetches the list of notes from the remote server.

**Request:**
```http
GET /notes HTTP/1.1
Host: api.jerryjoy.me
```

**Response (200 OK):**
```json
[
  {
    "nid": 1,
    "title": "Sample Note Title",
    "image": "https://example.com/image.jpg"
  },
  {
    "nid": 2,
    "title": "Another Note",
    "image": "https://example.com/image2.jpg"
  }
]
```

**Response Fields:**
| Field | Type | Description |
|-------|------|-------------|
| `nid` | Int | Unique note identifier |
| `title` | String | Note title/content |
| `image` | String | URL to note image |

**Usage in App:**
- Called **only once** on first app launch
- Data stored in Firebase for subsequent uses
- Checked via UserDefaults flag

**Test with Postman:**
1. Create a new GET request
2. Enter URL: `https://api.jerryjoy.me/notes`
3. Send request
4. Verify status code 200
5. Check response matches JSON structure above

## 🔥 Firebase Integration

### Firestore Database Structure

**Collection: `tasks`**

Each document contains:
```json
{
  "id": "auto-generated-firebase-id",
  "nid": 1,
  "title": "Note Title",
  "image": "https://example.com/image.jpg"
}
```

### Data Model

```swift
import FirebaseFirestore

struct Note: Identifiable, Codable {
    @DocumentID var id: String?  // Firebase auto-generated ID
    var nid: Int                 // Original API note ID
    var title: String            // Note title/content
    var image: String            // Image URL
}
```

### Firebase Manager

**ObservableObject** class managing all Firebase operations:

```swift
class FirebaseManager: ObservableObject {
    @Published var notes: [Note] = []
    private let db = Firestore.firestore()
    
    init() {
        fetchNotes()  // Auto-fetch on initialization
    }
    
    // 1. Fetch all notes from Firestore
    func fetchNotes() { ... }
    
    // 2. Update a note (title only)
    func updateNote(note: Note) { ... }
    
    // 3. Delete a note by ID
    func deleteNote(id: String) { ... }
    
    // 4. Upload API data to Firebase (first launch)
    func uploadNotes(notes: [Note]) { ... }
}
```

### Key Firebase Operations

#### Fetch Notes
```swift
func fetchNotes() {
    db.collection("tasks").addSnapshotListener { snapshot, error in
        guard let documents = snapshot?.documents else { return }
        self.notes = documents.compactMap { doc in
            try? doc.data(as: Note.self)
        }
    }
}
```

#### Update Note
```swift
func updateNote(note: Note) {
    guard let id = note.id else { return }
    do {
        try db.collection("tasks").document(id).setData(from: note)
    } catch {
        print("Error updating note: \(error)")
    }
}
```

#### Delete Note
```swift
func deleteNote(id: String) {
    db.collection("tasks").document(id).delete { error in
        if let error = error {
            print("Error deleting: \(error)")
        }
    }
}
```

### Security Rules (Firebase Console)

For development (adjust for production):
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{document=**} {
      allow read, write: if true;
    }
  }
}
```

## 🎨 User Interface Components

### Main Navigation Structure
```swift
NavigationView {
    NotesListView()
        .navigationTitle("Notes")
}
```

### Notes List View
- **List**: Displays all notes from Firebase
- **ForEach**: Iterates through notes array
- **AsyncImage/SDWebImage**: Loads remote images
- **Swipe Actions**: Delete functionality
- **Sheet**: Edit interface presentation

### Edit Sheet
- **Form**: Input fields for editing
- **TextField**: Title editing with validation
- **Image Display**: Shows current note image
- **Submit Button**: Saves changes to Firebase
- **Validation**: Ensures title is not empty

## 📸 Screenshots

*(Add screenshots of your application here)*

**Suggested Screenshots:**
1. **Notes List View**: Main screen showing all notes with images
2. **Swipe to Delete**: Demonstration of swipe gesture
3. **Edit Sheet**: Modal view for editing note title
4. **Firebase Console**: Firestore collection with data
5. **API Response**: Postman showing successful API call

## 🎓 What I Learned

Through this project, I developed comprehensive skills in:

### iOS Development
- **SwiftUI Framework**: Building declarative user interfaces
- **Navigation**: Implementing NavigationView and navigation patterns
- **State Management**: Using @State, @ObservedObject, and @Published
- **Sheet Presentations**: Modal view presentations and dismissal
- **Gesture Handling**: Swipe actions and touch interactions
- **Form Validation**: Input validation and error handling

### Firebase Integration
- **Firestore Setup**: Configuring Firebase in iOS projects
- **CRUD Operations**: Complete database operation implementation
- **Real-time Listeners**: Setting up snapshot listeners for live data
- **Document Management**: Working with Firebase document IDs
- **Data Modeling**: Using @DocumentID for Firebase integration
- **Error Handling**: Managing Firebase operation errors

### Networking
- **RESTful APIs**: Consuming external API endpoints
- **URLSession**: Native iOS networking implementation
- **Async/Await**: Modern Swift concurrency patterns
- **JSON Parsing**: Codable protocol for data serialization
- **Error Handling**: Network error management
- **API Testing**: Using Postman for endpoint verification

### Architecture & Patterns
- **MVVM Pattern**: Separating concerns in app architecture
- **Observable Objects**: Creating reactive data sources
- **Dependency Injection**: Passing managers to views
- **Service Layer**: Structuring network and database services
- **Data Persistence**: UserDefaults for simple storage needs

### Problem Solving
- **First Launch Logic**: Implementing one-time data fetch
- **Data Synchronization**: Keeping UI in sync with Firebase
- **Image Loading**: Efficient remote image handling with SDWebImage
- **User Experience**: Creating intuitive interaction patterns
- **Debugging**: Using Xcode debugging tools and console logging

## 📚 Academic Context

### Course Information
- **Course**: iOS Mobile Development 1
- **Course Code**: 420-DM5-AS
- **Program**: Computer Science Technology - Programming (420.BP)
- **Institution**: LaSalle College, Montréal
- **Semester**: Fall 2025
- **Instructor**: Jerry Joy
- **Duration**: 150 minutes (3 periods)

### Competency Evaluated
**Standard**: Develop applications for connected objects (00SX)

**Elements Evaluated:**
1. Analyze the application development project (00SX.1)
2. Generate or program the user interface (00SX.3)
3. Program the application logic and control mechanisms (00SX.4)

### Performance Criteria Met
- ✅ Correct analysis of design documents
- ✅ Proper determination of tasks to be carried out
- ✅ Appropriate choice and use of graphic elements
- ✅ Proper programming of data gathering and transmission
- ✅ Proper programming of interface interactions
- ✅ Appropriate use of data exchange services
- ✅ Proper transfer of application onto connected object

### Evaluation Breakdown
| Section | Points | Description |
|---------|--------|-------------|
| A - Project Setup | 15 | Firebase integration and configuration |
| B - Navigation Structure | 15 | NavigationView implementation |
| C - First Screen | 30 | API fetch, list display, Firebase upload |
| D - Firebase Manager | 20 | CRUD operations implementation |
| E - List Screen Features | 20 | Swipe to delete, edit functionality |
| **Total** | **100** | |

### Academic Integrity Declaration
✅ This is an original work
✅ All content sources are properly credited
✅ No AI tools (ChatGPT, etc.) were used as per course policy
✅ Work completed within examination time constraints

## 🔮 Future Enhancements

While this project was completed as an exam with specific requirements, potential improvements include:

### Functionality
- [ ] Add new notes functionality
- [ ] Search and filter notes
- [ ] Category/tag system for organization
- [ ] Note sharing capabilities
- [ ] Rich text editing
- [ ] Offline mode with sync queue
- [ ] Image upload from device
- [ ] Note favorites/pinning

### Technical Improvements
- [ ] Unit tests for Firebase manager
- [ ] UI tests for user flows
- [ ] Error handling improvements
- [ ] Loading states and indicators
- [ ] Pull-to-refresh functionality
- [ ] Pagination for large datasets
- [ ] Image caching optimization
- [ ] Dark mode support

### User Experience
- [ ] Animations and transitions
- [ ] Haptic feedback
- [ ] Accessibility improvements
- [ ] Localization support
- [ ] Onboarding tutorial
- [ ] Settings and preferences

## 🐛 Known Limitations

- **First Launch Only**: API fetch occurs only on first launch (as per requirement)
- **Title-Only Editing**: Only note titles can be updated, not images
- **No Image Upload**: Images come from API only, no user upload
- **Basic Validation**: Minimal input validation (title non-empty check)
- **Test Mode Security**: Firebase rules set for development, not production

## 📄 License

This project was developed for educational purposes as part of the iOS Mobile Development 1 final examination at LaSalle College. All rights reserved.

## 👤 Author

**Evelyne Mukarukundo**  
Computer Science Student @ LaSalle College

- 📧 Email: evelynekessie@gmail.com
- 💼 LinkedIn: [Evelyne Mukarukundo](https://www.linkedin.com/in/evelyne-mukarukundo-317407188/)
- 🐙 GitHub: [@250evelyne](https://github.com/250evelyne)
- 📍 Location: Montréal, QC, Canada
- 🎓 Program: DEC in Computer Science - Programming
- 🆔 Student ID: 2414737

## 🙏 Acknowledgments

### Course & Institution
- **LaSalle College** - Computer Science Technology Program
- **Jerry Joy** - Course Instructor, iOS Mobile Development 1
- **Course Code**: 420-DM5-AS

### Technologies & Resources
- **Firebase** - Backend infrastructure and real-time database
- **Apple** - Swift, SwiftUI, and iOS SDK
- **SDWebImage** - Efficient image loading and caching
- **Jerry Joy API** - Notes data endpoint for project
- **Swift Documentation** - Comprehensive Swift language reference
- **Firebase Documentation** - Firestore integration guides

### Community Support
- Stack Overflow community
- Swift Forums
- Firebase community forums
- Classmates for testing and feedback

## 📞 Support

For questions about this project:
- 📧 Email: evelynekessie@gmail.com
- 💼 LinkedIn: [Connect with me](https://www.linkedin.com/in/evelyne-mukarukundo-317407188/)
- 🐙 GitHub: [View my projects](https://github.com/250evelyne)

---

⭐ **This project demonstrates competency in iOS mobile development with modern Swift practices and cloud integration.**

**Project Type**: Academic Final Examination  
**Status**: Completed  
**Grade**: [To be evaluated]

---

*Developed as part of LaSalle College Computer Science curriculum*  
*Last Updated: December 2024*
