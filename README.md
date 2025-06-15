# Medical Records App

This Flutter project is a comprehensive medical records management system built with a focus on ease-of-use, modern design, and robust functionalities. The app integrates various features to help users manage and access their medical records quickly and efficiently.

## Key Functionalities

- **Home Screen with Navigation Drawer**
  - A central dashboard that provides quick access to all major functionalities.
  - Drawer navigation with links to the following screens:
    - Home
    - Medical Records System
    - Smart Emergency Mode
    - Emergency Access Mode
    - Add Record
    - MediBot (AI Chatbot)

- **Medical Records System**
  - Allows users to capture and upload medical reports and prescription images.
  - Integration with the device camera and file picker for capturing images.
  - Uploads files to Firebase Storage and saves record metadata in Firestore.
  - Provides navigation to view detailed records through designated folder screens.

- **Smart Emergency Mode**
  - Utilizes location services (via Geolocator) to track and display live geographic location using Google Maps.
  - Displays a visually animated pulse header and other emergency alerts.
  - Shows quick vital details and QR code placeholders to quickly provide emergency information.

- **Emergency Access Mode**
  - Provides emergency access information screen with vital instructions and safe navigation.
  - Designed for immediate and intuitive emergency operations.

- **Add Record Screen**
  - Users can add comprehensive details for a new medical record.
  - Includes fields for record type, doctor name, hospital name, and additional notes.
  - Supports file selection for uploading PDF or image files.
  - Ensures that all necessary information is validated before upload.

- **Reports Folder & Prescriptions Folder Screens**
  - Dedicated UIs for managing and viewing medical reports and prescriptions.
  - Lists uploaded records, allowing users to organize and access their medical history.

- **MediBot (AI Chatbot)**
  - Chat interface to interact with an AI-powered medical assistant.
  - Built on the OpenAI API (GPT-3.5-turbo), the bot provides helpful responses on health-related queries.
  - Supports quick prompt buttons for common inquiries like symptoms check, headache advice, and diet suggestions.

## Additional Features

- **Firebase Integration**
  - Authentication using Firebase Auth to ensure secure user sessions.
  - Firestore for storing and retrieving record metadata.
  - Firebase Storage for hosting uploaded images and documents.

- **UI and Animations**
  - Modern and responsive UI built with Material Design using Flutter.
  - Animations implemented using the flutter_animate package for a dynamic user experience.
  - Google Fonts integration for custom typography.

- **Third-Party Libraries**
  - **Geolocator & Google Maps Flutter:** For live location tracking and map display in Smart Emergency Mode.
  - **File Picker & Image Picker:** To handle file and image selection.
  - **HTTP:** For API calls to the OpenAI endpoint powering the AI Chatbot.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup:**
   - Configure Firebase Auth, Firestore, and Firebase Storage for your project.
   - Update the Google Services files as needed for your platform.

4. **Run the app:**
   ```bash
   flutter run
   ```

5. **Note:** Ensure you have properly set up API keys for both Firebase and OpenAI. Replace the placeholder in the Medibot screen with your own OpenAI API key for production use.

## Project Structure

- **lib/main.dart:** Main entry point and routing setup.
- **lib/home_screen.dart:** Home screen UI with navigation.
- **lib/medical_records_system_screen.dart:** Logic for uploading and managing medical records.
- **lib/smart_emergency_mode_screen.dart:** Emergency mode with live location and animations.
- **lib/emergency_access_mode_screen.dart:** Emergency access interface.
- **lib/add_record_screen.dart:** Form for adding a new medical record.
- **lib/reports_folder_screen.dart & lib/prescription_folder_screen.dart:** Screens to view reports and prescriptions.
- **lib/screens/medibot_screen.dart:** AI Chatbot interface for medical inquiries.
- **lib/services:** Contains services for image/file upload and Firestore operations.
- **pubspec.yaml:** Project dependencies and configuration.

## Conclusion

This project combines robust medical record management, emergency response features, and an AI chatbot assistant, making it an innovative solution to manage healthcare information. Enjoy exploring and extending its capabilities!
