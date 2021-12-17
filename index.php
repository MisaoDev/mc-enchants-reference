<?php

require('conn.php');

?>


<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Encantamientos</title>

  <!-- Bulma CSS Framework -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">

  <!-- Style -->
  <link rel="stylesheet" href="css/main.css">

</head>

<body class="pb-6">

  <header class="hero is-primary">
    <div class="hero-body has-text-centered">
      <h1 class="title">Guía de Encantamientos</h1>
      <p class="subtitle">Vanilla + Enchants Squared plugin</p>
    </div>
  </header>

  <div class="container is-max-desktop mt-5">

    <div id="filter-container" class="filter-container mb-5">
      <?php
      $query = "SELECT `name` FROM `item`";
      $result = $conn->query($query);
      $rows = $result->fetch_all(MYSQLI_ASSOC);
      $result->close();

      foreach ($rows as $row) {
        $itemName = $row['name'];
      ?>

        <button class="button filter-button is-hoverable <?php echo $itemName == 'book' ? 'active-filter' : '' ?>" onclick="filterSelection('filter-<?php echo $itemName; ?>')">
          <img src="img/item/<?php echo $itemName; ?>.webp" alt="" class="filter-icon">
        </button>

      <?php } ?>
    </div>

    <?php

    $query = "SELECT
        enc.id AS `enchant_id`,
        enc.name AS `enchant_name`,
        short_text,
        full_text,
        enc_type.id AS `type_id`,
        enc_type.name AS `type_name`,
        rarity,
        max_level,
        max_level_table,
        is_curse,
        image_name
      FROM enchant AS enc
      JOIN enchant_type AS enc_type ON enc.enchant_type_id = enc_type.id;";
    $result = $conn->query($query);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    $result->close();

    foreach ($rows as $row) {
      $enchantId       = $row['enchant_id'];
      $enchantName     = $row['enchant_name'];
      $shortText       = $row['short_text'];
      $fullText        = $row['full_text'];
      $enchantTypeId   = $row['type_id'];
      $enchantType     = $row['type_name'];
      $rarity          = $row['rarity'];
      $max_level       = $row['max_level'];
      $max_level_table = $row['max_level_table'];
      $is_curse        = $row['is_curse'];
      $enchantImg      = $row['image_name'];

      $enchantTypeClass = $enchantTypeId == 1 ? 'vanilla-enchant' : 'plugin-enchant';
      $max_level        = $max_level == 0       ? "---" : $max_level;
      $max_level_table  = $max_level_table == 0 ? "---" : $max_level_table;

      // Find compatible items
      $item_query =
        "SELECT item.id AS `item_id`, item.name AS `item_name`
        FROM `item`
        JOIN compatible_with AS comp ON comp.item_id = item.id
        JOIN enchant AS enc ON enc.id = comp.enchant_id
        WHERE enc.id = ?;";

      $stmt = $conn->prepare($item_query);
      $stmt->bind_param("i", $enchantId);
      $stmt->execute();
      $compatibleWithList = $stmt->get_result();

      $filterClasses = "filterDiv";
      foreach ($compatibleWithList as $row) {
        $itemName = $row['item_name'];
        $filterClasses .= " filter-" . $itemName;
      }
    ?>

      <div class="box has-background-white-bis p-2 <?php echo $filterClasses; ?>">

        <div class="enchant-box is-flex is-justify-content-space-between">
          <div class="left-section">
            <div class="is-flex is-align-items-center mb-2">
              <img src="img/<?php echo $enchantImg ?>" alt="" class="item-icon">
              <h2 class="is-size-4 has-text-weight-semibold">
                <?php echo ucfirst($enchantName); ?>
              </h2>
              <div class="box p-2 ml-auto <?php echo $enchantTypeClass; ?>">
                <?php echo $enchantType; ?>
              </div>
            </div>
            <p><?php echo $shortText; ?></p>
            <p><?php echo $fullText; ?></p>
          </div>
          <div class="right-section box p-2">
            <table class="table is-striped is-narrow is-fullwidth is-size-7">
              <tbody>
                <tr>
                  <td>Rareza</td>
                  <td><?php echo $rarity; ?></td>
                </tr>
                <tr>
                  <td>Nivel Max</td>
                  <td><?php echo $max_level; ?></td>
                </tr>
                <tr>
                  <td>Nivel Max Mesa</td>
                  <td><?php echo $max_level_table; ?></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="lower-section mt-3 is-flex is-align-items-center">
          <span class="is-size-7 ml-5 mr-4 has-text-grey-light">Sirve para:</span>
          <div class="compatible-list">
            <?php

            foreach ($compatibleWithList as $itemRow) {
              $itemName = $itemRow['item_name'];
            ?>

              <img src="img/item/<?php echo $itemName ?>.webp" alt="" class="compatible-icon">

            <?php
            }
            $stmt->close();
            ?>

          </div>
        </div>

      </div>

    <?php } ?>

  </div>

  <!-- Filter buttons -->
  <script src="js/filter.js"></script>  

</body>

</html>