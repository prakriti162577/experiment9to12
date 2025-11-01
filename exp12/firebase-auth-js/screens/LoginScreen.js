import React, { useState } from 'react';
import {
  View,
  TextInput,
  Button,
  Text,
  StyleSheet,
  KeyboardAvoidingView,
  Platform,
  Alert,
} from 'react-native';
import { signInWithEmailAndPassword } from 'firebase/auth';
import { auth } from '../firebaseConfig';
import GoogleSignIn from '../components/GoogleSignIn'; // ✅ Import Google Sign-In

export default function LoginScreen({ navigation }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleLogin = async () => {
    try {
      await signInWithEmailAndPassword(auth, email, password);
      console.log('Login success');
      navigation.replace('Home');
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <TextInput
        style={styles.input}
        placeholder="Email"
        autoCapitalize="none"
        keyboardType="email-address"
        onChangeText={setEmail}
        value={email}
      />
      <TextInput
        style={styles.input}
        placeholder="Password"
        secureTextEntry
        onChangeText={setPassword}
        value={password}
      />
      <Button title="Login" onPress={handleLogin} />
      <View style={styles.reset}>
        <Button
          title="Forgot Password?"
          onPress={() => navigation.navigate('ForgotPassword')}
        />
      </View>
      {error ? <Text style={styles.error}>{error}</Text> : null}
      <View style={styles.switch}>
        <Button title="Go to Signup" onPress={() => navigation.navigate('Signup')} />
      </View>
      <View style={styles.google}>
        <GoogleSignIn navigation={navigation} /> {/* ✅ Google Sign-In Button */}
      </View>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    paddingHorizontal: 20,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    padding: 10,
    marginBottom: 12,
    borderRadius: 5,
  },
  error: {
    color: 'red',
    marginVertical: 10,
    textAlign: 'center',
  },
  switch: {
    marginTop: 20,
  },
  reset: {
    marginTop: 10,
  },
  google: {
    marginTop: 30,
  },
});