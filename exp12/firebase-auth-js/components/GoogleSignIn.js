import React, { useEffect } from 'react';
import * as WebBrowser from 'expo-web-browser';
import * as Google from 'expo-auth-session/providers/google';
import { auth } from '../firebaseConfig';
import { signInWithCredential, GoogleAuthProvider } from 'firebase/auth';
import { Button } from 'react-native';

WebBrowser.maybeCompleteAuthSession();

export default function GoogleSignIn({ navigation }) {
  const [request, response, promptAsync] = Google.useAuthRequest({
    expoClientId: '775774202073-02f63tnqbi24uipveeg91a2jtt0gp34s.apps.googleusercontent.com',
    androidClientId:'775774202073-f8ra8lor9nfbps095hjdkcl9q0n2q53b.apps.googleusercontent.com',
    redirectUri: 'https://auth.expo.io/@prakr777/firebase-auth-js',
  });

  useEffect(() => {
    if (response?.type === 'success') {
      const { id_token } = response.params;
      const credential = GoogleAuthProvider.credential(id_token);
      signInWithCredential(auth, credential)
        .then(() => {
          console.log('Google login success');
          navigation.replace('Home');
        })
        .catch((err) => {
          console.error('Firebase login error:', err);
        });
    }
  }, [response]);

  return <Button title="Sign in with Google" onPress={() => promptAsync()} />;
}