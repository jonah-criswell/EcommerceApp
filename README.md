<<<<<<< HEAD
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
=======
# EcommerceApp
An ecommerce web app built to familiarize myself with ruby/ruby on rails for my upcoming internship with Cru. Clone this repo into your preferred IDE with rails install, and in the root directory of the project files, run bin/rails server, and go to your internet brower and enter "localhost:3000"

The app currently supports basic CRUD operations using a SQLite relatoinal database to store products' names, descriptions, prices, images, and inventory counts. The home page is where you will find a list of all products, and a search bar which can be handy if the product list gets very long.

The app also boasts an authentication system, to where only authenticated users can add, edit, or remove products from the store. Simple click "sign up" in the top left corner to create an account to play around with these configurations. 

Additionally, there is a subscription option for out-of-stock products to where customers wanting to buy a product that is out-of-stock, can subscribe to that product and will get emailed when that product is back in stock.

Highest priority features TODO:

The config/db/seeds.rb is WIP but I am working on leveragering AI to automate writing descriptions for products, and to tailor a focused search query to query the unsplash AI to fetch an image. This way I can simply run the seeds.rb file to automatically populate the database with products and all associated data

The next actual feature I want to add is to integrate Stripe into the application and provide a proper "Add to cart" and "checkout" functions, where customers can then actually purchase the product(s)

Lastly, I need to style the website using mostly likely tailwind CSS for a more user-friendly and modern interface. The app is mainly HMTL at the moment as I want to get core functionally done first.
>>>>>>> 9976336fd3d7d0f4ef9b565748ce6efc8922cf94
