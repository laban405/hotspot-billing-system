CREATE TABLE IF NOT EXISTS radcheck (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL DEFAULT '',
  attribute VARCHAR(64) NOT NULL DEFAULT '',
  op CHAR(2) NOT NULL DEFAULT ':=',
  value VARCHAR(253) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY radcheck_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS radreply (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL DEFAULT '',
  attribute VARCHAR(64) NOT NULL DEFAULT '',
  op CHAR(2) NOT NULL DEFAULT '=',
  value VARCHAR(253) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY radreply_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS radgroupcheck (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  groupname VARCHAR(64) NOT NULL DEFAULT '',
  attribute VARCHAR(64) NOT NULL DEFAULT '',
  op CHAR(2) NOT NULL DEFAULT ':=',
  value VARCHAR(253) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY radgroupcheck_groupname (groupname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS radgroupreply (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  groupname VARCHAR(64) NOT NULL DEFAULT '',
  attribute VARCHAR(64) NOT NULL DEFAULT '',
  op CHAR(2) NOT NULL DEFAULT '=',
  value VARCHAR(253) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY radgroupreply_groupname (groupname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS radusergroup (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL DEFAULT '',
  groupname VARCHAR(64) NOT NULL DEFAULT '',
  priority INT NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  KEY radusergroup_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS radacct (
  radacctid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  acctsessionid VARCHAR(64) NOT NULL DEFAULT '',
  acctuniqueid VARCHAR(32) NOT NULL DEFAULT '',
  username VARCHAR(64) NOT NULL DEFAULT '',
  realm VARCHAR(64) DEFAULT '',
  nasipaddress VARCHAR(15) NOT NULL DEFAULT '',
  nasportid VARCHAR(32) DEFAULT NULL,
  nasporttype VARCHAR(32) DEFAULT NULL,
  acctstarttime DATETIME DEFAULT NULL,
  acctupdatetime DATETIME DEFAULT NULL,
  acctstoptime DATETIME DEFAULT NULL,
  acctinterval INT DEFAULT NULL,
  acctsessiontime INT UNSIGNED DEFAULT NULL,
  acctauthentic VARCHAR(32) DEFAULT NULL,
  connectinfo_start VARCHAR(50) DEFAULT NULL,
  connectinfo_stop VARCHAR(50) DEFAULT NULL,
  acctinputoctets BIGINT DEFAULT NULL,
  acctoutputoctets BIGINT DEFAULT NULL,
  calledstationid VARCHAR(50) NOT NULL DEFAULT '',
  callingstationid VARCHAR(50) NOT NULL DEFAULT '',
  acctterminatecause VARCHAR(32) NOT NULL DEFAULT '',
  servicetype VARCHAR(32) DEFAULT NULL,
  framedprotocol VARCHAR(32) DEFAULT NULL,
  framedipaddress VARCHAR(15) NOT NULL DEFAULT '',
  framedipv6address VARCHAR(45) NOT NULL DEFAULT '',
  framedipv6prefix VARCHAR(45) NOT NULL DEFAULT '',
  framedinterfaceid VARCHAR(44) NOT NULL DEFAULT '',
  delegatedipv6prefix VARCHAR(45) NOT NULL DEFAULT '',
  class VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (radacctid),
  UNIQUE KEY radacct_acctuniqueid (acctuniqueid),
  KEY radacct_username (username),
  KEY radacct_active_session_idx (acctuniqueid, username, acctstoptime),
  KEY radacct_start_user_idx (acctstarttime, username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS radpostauth (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) NOT NULL,
  pass VARCHAR(64) NOT NULL,
  reply VARCHAR(32) NOT NULL,
  authdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  class VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY radpostauth_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS nas (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nasname VARCHAR(128) NOT NULL,
  shortname VARCHAR(32) DEFAULT NULL,
  type VARCHAR(30) DEFAULT 'other',
  ports INT DEFAULT NULL,
  secret VARCHAR(60) NOT NULL,
  server VARCHAR(64) DEFAULT NULL,
  community VARCHAR(50) DEFAULT NULL,
  description VARCHAR(200) DEFAULT 'RADIUS client',
  PRIMARY KEY (id),
  UNIQUE KEY nas_nasname (nasname)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
