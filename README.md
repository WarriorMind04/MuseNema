# 🎬 MuseNema

Discover the soundtracks behind your favorite **movies, series, and video games**.

MuseNema is an iOS app built with **SwiftUI** that lets you explore curated metadata and listen to soundtrack previews using **MusicKit** and **Spotify**.  
The app combines local JSON files, Apple Music integration, and a secure backend built with **Python + Flask + Vercel** to protect API credentials.

---

## 🚀 Features

### 🔍 Browse Movies, Series & Games  
- Metadata loaded from local JSON files  
- Includes poster image, title, and description  

### 🎵 Soundtracks & Previews  
- Fetch full soundtrack albums using **MusicKit**  
- 30-second preview playback via **AVFoundation**  
- Track metadata, artwork, and audio previews  

### 🎧 Spotify API Integration  
- Extended soundtrack search  
- Handled through a secure backend so no credentials are ever stored in the app  

### 🛡️ Secure Backend  
- Custom Python + Flask API  
- Deployed on **Vercel**  
- Wraps Spotify OAuth and prevents exposing sensitive keys  

---

## 🧩 Tech Stack

### **Frontend (iOS App)**
- SwiftUI  
- MusicKit  
- AVFoundation  
- Combine  
- Async/Await  
- JSON file decoding  

### **Backend**
- Python 3  
- Flask  
- Requests  
- Vercel deployment  

### **APIs Used**
- Apple Music API (MusicKit)  
- Spotify Web API  

---

## 🗂 Project Structure
MuseNema/
├── Components/
│   ├── Apple Music Comp/
│   │   ├── AlbumRowView.swift
│   │   ├── AlbumSearchView.swift
│   │   ├── PreviewPlayer.swift
│   │   ├── SongRowView.swift
│   │   └── SongSearchView.swift
│   ├── Category/
│   │   ├── CardsCarrusel.swift
│   │   ├── SongRowViewww.swift
│   │   └── TabBarView.swift
│
├── Data/
│   ├── games.json
│   ├── media.json
│   ├── movies.json
│   └── tvseries.json
│
├── Models/
│   ├── MediaModels/
│   │   ├── Game.swift
│   │   ├── Movie.swift
│   │   └── TVSerie.swift
│   └── SpotifyModels/
│       ├── Album.swift
│       ├── Artist.swift
│       ├── ModelDataSoundtrack.swift
│       ├── SpotifyImage.swift
│       ├── Track.swift
│       ├── MDSoundtrack.swift
│       └── MediaItem.swift
│
├── Services/
│   ├── MusicServices.swift
│   ├── NetworkManager.swift
│   └── SpotifyAPI.swift
│
├── ViewModels/
│   ├── SoundtrackViewModel.swift
│   └── SpotifyTracksViewModel.swift
│
└── Views/
    ├── Games/
    ├── Movies/
    └── Series/
---

## 🏗️ How It Works

### 1️⃣ **Local Data**
The app reads movies, series, and games from bundled JSON files.

### 2️⃣ **Album & Soundtrack Lookup**
MusicKit fetches:
- Album metadata  
- Song list  
- Preview URLs  

### 3️⃣ **Spotify API via Secure Backend**
Swift app → Flask server → Spotify API  
This keeps your API keys hidden from the client.

### 4️⃣ **Preview Playback**
AVPlayer is used to play preview audio clips smoothly.

---

## 📥 Installation

### 1. Clone the repo
```sh
git clone https://github.com/WarriorMind04/MuseNema.git
