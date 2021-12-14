<?php

namespace EnterMedia\Test;

use PHPunit\Framework\TestCase;


class Test extends TestBase {
  /*
  public function testHasClientData() {
    $this->assertTrue((bool) $this->client_id, 'Client ID exists');
    $this->assertTrue((bool) $this->client_secret, 'Client secret exists');
  }
*/
  public function testAuthorization() {
    $client = $this->getClient();
    $this->assertTrue($client->isAuthorized(), 'Client is authorized');
  }

  public function testSearchAssetsById() {
    $filters = $this->getFilters('AXXnGKpK8GsidWiEcA9l');
    $found_assets = $this->cms->listAssets($filters);
    print_r ($found_assets);
    $this->assertTrue((bool) $found_assets, "Results not found");
  }

  public function testSearchAssetsByName() {
    $filters = $this->getFilters('dog','name');
    $found_assets = $this->cms->listAssets($filters);
    print_r ($found_assets);
    $this->assertTrue((bool) $found_assets, "Results not found");
  }
/*
  public function testSearchAssetsByKeyword() {
    $filters = $this->getFilters('bird','keywords');
    $found_assets = $this->cms->listAssets($filters);
    print_r ($found_assets);
    $this->assertTrue((bool) $found_assets, "Results not found");
  }
*/
  // public function testSearchAssetsByDate() {
  //   $filters = $this->getFilters('2018-11-18','date');
  //   $found_assets = $this->cms->listAssets($filters);
  //   print_r ($found_assets);
  //   $this->assertTrue((bool) $found_assets, "Results not found");
  // }

}
