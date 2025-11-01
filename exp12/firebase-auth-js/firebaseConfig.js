// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
import { getAuth } from 'firebase/auth';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyANlK5zxbbOh2Bnbp3UYeO7Q8WrgIPncvE",
  authDomain: "jsauthapp-615c0.firebaseapp.com",
  projectId: "jsauthapp-615c0",
  storageBucket: "jsauthapp-615c0.firebasestorage.app",
  messagingSenderId: "775774202073",
  appId: "1:775774202073:web:63a60eb666d71f032776c8"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);