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
  (17, 'shield');

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
    4,
    'shielding',
    'Tiene un 20%-40% de probabilidad de devolver proyectiles.',
    'Los proyectiles devueltos no te hacen daño.',
    2,
    40,
    2,
    2,
    false,
    'shielding.png'
  ),

  (
    5,
    'neutralizer',
    'Mientras bloqueas, las pociones arrojables y las nubes de pociones no te afectan.',
    'También aplica para efectos positivos.',
    2,
    40,
    0,
    0,
    false,
    'neutralizer.png'
  ),

  (
    6,
    'potency',
    'Amplifica el efecto de las pociones que bebes, pero reduce su duración.',
    'Al beber una poción se reduce su duración en un 20%-40%. Y aumenta los efectos en I-II niveles.',
    2,
    10,
    2,
    2,
    false,
    'potency.png'
  ),

  (
    7,
    'steady',
    'Reduce el empuje recibido en un 20%-40%.',
    '',
    2,
    40,
    2,
    2,
    false,
    'steady.png'
  ),

  (
    8,
    'illuminated',
    'Pone antorchas con <code>shift + click derecho</code>, a cambio de durabilidad.',
    'No consume antorchas del inventario. Requiere una superficie vacía. Consume 3 puntos de durabilidad y tiene un tiempo de espera entre cada antorcha.',
    2,
    40,
    0,
    0,
    false,
    'illuminated.gif'
  ),

  (
    9,
    'harvesting',
    'Replanta automáticamente los cultivos al recogerlos usando <code>click derecho</code>',
    '',
    2,
    80,
    0,
    0,
    false,
    'harvesting.png'
  ),

  (
    10,
    'kinship',
    'Al picar un bloque del mismo mineral con el que está hecho el pico, regenera durabilidad.',
    'Regenera cantidades diferentes según el material y el nivel: <br>
    <table class="is-bordered is-striped is-narrow">
      <thead>
        <tr>
          <th>Kinship</th>
          <th>I</th>
          <th>II</th>
          <th>III</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>Piedra</th>
          <td>0</td>
          <td>0</td>
          <td>0</td>
        </tr>
        <tr>
          <th>Hierro</th>
          <td>1</td>
          <td>2</td>
          <td>3</td>
        </tr>
        <tr>
          <th>Diamante</th>
          <td>10</td>
          <td>20</td>
          <td>30</td>
        </tr>
        <tr>
          <th>Netherita</th>
          <td>50</td>
          <td>100</td>
          <td>150</td>
        </tr>
      </tbody>
    </table>',
    2,
    80,
    3,
    3,
    false,
    'kinship.png'
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
  (1, 13), (1, 14), (1, 15), (1, 16),
  (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17),
  (3, 1),
  (4, 6),
  (5, 17),
  (6, 6), (6, 17), (6, 12),
  (7, 7),
  (8, 13),
  (9, 16),
  (10, 13),
  (101, 1)
;