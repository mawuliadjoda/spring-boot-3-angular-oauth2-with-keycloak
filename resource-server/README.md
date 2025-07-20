

Profile → Role → Permission

Relation entre entités :
Profile ⬌↔⬌ Role

Role ⬌↔⬌ Permission


[ Profile ]
↕ many-to-many (profile_role)
[ Role ]
↕ many-to-many (role_permission)
[ Permission ]
