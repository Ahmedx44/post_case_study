POS System for Company A

Overview

This Point of Sale (POS) System is a local, offline solution built with Flutter. It, enable efficient sales transactions without reliance in remote servers or internet connectivity. The system supports two roles: Admin and Cashier, offering basic yet powerful functionalities for managing products and processing customer transactions.

Features

Admin

Add new products to the system.


Cashier

Handle customer purchases by selecting items and specifying quantities.

Process customer payments and generate receipts.


Core Functionalities

Product Management: Admins can add products with details like name, price, and quantity.

Sales Transactions: Cashiers can manage transactions, calculate totals, and generate receipts.

Local Storage: All data, including product information and user authentication, is stored locally.


Known Issues

Android Compatibility

There is a compilation issue on Android caused by the PDF and printing packages.

However, the system works fine on desktop platforms.


Workaround for Android

To make the application work on Android:

1. Comment out the PDF and printing packages in pubspec.yaml.


2. In the CartCubit, comment out the handleCheckout function.


3. Rebuild the project.



This will allow the application to function without generating PDF receipts on Android devices.

Technologies Used

Flutter/Dart: Cross-platform framework for mobile and desktop development.

Hive: Lightweight local database for storing data.

HydratedBloc: State management with persistent theme support.

Clean Architecture: Ensures a modular, maintainable, and scalable codebase.


Installation

Prerequisites

Flutter SDK installed (Get Started with Flutter).


Steps

1. Clone the repository:

git clone https://github.com/Ahmedx44/post_case_study


2. Navigate to the project directory:

cd pos-system


3. Install dependencies:

flutter pub get


4. Run the app:

flutter run



Usage

1. Admin Login:

Log in as admin to add products to the system.



2. Cashier Login:

Log in to handle customer purchases and process payments.



