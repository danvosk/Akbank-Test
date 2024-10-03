The Akbank Test Application is a banking integration app developed for the iOS platform. It allows users to register and log in using Firebase Authentication with an email and password. Once logged in, users can manage their bank accounts, add new banks, and update existing accounts within the Akbank application.

Key Features
User Registration and Login: Users can sign up or log in to the app using Firebase Authentication with their email and password.
Add Bank Accounts: Users can add new bank accounts to their profile and manage existing accounts from within the Akbank app.
Pokus Integration: The app integrates with the Pokus Test Application to allow users to authorize bank accounts. Users can select Pokus from within Akbank to initiate the authorization process. Once the authorization is complete, the user is redirected back to Akbank, where the authorized bank account and its type are displayed.
Firebase Integration
The Akbank Test Application leverages Firebase for various functionalities:

Firebase Authentication: Manages user registration and login.
Firebase Storage and Firestore Database: Securely stores user data and bank account information.
Deep Linking with Pokus
The application uses deep linking to interact with Pokus Test Application for the authorization process. When a user selects to authorize an account, they are redirected to Pokus to complete the authorization, and once completed, they are seamlessly redirected back to the Akbank app. This ensures smooth transitions between the apps.

User Email Validation
Similar to Pokus, if the email address in Akbank does not match the email address in Pokus, the user will not be redirected to Pokus for authorization, and the process will fail. However, when both emails are the same, users can successfully be redirected to Pokus and complete the authorization process.

Core Technologies of the Application
Firebase Authentication: Handles user login and registration.
Firebase Storage: Ensures secure storage of user data.
Firestore Database: Manages user and bank data in real time.
Deep Linking: Facilitates seamless app-to-app communication and data transfer.
The Akbank Test Application is designed to provide a secure and user-friendly platform for managing bank accounts and integrates smoothly with Pokus for bank account authorization, making the process simple and efficient for users.
