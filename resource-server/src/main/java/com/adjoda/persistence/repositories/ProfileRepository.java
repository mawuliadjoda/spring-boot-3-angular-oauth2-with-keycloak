package com.adjoda.persistence.repositories;

import com.adjoda.persistence.entities.Profile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProfileRepository extends JpaRepository<Profile, String> {
}
