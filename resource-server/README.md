docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:23.0.6 start-dev

Profile → Role → Permission

Relation entre entités :
Profile ⬌↔⬌ Role

Role ⬌↔⬌ Permission


[ Profile ]
↕ many-to-many (profile_role)
[ Role ]
↕ many-to-many (role_permission)
[ Permission ]



public class CustomJwtAuthenticationConverter implements Converter<Jwt, AbstractAuthenticationToken> {
@Override
public AbstractAuthenticationToken convert(Jwt jwt) {
Collection<GrantedAuthority> authorities = extractRoles(jwt);
return new JwtAuthenticationToken(jwt, authorities);
}

    private Collection<GrantedAuthority> extractRoles(Jwt jwt) {
        List<String> roles = Optional.ofNullable(jwt.getClaimAsMap("realm_access"))
                                     .map(realm -> (List<String>) realm.get("roles"))
                                     .orElse(Collections.emptyList());
        return roles.stream()
                    .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
                    .collect(Collectors.toList());
    }
}
