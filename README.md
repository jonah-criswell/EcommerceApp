# 🛒 EcommerceApp

A full-featured eCommerce web application built with **Ruby on Rails** as a hands-on learning project in preparation for my software engineering internship with [Cru](https://www.cru.org). The app includes real-world features like authentication, shopping cart functionality, product search, and Stripe integration.

---

## 🚀 Features

- **CRUD Product Management**  
  Create, update, and delete products with fields including name, description, price, inventory count, and image uploads. Data is stored in a **SQLite** relational database.

- **Authentication System**  
  Only administrative users can manage products. Log in using the email: admin@demo.com and password: admin223 to explore functionality in editing, creating, and deleting products. Create an account via the **Sign Up** link in the navbar to explore what a normal logged in user experiences.

- **Product Search**  
  Use the search bar on the home page to filter through a growing list of products by name or description.

- **Out-of-Stock Subscriptions**  
  Users can **subscribe to out-of-stock products** and receive an email notification when those items are back in stock.

- **Shopping Cart & Stripe Checkout**  
  Add products to a persistent cart and securely purchase them via **Stripe integration**, mimicking production-grade eCommerce flows.

---

## 🛠️ Getting Started

To run the app locally:

1. Clone the repository:
   ```bash
   git clone https://github.com/jonah-criswell/EcommerceApp.git
   cd EcommerceApp
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Start the server:
   ```bash
   bin/rails server
   ```

4. Visit the app in your browser:
   ```
   http://localhost:3000
   ```

> ⚠️ You must have Ruby and Rails installed on your system.

---

## 🔐 Admin Access (Coming Soon)

I'm working on role-based access so only **admin users** can manage product listings. Once implemented, I'll include admin credentials here so you can explore full functionality.

---

## 📸 Screenshots (Coming Soon)

Stay tuned! UI improvements and screenshots will be added after styling is complete.

---

## 🎯 Roadmap / TODOs

- [ ] Style the app using **Bootstrap** for clean, responsive design
- [ ] Restrict product management to **admin users** only
- [ ] Add a contextual homepage with branding and feature highlights
- [ ] Deploy to production (likely with **Render** or **Heroku**)
- [ ] Explore AI-powered features:
  - Generate product descriptions automatically
  - Recommend products based on user history

---

## 📚 Motivation

This project is a personal initiative to deepen my understanding of Ruby on Rails and gain experience with full-stack development before my internship. It replicates many features found in real-world eCommerce platforms, giving me hands-on experience with authentication, payments, and scalable app structure.

---


