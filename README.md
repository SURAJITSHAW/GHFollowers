# 👥 GitHub Followers App

A simple iOS app built with **UIKit** (programmatically, no Storyboards) that lets users:

🔍 Enter a GitHub username  
👤 View a paginated list of followers  
📃 Handle empty states  
⚠️ Show error messages when things go wrong  
📦 Cache follower images  
🧱 Display followers in a 3-column UICollectionView layout  
💡 Built without any 3rd-party libraries

---

## 📸 Preview

<!-- Replace the image URL below with an actual screenshot or screen recording -->
![Preview](https://photos.app.goo.gl/bi9HLqTQ9A3ZHik16)

---

## ✨ Features

🔄 **Pagination**: Loads 30 followers per page as the user scrolls
📛 **Error Handling**: Alerts for invalid usernames or API errors
📭 **Empty States**: Shows custom messages when no followers are found
📦 **Caching**: Follower images are cached using NSCache for performance
🔎 **Search**: Filter followers with a real-time search bar
🧱 **Diffable Data Source**: Clean and efficient data updates
🛠️ **UIKit-Only**: No Storyboard, no SwiftUI, no CocoaPods or SPM

---

## 🧑‍💻 Tech Stack

**UIKit** – Fully programmatic UI
**UICollectionViewDiffableDataSource**
**URLSession** – for networking
**Codable** – to parse GitHub API responses
**NSCache** – for image caching

---
