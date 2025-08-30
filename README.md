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

## 🔐 Admin Access

Login using admin@demo.com | password: admin223 to explore admin tools, such as adding, editing, and deleting products.

---

## 📸 Screenshots (Coming Soon)


## 📚 Motivation

This project is a personal initiative to deepen my understanding of Ruby on Rails and gain experience with full-stack development before my internship. It replicates many features found in real-world eCommerce platforms, giving me hands-on experience with authentication, payments, and scalable app structure.

---

## Deployment (AWS EC2 with Kamal)

1. Build image:
   docker build -t jonahc/myshop .

2. Push to Docker Hub:
   docker push jonahc/myshop

3. SSH into EC2:
   ssh -i my-key.pem ubuntu@<ec2-ip>

4. Deploy:
   kamal deploy

