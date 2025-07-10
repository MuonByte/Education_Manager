# EduScan Pro 📚✨  
**Intelligent Study Scanner, Organizer & AI Tutor**  
A cross-platform AI-powered Flutter app designed to help students scan, structure, and learn from any printed or handwritten material—backed by a Node.js backend with real-time collaboration, cloud inference, and personalized study analytics.

---

## 🚀 Features Overview

### 1. 📷 Smart Study Scanner (Flutter + AI)
- **Live OCR Scanning**
  - Real-time camera capture with auto-crop and perspective correction.
  - Supports printed text, equations, and handwritten notes using on-device OCR (Tesseract or Google ML Kit).
- **Intelligent Structuring**
  - Automatically classifies content into subjects (e.g. Math, History, Science).
  - Breaks content into headings, paragraphs, tables, and bullet points.
- **Summarization & Flashcard Generation**
  - AI summarizes each section into concise key points using Transformer models.
  - Auto-generates question-answer flashcards including fill-in-the-blank and multiple-choice variants.

### 2. 🧠 Adaptive Tutor Engine (AI/ML)
- **Context-Aware Q&A Tutor**
  - Fine-tuned GPT model that answers questions based on your uploaded material.
  - Learns from your notes, summaries, and scanned documents.
- **Personalized Learning Paths**
  - Tracks flashcard performance and quiz history.
  - Adapts with spaced repetition and surfaces weaker topics over time.
- **On-Device & Cloud Inference**
  - OCR and flashcards run offline.
  - Summarization and GPT-powered Q&A require backend inference for optimal responses.

### 3. 🌐 Collaborative Learning Backend (Node.js)
- **RESTful & WebSocket APIs**
  - Upload and tag scans with version control in MongoDB/PostgreSQL.
  - Real-time study groups: co-annotate, quiz together using Socket.IO.
- **User Profiles & Analytics**
  - JWT-based authentication, stores user progress, flashcard history, and study trends.
  - GraphQL layer for insights: daily time spent, mastery heatmaps, topic weaknesses.
- **Serverless Model Processing**
  - Uses AWS Lambda or Google Cloud Functions for compute-heavy tasks.
  - Caches structured results and tutor sessions for reuse.

---

## 🧩 System Architecture

```mermaid
graph LR
A[Flutter App] --> B[Node.js Backend]
B --> C[Database: MongoDB/PostgreSQL]
B --> D[Cloud Functions: Summarizer, Flashcards, GPT Q&A]
B --> E[WebSockets: Real-time Study]
A --> F[On-Device OCR & Flashcards]
A --> G[AI Tutor UI]
```

---

## 🔧 Tech Stack


### 🎯 Flutter App Features

- **Camera-based OCR Scanner** with real-time cropping and enhancement
- **Offline Flashcard Mode** powered by on-device summarizer and drill logic
- **Interactive Tutor Chat UI** for AI Q&A based on user-scanned content
- **Document Organizer** to categorize scans by subject and topic
- **Progress Dashboard** to visualize mastery and flashcard accuracy
- **Dark & Light Theme Support** with adaptive UI components
- **Real-time Group Study UI** with collaborative annotation and quizzing
- **State Management** using Bloc or Riverpod (user configurable)


### Frontend (Flutter)
- Flutter 3+ (Dart)
- Tesseract OCR / Google ML Kit
- Riverpod / Bloc (for state management)
- Flutter WebSocket client
- Hive / SharedPreferences (local storage)


### 🔐 Advanced Backend Security Features

- **Short-lived JWTs** with refresh token rotation and device binding
- **End-to-End Encryption (E2EE)** for sensitive documents and scans
- **Encrypted WebSocket Channels** for real-time collaboration using Socket.IO
- **Spaced Repetition Analytics** isolated per-user with row-level permissions
- **Tamper Detection System** using SHA256 hashes + device fingerprinting
- **Rate-limited AI Endpoints** with dynamic per-user thresholds
- **Serverless Model Execution Sandboxes** (Docker or Cloud Functions) to isolate AI workloads
- **Signed Upload URLs** with HMAC time-based validation for secure document ingestion
- **GraphQL Role-based Access Layer** that protects user insights and analytics


### Backend (Node.js)
- Express.js + Socket.IO
- MongoDB / PostgreSQL
- AWS Lambda / Google Cloud Functions
- JWT Authentication
- GraphQL (Apollo Server)

### AI/ML Stack
- Hugging Face Transformers for summarization
- Custom Q&A model fine-tuned on user notes
- Flashcard generation logic (BERT-style entity masking + MCQ distractor logic)

---

## 🗂️ Project Structure

```
/eduscan-pro/
│
├── frontend/               # Flutter app
│   ├── lib/
│   ├── assets/
│   └── test/
│
├── backend/                # Node.js server
│   ├── src/
│   │   ├── routes/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── services/
│   │   └── sockets/
│   └── .env
│
├── functions/              # Cloud Functions
│   ├── summarizer/
│   ├── flashcards/
│   └── tutorQA/
│
├── README.md
└── docs/
```

---

## 🧪 Getting Started

### Prerequisites

- Flutter 3.x
- Node.js 18+
- MongoDB or PostgreSQL instance
- Firebase or AWS/GCP account (for cloud functions)

---

## 🧠 AI/ML Deployment Notes

- GPT/Q&A model hosted on cloud using serverless inference or Hugging Face Spaces.
- Summarizer model deployed as an endpoint in cloud function.
- Flashcard generation uses NLP masking + syntactic distractor generation logic.

---

## 📈 Future Plans

- ✨ Full offline support with quantized models.
- 📝 Handwriting recognition with support for math notation.
- 📅 Weekly study goals and reminders.
- 🧑‍🏫 Teacher/admin dashboard for monitoring multiple users.

---

## 🤝 Contributing

We're open to contributions! Please open an issue or submit a pull request if you’d like to contribute code, report bugs, or request features.
