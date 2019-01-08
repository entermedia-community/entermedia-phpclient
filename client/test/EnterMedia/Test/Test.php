<?php

namespace EnterMedia\Test;

use PHPunit\Framework\TestCase;

class Test extends TestBase {
  public function testHasClientData() {
    $this->assertTrue((bool) $this->client_id, 'Client ID exists');
    $this->assertTrue((bool) $this->client_secret, 'Client secret exists');
  }

  public function testAuthorization() {
    $client = $this->getClient();
    $this->assertTrue($client->isAuthorized(), 'Client is authorized');
  }

  public function testSearchAssets() {
    $found_assets = $this->cms->listAssets();
    //$this->assertEquals(1, count($found_assets), "More than 1 asset found");
    print_r($found_assets);
    $this->assertTrue((bool) $found_assets, "Results not found");
    //return $assets;
  }
}
