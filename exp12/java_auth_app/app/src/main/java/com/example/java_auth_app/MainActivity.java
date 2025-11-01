package com.example.java_auth_app;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import java.util.Random;

public class MainActivity extends AppCompatActivity {

    private TextView randomNumberText;
    private Random random;
    private FirebaseAuth auth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 🔐 Initialize Firebase Auth
        auth = FirebaseAuth.getInstance();
        FirebaseUser user = auth.getCurrentUser();

        // 🔐 Redirect if not logged in
        if (user == null) {
            Toast.makeText(this, "Please log in first", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, LoginActivity.class));
            finish();
            return;
        }

        randomNumberText = findViewById(R.id.randomNumberText);
        Button generateButton = findViewById(R.id.generateButton);
        Button logoutButton = findViewById(R.id.logoutButton); // Optional logout button
        random = new Random();

        generateButton.setOnClickListener(v -> {
            int number = random.nextInt(100) + 1;
            randomNumberText.setText(String.valueOf(number));
        });

        logoutButton.setOnClickListener(v -> {
            auth.signOut();
            startActivity(new Intent(this, LoginActivity.class));
            finish();
        });
    }
}