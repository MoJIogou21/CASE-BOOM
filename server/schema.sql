CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR(32) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  level INTEGER NOT NULL DEFAULT 1,
  xp BIGINT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE wallets (
  user_id BIGINT PRIMARY KEY REFERENCES users(id),
  balance BIGINT NOT NULL DEFAULT 0 CHECK (balance >= 0),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE cases (
  id BIGSERIAL PRIMARY KEY,
  slug VARCHAR(64) UNIQUE NOT NULL,
  title VARCHAR(100) NOT NULL,
  price_coins BIGINT NOT NULL CHECK (price_coins >= 0),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  sort_order INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE items (
  id BIGSERIAL PRIMARY KEY,
  slug VARCHAR(100) UNIQUE NOT NULL,
  weapon VARCHAR(80) NOT NULL,
  skin_name VARCHAR(100) NOT NULL,
  rarity VARCHAR(32) NOT NULL,
  image_url TEXT,
  model_url TEXT,
  enabled BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE case_drops (
  case_id BIGINT REFERENCES cases(id) ON DELETE CASCADE,
  item_id BIGINT REFERENCES items(id),
  weight BIGINT NOT NULL CHECK (weight > 0),
  PRIMARY KEY (case_id, item_id)
);

CREATE TABLE openings (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id),
  case_id BIGINT NOT NULL REFERENCES cases(id),
  item_id BIGINT NOT NULL REFERENCES items(id),
  price_paid BIGINT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE inventory_items (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id),
  item_id BIGINT NOT NULL REFERENCES items(id),
  opening_id BIGINT REFERENCES openings(id),
  acquired_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE wallet_ledger (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(id),
  amount BIGINT NOT NULL,
  reason VARCHAR(40) NOT NULL,
  reference_id BIGINT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_inventory_user ON inventory_items(user_id, acquired_at DESC);
CREATE INDEX idx_openings_user ON openings(user_id, created_at DESC);
