SET search_path TO mon_schema_2;

CREATE TABLE permission ( code VARCHAR(255) PRIMARY KEY, label VARCHAR(255), description TEXT ); CREATE TABLE context ( code VARCHAR(255) PRIMARY KEY, label VARCHAR(255) ); CREATE TABLE permission_context ( permission_code VARCHAR(255) NOT NULL, context_code VARCHAR(255) NOT NULL, PRIMARY KEY (permission_code, context_code), FOREIGN KEY (permission_code) REFERENCES permission(code), FOREIGN KEY (context_code) REFERENCES context(code) ); CREATE TABLE role ( code VARCHAR(255) PRIMARY KEY, name VARCHAR(255) NOT NULL ); CREATE TABLE profile ( code VARCHAR(255) PRIMARY KEY, role_code VARCHAR(255) UNIQUE NOT NULL, FOREIGN KEY (role_code) REFERENCES role(code) ); CREATE TABLE role_permission_context ( role_code VARCHAR(255) NOT NULL, permission_code VARCHAR(255) NOT NULL, context_code VARCHAR(255) NOT NULL, PRIMARY KEY (role_code, permission_code, context_code), FOREIGN KEY (role_code) REFERENCES role(code), FOREIGN KEY (permission_code, context_code) REFERENCES permission_context(permission_code, context_code) );



-- ==== Permissions (réduites au nouvel ensemble) ====
INSERT INTO permission (code, label, description) VALUES
                                                      ('EXPORT_PDF', 'Export PDF', 'Exporter des documents PDF'),
                                                      ('MODIFY',     'Modify',     'Modifier les ressources'),
                                                      ('DISPLAY',    'Display',    'Afficher/consulter les ressources'),
                                                      ('DELETE',     'Delete',     'Supprimer les ressources'),
                                                      ('UPDATE',     'Update',     'Mettre à jour les ressources');

-- ==== Contexts (nouveaux : PRODUCT, ORDER, NOTIFICATION) ====
INSERT INTO context (code, label) VALUES
                                      ('PRODUCT',      'Produit'),
                                      ('ORDER',        'Commande'),
                                      ('NOTIFICATION', 'Notification');

-- ==== permission_context : produit cartésien (toutes permissions sur tous les contexts) ====
INSERT INTO permission_context (permission_code, context_code) VALUES
                                                                   ('EXPORT_PDF','PRODUCT'),      ('EXPORT_PDF','ORDER'),      ('EXPORT_PDF','NOTIFICATION'),
                                                                   ('MODIFY','PRODUCT'),          ('MODIFY','ORDER'),          ('MODIFY','NOTIFICATION'),
                                                                   ('DISPLAY','PRODUCT'),         ('DISPLAY','ORDER'),         ('DISPLAY','NOTIFICATION'),
                                                                   ('DELETE','PRODUCT'),          ('DELETE','ORDER'),          ('DELETE','NOTIFICATION'),
                                                                   ('UPDATE','PRODUCT'),          ('UPDATE','ORDER'),          ('UPDATE','NOTIFICATION');

-- ==== Rôles (inchangés) ====
INSERT INTO role (code, name) VALUES
                                  ('CONSEILLER',   'Conseiller'),
                                  ('CHEF_AGENCE',  'Chef d’Agence'),
                                  ('AUDITEUR',     'Auditeur'),
                                  ('SUPPORT',      'Support Client');

-- ==== Profils (inchangés) ====
INSERT INTO profile (code, role_code) VALUES
                                          ('ProfilConseiller',    'CONSEILLER'),
                                          ('ProfilChefAgence',    'CHEF_AGENCE'),
                                          ('ProfilAuditeur',      'AUDITEUR'),
                                          ('ProfilSupportClient', 'SUPPORT');

-- ==== role_permission_context
-- CONSEILLER : DISPLAY & MODIFY sur tous les contexts
INSERT INTO role_permission_context (role_code, permission_code, context_code) VALUES
                                                                                   ('CONSEILLER','DISPLAY','PRODUCT'),
                                                                                   ('CONSEILLER','DISPLAY','ORDER'),
                                                                                   ('CONSEILLER','DISPLAY','NOTIFICATION'),
                                                                                   ('CONSEILLER','MODIFY','PRODUCT'),
                                                                                   ('CONSEILLER','MODIFY','ORDER'),
                                                                                   ('CONSEILLER','MODIFY','NOTIFICATION');

-- CHEF_AGENCE : DISPLAY, MODIFY, EXPORT_PDF sur tous les contexts
INSERT INTO role_permission_context (role_code, permission_code, context_code) VALUES
                                                                                   ('CHEF_AGENCE','DISPLAY','PRODUCT'),
                                                                                   ('CHEF_AGENCE','DISPLAY','ORDER'),
                                                                                   ('CHEF_AGENCE','DISPLAY','NOTIFICATION'),
                                                                                   ('CHEF_AGENCE','MODIFY','PRODUCT'),
                                                                                   ('CHEF_AGENCE','MODIFY','ORDER'),
                                                                                   ('CHEF_AGENCE','MODIFY','NOTIFICATION'),
                                                                                   ('CHEF_AGENCE','EXPORT_PDF','PRODUCT'),
                                                                                   ('CHEF_AGENCE','EXPORT_PDF','ORDER'),
                                                                                   ('CHEF_AGENCE','EXPORT_PDF','NOTIFICATION');

-- AUDITEUR : DISPLAY sur tous les contexts
INSERT INTO role_permission_context (role_code, permission_code, context_code) VALUES
                                                                                   ('AUDITEUR','DISPLAY','PRODUCT'),
                                                                                   ('AUDITEUR','DISPLAY','ORDER'),
                                                                                   ('AUDITEUR','DISPLAY','NOTIFICATION');

-- SUPPORT : DISPLAY sur tous les contexts
INSERT INTO role_permission_context (role_code, permission_code, context_code) VALUES
                                                                                   ('SUPPORT','DISPLAY','PRODUCT'),
                                                                                   ('SUPPORT','DISPLAY','ORDER'),
                                                                                   ('SUPPORT','DISPLAY','NOTIFICATION');
