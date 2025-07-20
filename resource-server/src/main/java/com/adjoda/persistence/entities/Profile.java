package com.adjoda.persistence.entities;


import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Profile {

    @Id
    private String code; // ex: ProfilChefAgence

    @Column(nullable = false)
    private String label;

    @ManyToMany
    @JoinTable(
            name = "profile_role",
            joinColumns = @JoinColumn(name = "profile_code"),
            inverseJoinColumns = @JoinColumn(name = "role_name")
    )
    private List<Role> roles;
}
