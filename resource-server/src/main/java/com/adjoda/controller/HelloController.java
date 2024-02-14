package com.adjoda.controller;

import com.adjoda.jwt.CustomJwt;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.text.MessageFormat;

@RestController
@CrossOrigin(
        origins = "http://localhost:4200",
        allowedHeaders = "*",
        methods = { RequestMethod.GET }
)
@RequestMapping("/api/v1")
public class HelloController {

    /**
     * By default if the supplied role does not start with 'ROLE_' it will be added
     * @see https://docs.spring.io/spring-security/site/docs/4.2.x/reference/html/el-access.html
     * @return
     */
    @GetMapping("/hello")
    @PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
    public Message hello() {
        var jwt = (CustomJwt) SecurityContextHolder.getContext().getAuthentication();
        var message = MessageFormat.format(
                "Hello fullstack master {0} {1}, how is it going today ?",
                jwt.getFirstname(), jwt.getLastname()
        );
        return new Message(message);
    }

    record Message(String message){};
}
