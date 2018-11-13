<?php

use EnterMedia\Object\Asset\Asset;
use EnterMedia\Test\TestBase;

class AssetSearchTest extends TestBase {

  /**
   * @param Asset[] $assets
   * @depends testCreateAssets
   * @return Asset[]
   */
  public function testSearchAssets($assets) {
    sleep(1);
    $name = $assets[0]->getName();
    $found_assets = [];
    for ($i = 0; $i < 300; $i++) {
      sleep(1);
      $found_assets = $this->cms->listAssets("name:\"{$name}\"");
      if (count($found_assets) > 0) {
        break;
      }
    }
    $this->assertEquals(1, count($found_assets));
    $this->assertEquals($name, $found_assets[0]->getName());
    return $assets;
  }

}