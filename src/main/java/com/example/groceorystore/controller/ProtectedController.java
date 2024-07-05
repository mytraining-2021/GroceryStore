package com.example.groceorystore.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
@Slf4j
public class ProtectedController {

    @GetMapping("/protected-endpoint")
    @CrossOrigin(origins = "http://localhost:63342")
    public String protectedEndpoint() {
        log.info("protected-endpoint");
        return "This is a protected endpoint. You have successfully accessed it with a valid JWT token.";
    }
}
