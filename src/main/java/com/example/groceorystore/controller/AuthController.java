package com.example.groceorystore.controller;

import com.example.groceorystore.model.AuthRequest;
import com.example.groceorystore.model.AuthResponse;
import com.example.groceorystore.model.User;
import com.example.groceorystore.service.UserService;
import com.example.groceorystore.util.JwtUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@Slf4j
@CrossOrigin(origins = "http://localhost:63342/")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;


    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody User user) {
        String result = userService.registerUser(user);
        if (result.equals("User already registered")) {
            return new ResponseEntity<>(result, HttpStatus.CONFLICT);
        }
        return new ResponseEntity<>(result, HttpStatus.CREATED);
    }

    @PostMapping("/login")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody AuthRequest authRequest) throws Exception {
        if (!userService.checkIfUserExists(authRequest.getUsername())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not found. Please register.");
        }
        log.info("authRequest>>>>"+authRequest);
        authenticate(authRequest.getUsername(), authRequest.getPassword());

        final UserDetails userDetails = userService.loadUserByUsername(authRequest.getUsername());
        final String jwt = jwtUtil.generateToken(userDetails);

        return ResponseEntity.ok(new AuthResponse(jwt));
    }

    private void authenticate(String username, String password) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (DisabledException e) {
            throw new Exception("USER_DISABLED", e);
        } catch (BadCredentialsException e) {
            throw new Exception("INVALID_CREDENTIALS", e);
        }
    }
}
