package com.adjoda.jwt;

import com.adjoda.persistence.entities.Permission;
import com.adjoda.persistence.repositories.RoleRepository;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class CustomJwtConverter implements Converter<Jwt, CustomJwt> {
    private final RoleRepository roleRepository;

    public CustomJwtConverter(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @Override
    public CustomJwt convert(Jwt source) {
        List<GrantedAuthority> authorities = new ArrayList<>();

        // 1. Extraire les rôles Keycloak
        List<String> roles = extractRoles(source);

        // 2. Charger les permissions associées
        List<Permission> permissions = roleRepository.findPermissionsByRoleNames(roles);

        // 3. Ajouter les permissions comme autorités
        authorities.addAll(permissions.stream()
                .map(p -> new SimpleGrantedAuthority(p.getCode()))
                .collect(Collectors.toList()));

        // 4. (Optionnel) Ajouter aussi les rôles
        authorities.addAll(roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
                .toList());

        // 5. Créer le JwtAuthenticationToken
        var customJwt = new CustomJwt(source, authorities);
        customJwt.setFirstname(source.getClaimAsString("given_name"));
        customJwt.setLastname(source.getClaimAsString("family_name"));
        return customJwt;



        /*
        List<GrantedAuthority> grantedAuthorities = extractAuthorities(source);
        var customJwt = new CustomJwt(source, grantedAuthorities);
        customJwt.setFirstname(source.getClaimAsString("given_name"));
        customJwt.setLastname(source.getClaimAsString("family_name"));
        return customJwt;

         */
    }

    private List<String> extractRoles(Jwt jwt) {
        Map<String, Object> realmAccess = jwt.getClaim("realm_access");
        if (realmAccess == null || realmAccess.get("roles") == null) return List.of();
        return (List<String>) realmAccess.get("roles");
    }

    private List<GrantedAuthority> extractAuthorities(Jwt source) {
        var result = new ArrayList<GrantedAuthority>();
        var realm_access = source.getClaimAsMap("realm_access");
        if (realm_access != null && realm_access.get("roles") != null) {
            var roles = realm_access.get("roles");
            if (roles instanceof List l) {
                l.forEach( role -> {
                    result.add(new SimpleGrantedAuthority("ROLE_" + role));
                });
            }
        }
        return result;
    }
}
