SET search_path TO mon_schema_2;

SELECT
    --r.code            AS role_code,
    --r.name            AS role_name,
    p.code            AS permission_code,
    p.label           AS permission_label,
    p.description     AS permission_description
--,c.code            AS context_code,
--c.label           AS context_label
FROM role r
         JOIN role_permission_context rpc
              ON rpc.role_code = r.code
         JOIN permission_context pc
              ON pc.permission_code = rpc.permission_code
                  AND pc.context_code = rpc.context_code
         JOIN permission p
              ON p.code = pc.permission_code
         JOIN context c
              ON c.code = pc.context_code
WHERE r.code = 'CHEF_AGENCE' AND c.code = 'PRODUCT'
ORDER BY c.code, p.code;


