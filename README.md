# Card Input Field - Flutter 🚀

A modular, reusable, and SOLID-principled **Card Number Input Field** built using Flutter.  
This project demonstrates **best practices** in state management, clean architecture, and design patterns.

## 🎥 Demo Preview

### 📌 SMS Input Field in Action
<img src="asset/sms_input_field.gif" width="300" height="auto">

### 📌 Credit Card 
<img src="asset/credit_card.gif" width="300" height="auto">

## 📌 Features
✅ **Custom card number input field** with automatic focus shifting.  
✅ **Supports configurable separator lengths** for different card formats.  
✅ **Follows SOLID principles** and **design patterns** for modularity and scalability.  
✅ **No external state management library required.**  
✅ **Optimized with controllers** to prevent unnecessary rebuilds.

## 🚀 **Getting Started**
### 1️⃣ Clone the Repository
```sh
git clone https://github.com/sepehrTabeian/Card-Input-Field---Flutter
cd flutter-card-input
```
### 2️⃣ Install Dependencies
```sh
flutter pub get
```
### 3️⃣ Run the App
```sh
flutter run
```
## **Customization**
```dart
const CardInputScreen(
  numberSeparatorLength: 4, // Digits per box
  numberValueLength: 16, // Total card number length
  boxCount: 4, // Number of input boxes
  widthBox: 50,
  heightBox: 50,
);
```
## **🤝 Contributing**
Feel free to submit issues, pull requests, or suggest improvements! 🚀

*📩 Maintained by*: Sepehr Tabeian [![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/sepehr-tabeian-554b601a8/)

## **📜 License**
This project is open-source and available under the MIT License.

