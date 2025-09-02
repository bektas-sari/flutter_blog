# Flutter Blog App

A simple and elegant Flutter-based mobile blog application. This project demonstrates a clean blog reading experience optimized for mobile devices, and includes core features like post listings, tag filtering, and detailed views. The application is statically populated via Dart data files, and can be evolved into a fully dynamic blog experience.

---

## ✨ Features

* Beautiful post card UI and detail screens
* Tag-based filtering
* Pagination logic
* Custom theme using Material 3
* Structured architecture (models, controllers, widgets)

---

## 🎓 Developer Info

**Bektas Sari**  
- **Email:** [bektas.sari@gmail.com](mailto:bektas.sari@gmail.com)  
- **GitHub:** [github.com/bektas-sari](https://github.com/bektas-sari)  
- **LinkedIn:** [linkedin.com/in/bektas-sari](https://www.linkedin.com/in/bektas-sari)  
- **Researchgate:** [researchgate.net/profile/Bektas-Sari-3](https://www.researchgate.net/profile/Bektas-Sari-3)  
- **Academia:** [independent.academia.edu/bektassari](https://independent.academia.edu/bektassari)

---

## 🌐 Tech Stack

* **Flutter** (v3+)
* **Dart** language
* Stateless & stateful widgets
* ChangeNotifier-based controllers

---

## 🔄 Current State

This app currently uses **static data sources** (`posts.dart`, `projects.dart`) and hardcoded models (`Post`, `Project`). It's fully functional, but not connected to a backend or content management system. Content updates require recompilation.

---

## ✅ Potential Improvements

To move beyond a prototype and provide real-world value, the app can be extended in the following ways:

1. **Connect to a backend**

    * Use Firebase Firestore, Supabase, or REST API to load blog posts dynamically
    * Enable real-time updates and push notifications

2. **Add advanced features**

    * Search bar
    * Bookmarks / Favorites
    * Share functionality
    * Audio version of posts (Text-to-Speech)

3. **Admin CMS Integration**

    * Link to a headless CMS like Strapi or WordPress API
    * Admin can write/update posts without touching code

4. **Theming & UX**

    * Night mode support
    * Animated transitions between screens
    * Improved typography for long-form reading

---

## 🏋️ Use Case Evaluation

While blog apps are usually consumed via browser, there are valid cases for a mobile app:

* Personalized reading space for loyal followers
* Access to exclusive or offline content
* Notifications for new entries
* Bundling with other tools (e.g., notes, learning, etc.)

However, for general users, unless your content is:

* **Highly unique**,
* **Frequently updated**, or
* **Part of a broader app ecosystem**,

the incentive to download a dedicated app may be limited. That’s why transitioning from static content to a live feed is strongly recommended.

---

## 📚 License

MIT License

---

## ⚙️ Getting Started

```bash
flutter pub get
flutter run -d windows # or chrome/emulator
```

---

## 📅 Last Updated

August 2025
