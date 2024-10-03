The Akbank Test Application is a banking integration app developed for the iOS platform. The app allows users to register and log in using Firebase Authentication with an email and password. Once logged in, users can manage their bank accounts through Akbank and add new bank accounts.

The app securely stores user data using Firebase Storage and Firestore Database. During the bank account addition process, users can integrate with another app called Pokus to complete the authorization process. When Pokus is opened, users are presented with an authorization screen where they can select the type of bank account. Once the authorization process is completed, users are redirected back to the Akbank application, where the newly added bank and account type are displayed.

This project efficiently utilizes various Firebase services and supports deep linking to enable smooth transitions between apps. The Akbank Test application is designed to enhance the user experience and make banking operations more accessible.

The key technologies used in the project are:

Firebase Authentication: Used for user registration and login processes.
Firebase Storage: Ensures secure storage of user data.
Firestore Database: Utilized for real-time database operations.
Deep Linking: Facilitates inter-app connections and data sharing.
