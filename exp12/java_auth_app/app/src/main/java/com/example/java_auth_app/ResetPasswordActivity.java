package com.example.java_auth_app;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import com.google.firebase.auth.FirebaseAuth;

public class ResetPasswordActivity extends AppCompatActivity {

    private EditText emailInput;
    private Button resetButton;
    private FirebaseAuth auth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reset_password);

        auth = FirebaseAuth.getInstance();
        emailInput = findViewById(R.id.emailInput);
        resetButton = findViewById(R.id.resetButton);

        resetButton.setOnClickListener(v -> {
            String email = emailInput.getText().toString();

            if (email.isEmpty()) {
                Toast.makeText(this, "Enter your email", Toast.LENGTH_SHORT).show();
                return;
            }

            auth.sendPasswordResetEmail(email)
                    .addOnCompleteListener(task -> {
                        if (task.isSuccessful()) {
                            Toast.makeText(this, "Reset link sent to your email", Toast.LENGTH_LONG).show();
                            finish(); // Go back to login
                        } else {
                            Toast.makeText(this, "Failed to send reset email", Toast.LENGTH_SHORT).show();
                        }
                    });
        });
    }
}