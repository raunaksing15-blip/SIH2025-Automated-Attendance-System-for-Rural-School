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

## Features

*   **QR Code-based Attendance:** Students can mark their attendance by scanning a QR code.
*   **Real-time Data Sync:** Attendance data is synced in real-time with the Firebase backend.
*   **View Attendance Records:** Students can view their attendance history.
*   **User Authentication:** Secure user authentication using Firebase Authentication.

## Screenshots

| Login Screen                                       | QR Scanner                                       | Attendance History                                   |
| -------------------------------------------------- | ------------------------------------------------ | ---------------------------------------------------- |
| ![Login Screen](screenshots/login_screen.png)      | ![QR Scanner](screenshots/qr_scanner.png)        | ![Attendance History](screenshots/attendance_history.png) |
| ![App Screenshot](screenshot1.png)                 | ![Dashboard Screenshot](dashboard.png)           |

## Setup Instructions

### Prerequisites

*   Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   Python 3.x: [https://www.python.org/downloads/](https://www.python.org/downloads/)
*   Firebase Project: [https://console.firebase.google.com/](https://console.firebase.google.com/)

### Frontend Setup (Flutter)

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/raunaksing15-blip/SIH2025-Automated-Attendance-System-for-Rural-School.git
    cd SIH2025-Automated-Attendance-System-for-Rural-School
    ```

2.  **Install Flutter dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Configure Firebase for your Flutter app:**

    *   Follow the instructions to add Firebase to your Flutter app: [https://firebase.google.com/docs/flutter/setup](https://firebase.google.com/docs/flutter/setup)
    *   Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the appropriate directories.

4.  **Run the Flutter app:**

    ```bash
    flutter run
    ```

### Backend Setup (Flask)

1.  **Navigate to the backend directory:**

    ```bash
    cd attendance-backend
    ```

2.  **Install Python dependencies:**

    ```bash
    pip install -r requirements.txt
    ```

3.  **Configure Firebase for your backend:**

    *   Go to your Firebase project settings and create a new service account.
    *   Download the service account key (a JSON file) and save it as `serviceAccountKey.json` in the `attendance-backend` directory.
    *   Create a `.env` file in the `attendance-backend` directory and add the following line:

        ```
        FIREBASE_ADMIN_SDK_JSON=./serviceAccountKey.json
        ```

4.  **Run the Flask server:**

    ```bash
    python app.py
    ```

## API Endpoints

*   `POST /mark_attendance`

    *   Marks attendance for a student.
    *   **Request Body:** `{"student_id": "<student_id>", "course_id": "<course_id>"}`
    *   **Response:** `{"success": true, "attendance_id": "<attendance_id>"}`

*   `GET /get_attendance`

    *   Retrieves attendance records for a student.
    *   **Query Parameters:** `student_id=<student_id>`
    *   **Response:** `{"success": true, "attendance": [...]}`

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
