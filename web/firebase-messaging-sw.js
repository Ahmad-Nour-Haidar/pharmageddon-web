importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");


const firebaseConfig = {
  apiKey: "AIzaSyAimFMNlxl2-6czPArbOnYjS4wTrmf9-Fc",
  authDomain: "pharmageddon-mobile.firebaseapp.com",
  projectId: "pharmageddon-mobile",
  storageBucket: "pharmageddon-mobile.appspot.com",
  messagingSenderId: "239774217166",
  appId: "1:239774217166:web:0bd99bae0b9ef47cb4319f",
  measurementId: "G-FKZ2HETRVL"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});