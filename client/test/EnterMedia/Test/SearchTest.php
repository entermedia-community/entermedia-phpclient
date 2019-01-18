<?php

use EnterMedia\Object\Asset\Asset;
use EnterMedia\Test\TestBase;

class AssetSearchTest extends TestBase {

  /**
   * @param Asset[] $assets
   * @return Asset[]
   */
  public function testSearchAssets($assets) {
    //sleep(1);
    // $name = $assets[0]->getName();
    // $found_assets = [];
    // for ($i = 0; $i < 300; $i++) {
    //   //sleep(1);
    //   $found_assets = $this->cms->listAssets();
    //   if (count($found_assets) > 0) {
    //     break;
    //   }
    // }
    $found_assets = $this->cms->listAssets();
    $this->assertEquals(1, count($found_assets), "More than 1 asset found");
    $this->assertEquals(1, count($found_assets), "More than 1 asset found");
    //$this->assertEquals($name, $found_assets[0]->getName());
    return $assets;
  }

}