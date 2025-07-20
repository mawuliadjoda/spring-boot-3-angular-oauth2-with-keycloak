package com.adjoda.persistence.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Permission {

    @Id
    private String code;

    @Column(nullable = false)
    private String description;

    @ManyToMany(mappedBy = "permissions")
    private List<Role> roles;
}
