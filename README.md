# Gurukul Manager: SIH2025 Automated Attendance System for Rural Schools

## Overview

Gurukul Manager is a Smart India Hackathon 2025 project designed to automate student attendance in rural schools. The solution aims to simplify daily attendance recording, reduce manual errors, and improve student tracking by leveraging technology to enhance school management and promote digital literacy.

## Problem

Many rural schools in India rely on manual attendance processes, which are often time-consuming and prone to error. This not only reduces effective teaching time but also affects government reporting for initiatives like mid-day meals and resource allocation.

## Solution

Gurukul Manager provides:
- **Mobile app for attendance recording (Flutter)**
- **Automated attendance capture using QR codes and future facial recognition**
- **Offline-first design with automatic sync when internet is available**
- **Centralized dashboard for teachers and administrators**
- **SMS notifications for absentees**
- **Reports export for administrators**

## Architecture

- **Frontend:** Flutter mobile application
- **Backend:** Flask API (optional, for advanced processing)
- **Database:** Firebase for storage and sync
- **Offline Mode:** Offline attendance with auto-sync

## Key Features

- User-friendly app for teachers, students, and administrators
- Role-based access (Admin, Teacher, Student)
- Session-based attendance marking via QR scan
- Real-time analytics and dashboards
- Data exports and reporting for school authorities

## Setup Instructions

### Prerequisites
- Flutter SDK installed
- Python (for Flask backend)
- Firebase project configured

### Installation

1. **Clone the repository:**
    ```
    git clone https://github.com/raunaksing15-blip/SIH2025-Automated-Attendance-System-for-Rural-School
    cd SIH2025-Automated-Attendance-System-for-Rural-School
    ```

2. **Flutter setup:**
    - Run `flutter pub get` in project root
    - Add your Firebase `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS)
    - Start the app with `flutter run`

3. **Backend setup (optional):**
    - Navigate to the `backend` folder
    - Install dependencies: `pip install -r requirements.txt`
    - Run Flask server: `python app.py`

### Usage

- Teachers login and mark attendance via mobile app
- Administrators view dashboards and generate reports
- Offline attendance auto-syncs when internet is available

## Screenshots

![App Screenshot](screenshot1.png)
![Dashboard Screenshot](dashboard.png)

## Tech Stack

- Flutter (Dart)
- Python Flask (backend)
- Firebase (database, auth)
- C++, CMake, Swift (supporting components)

## Contributors

- Raunak Singh (Team Lead)
- Team Gurukul Manager, SIH2025

## License

This project is licensed under the MIT License.

---

*For Smart India Hackathon 2025 Submission*