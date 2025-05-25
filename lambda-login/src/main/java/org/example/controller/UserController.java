package org.example.controller;

import org.example.model.LoginRequest;
import org.example.model.LoginResponse;

import java.util.HashMap;
import java.util.List;

import org.example.security.JwtUtil;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.ScanRequest;

import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    private final DynamoDbClient dynamoDbClient;
    private final JwtUtil jwtUtil;
    private final String TABLE_NAME = "User";

    public UserController(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
        this.dynamoDbClient = DynamoDbClient.create();
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        try {
            String email = request.getEmail();
            String password = request.getPassword();

            Map<String, AttributeValue> expressionValues = new HashMap<>();
            expressionValues.put(":email", AttributeValue.builder().s(email).build());

            ScanRequest scanRequest = ScanRequest.builder()
                    .tableName(TABLE_NAME)
                    .filterExpression("email = :email")
                    .expressionAttributeValues(expressionValues)
                    .build();

            List<Map<String, AttributeValue>> items = dynamoDbClient.scan(scanRequest).items();
            if (items.isEmpty()) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Email not found");
            }

            Map<String, AttributeValue> userItem = items.get(0);
            String storedPassword = userItem.get("password").s();
            if (!storedPassword.equals(password)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
            }

            String userId = userItem.get("uuid").s();
            String token = jwtUtil.generateToken(userId);

            Map<String, String> response = new HashMap<>();
            response.put("token", token);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Internal Server Error");
        }
    }
}
