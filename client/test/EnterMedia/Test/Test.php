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
}
