# This Is That - City Matching App 🌍

![App Preview](app/assets/images/homepagethis.png)

**"This Is That"** is a Rails application that helps digital nomads and travelers find familiar places in new cities. Love **Blue Bottle Coffee** in **San Francisco**? We'll help you find the equivalent vibe in **Tokyo**, **Austin**, or **Berlin**.

## ✨ Features

### Core Features
- **Smart Matching** - Connects you to places that feel like home using Yelp data
- **Visual Search** - Beautiful dark-themed UI to explore your matches
- **Save Favorites** - Star your favorite places for quick access
- **User Accounts** - Personalized experience with Devise authentication

### New Features (v2.0)
- ⚖️ **Compare Places** - Side-by-side comparison of home spots vs matches
- 🔍 **Search History** - Quick access to your recent searches
- ⭐ **Favorites System** - Mark and organize your favorite places
- 🌍 **Explore Page** - Discover places saved by the community
- ⚙️ **Settings Page** - Manage profile, email preferences, theme
- 🗑️ **Delete Account** - GDPR-compliant account deletion
- 📤 **Share Places** - Share place details via Web Share API
- 👍👎 **Review Voting** - Upvote/downvote reviews from other users
- 🔙 **Back Navigation** - Consistent back buttons on all pages

## 📸 Screenshots

### Homepage
Start your journey by defining what you're looking for.

![Homepage](app/assets/images/homepagethis.png)

### Compare Places
Select a home place and a match to compare them side-by-side.

![Compare Places](app/assets/images/compare.png)

### User Dashboard
Manage your profile, view your saved matches, and explore new cities.

![User Dashboard](app/assets/images/dashboardthis.png)

### Place Details & Map
See ratings, reviews, and the exact location on our integrated map.

![Place Details](app/assets/images/geocode.png)

## 🚀 Getting Started

### Prerequisites

- Ruby 3.2+
- Rails 7.1+
- PostgreSQL
- Bundler

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/this_is_that.git
   cd this_is_that
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup Database**
   ```bash
   rails db:create db:migrate db:seed
   ```

4. **Environment Variables**
   Create a `.env` file and add your API keys:
   ```
   SERPAPI_KEY=your_key_here
   ```

5. **Start the Server**
   ```bash
   bin/dev
   ```

   Visit `http://localhost:3000` to start searching!

## 🛠 Tech Stack

- **Backend**: Ruby on Rails 8
- **Frontend**: TailwindCSS, Hotwire (Turbo & Stimulus)
- **Database**: PostgreSQL
- **APIs**: SerpAPI (Yelp Data), Nominatim (Geocoding)
- **Maps**: Leaflet.js
- **Authentication**: Devise with OmniAuth (Google)
- **Deployment**: Render / Heroku Ready

## 📁 Project Structure

```
app/
├── controllers/
│   ├── dashboard_controller.rb   # User dashboard & favorites
│   ├── explore_controller.rb     # Public places discovery
│   ├── places_controller.rb      # CRUD for saved places
│   ├── reviews_controller.rb     # Reviews & voting
│   ├── search_controller.rb      # Yelp search & matching
│   └── settings_controller.rb    # User profile settings
├── javascript/controllers/
│   ├── compare_controller.js     # Side-by-side comparison
│   ├── loading_controller.js     # Button loading states
│   ├── map_controller.js         # Leaflet map integration
│   └── rating_controller.js      # Star rating interaction
└── views/
    ├── dashboard/                # Dashboard views
    ├── explore/                  # Explore page
    ├── places/                   # Place cards & details
    ├── search/                   # Search & results
    └── settings/                 # Settings page
```

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

Built with ❤️ using Rails 8 & TailwindCSS
