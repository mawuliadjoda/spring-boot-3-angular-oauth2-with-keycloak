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
public class Role {

    @Id
    private String name; // ex: CONSEILLER, SUPPORT

    @ManyToMany
    @JoinTable(
            name = "role_permission",
            joinColumns = @JoinColumn(name = "role_name"),
            inverseJoinColumns = @JoinColumn(name = "permission_code")
    )
    private List<Permission> permissions;

    @ManyToMany(mappedBy = "roles")
    private List<Profile> profiles;
}
