package com.adjoda.persistence.repositories;

import com.adjoda.persistence.entities.Permission;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PermissionRepository extends JpaRepository<Permission, String> {
}
