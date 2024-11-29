
# POS System for Company A  

## Overview  

This Point of Sale (POS) System is a local, offline solution built with Flutter. It enables efficient sales transactions without
reliance on remote servers orinternet connectivity. The system supports two roles: Admin and Cashier, offering basic yet powerful 
functionalities for managing products and processing customer transactions.  

---

## Features  

### Admin  
- Add new products to the system.  

### Cashier  
- Handle customer purchases by selecting items and specifying quantities.  
- Process customer payments and generate receipts.  

---

## Core Functionalities  
- **Product Management**: Admins can add products with details like name, price, and quantity.  
- **Sales Transactions**: Cashiers can manage transactions, calculate totals, and generate receipts.  
- **Local Storage**: All data, including product information and user authentication, is stored locally.  

---

## Known Issues  

### Android Compatibility  
- There is a compilation issue on Android caused by the PDF and printing packages.  
- The system works fine on desktop platforms.  

### Workaround for Android  
To make the application work on Android:  
1. Comment out the PDF and printing packages in `pubspec.yaml`.  
2. In the `CartCubit`, comment out the `handleCheckout` function.  
3. Rebuild the project.  

This will allow the application to function without generating PDF receipts on Android devices.  

---

## Technologies Used  
**Flutter/Dart**: I used Flutter for building the cross-platform mobile and desktop application, with Dart as the programming language.
**Hive**: I implemented Hive as the local database to store items, ensuring data persistence even when offline.
**HydratedBloc**: I used HydratedBloc to manage the theme state and make sure it persists across app sessions for a seamless experience.
**Clean Architecture**: The app follows Clean Architecture principles to keep the codebase modular, maintainable, and scalable.

---

## Installation  

### Prerequisites  
- Flutter SDK installed ([Get Started with Flutter](https://flutter.dev/docs/get-started)).  

### Steps  
1. Clone the repository:  
   ```bash  
   git clone https://github.com/Ahmedx44/post_case_study  
   ```  

2. Navigate to the project directory:  
   ```bash  
   cd pos-system  
   ```  

3. Install dependencies:  
   ```bash  
   flutter pub get  
   ```  

4. Run the app:  
   ```bash  
   flutter run  
   ```  

---

## Usage  

### 1. Admin Login  
Log in as admin to add products to the system.  

### 2. Cashier Login  
Log in to handle customer purchases and process payments.  

---

## Username and Passwords  

- **Admin**  
  - Username: `Admin`  
  - Password: `password`  

- **Cashier**  
  - Username: `cashier`  
  - Password: `password`  

---

## Video Recording  



https://github.com/user-attachments/assets/bdcd574a-54e2-49c3-b00e-c19f78b82aea




