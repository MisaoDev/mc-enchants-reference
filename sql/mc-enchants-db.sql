DROP DATABASE IF EXISTS mc_enchants;
CREATE DATABASE IF NOT EXISTS mc_enchants;
USE mc_enchants;

CREATE TABLE enchant (
  id              INT           PRIMARY KEY,
  name            VARCHAR(20)   NOT NULL,
  short_text      VARCHAR(100)  NOT NULL,
  full_text       TEXT          NOT NULL,
  enchant_type_id INT           NOT NULL,
  rarity          INT           NOT NULL,
  max_level       INT           ,
  max_level_table INT           ,
  is_curse        BOOLEAN       NOT NULL,
  image_name      VARCHAR(24)   NOT NULL
);

CREATE TABLE enchant_type (
  id      INT           PRIMARY KEY,
  name    VARCHAR(20)   NOT NULL
);

CREATE TABLE item (
  id      INT           PRIMARY KEY,
  name    VARCHAR(20)   NOT NULL
);

CREATE TABLE compatible_with (
  enchant_id  INT   NOT NULL,
  item_id     INT   NOT NULL,
  PRIMARY KEY (enchant_id, item_id)
);

INSERT INTO enchant_type (id, name) VALUES
  (1, 'Vanilla'),
  (2, 'Enchants²');

INSERT INTO item (id, name) VALUES
  (1, 'sword'),
  (2, 'bow'),
  (3, 'crossbow'),
  (4, 'trident'),
  (5, 'helmet'),
  (6, 'chestplate'),
  (7, 'leggings'),
  (8, 'boots'),
  (9, 'shears'),
  (10, 'flintandsteel'),
  (11, 'fishingrod'),
  (12, 'elytra'),
  (13, 'pickaxe'),
  (14, 'axe'),
  (15, 'shovel'),
  (16, 'hoe'),
  (17, 'shield'),
  (18, 'book');

INSERT INTO enchant (id, name, short_text, full_text, enchant_type_id, rarity, max_level, max_level_table, is_curse, image_name) VALUES
  (
    1,
    'excavation',
    'Pica un área de 3x3x1 en lugar de 1x1x1, pero pica un poco más lento.',
    'Agáchate mientras picas para picar normalmente.',
    2,
    20,
    0,
    0,
    false,
    'excavation.png'
  ),
  
  (
    2,
    'rejuvenation',
    'Regenera la durabilidad lentamente al moverse.',
    'Al nivel III hay un 30% de regenerar 1 punto de durabilidad por movimiento.',
    2,
    80,
    3,
    3,
    false,
    'rejuvenation.png'
  ),

  (
    3,
    'lava walker',
    'Permite caminar por la lava dejando bloques de magma en el camino.',
    'Consume durabilidad. Genera magma en un radio de 1-3 bloques.',
    2,
    20,
    2,
    2,
    false,
    'lava walker.png'
  ),

  (
    101,
    'fire aspect',
    'Aplica fuego al objetivo.',
    'El fuego dura 4 segundos por cada nivel',
    1,
    2,
    2,
    2,
    false,
    'fire-aspect.webp'
  )
;

INSERT INTO compatible_with (enchant_id, item_id) VALUES
  (1, 13), (1, 14), (1, 15), (1, 16), (1,18),
  (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18),
  (101, 1), (101, 18)
;