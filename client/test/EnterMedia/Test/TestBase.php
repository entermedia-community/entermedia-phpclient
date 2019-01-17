<?php

namespace EnterMedia\Test;

use EnterMedia\API\Client;
use EnterMedia\API\CMS;
use EnterMedia\API\Exception\AuthenticationException;
use EnterMedia\Object\Asset\Asset;
use PHPUnit\Framework\TestCase;

/**
 * Base class for all test for the EnterMedia API wrapper.
 */
class TestBase extends TestCase {

  /**
   * OAuth2 client id.
   *
   * @var string
   */
  protected $client_id;

  /**
   * OAuth2 client secret.
   *
   * @var string
   */
  protected $client_secret;

  /**
   * A EnterMedia client to be used with the endpoint wrapper classes.
   *
   * @var Client
   */
  protected $client;

  /**
   * A wrapper instance on the CMS API.
   *
   * @var CMS
   */
  protected $cms;

  /**
   * Creates a new authorized client instance.
   *
   * @return Client
   * @throws AuthenticationException
   */
  protected function getClient() {
    return Client::authorize($this->client_id, $this->client_secret);
  }

  /**
   * Sets up the test class.
   *
   * Currently it reads the command line arguments and sets up the client and the wrapper objects.
   */
  public function setUp() {
    $json = file_get_contents("test/config.json");
    if ($json) {
      $config = json_decode($json, TRUE);
      if (is_array($config)) {
        foreach ($config as $k => $v) {
          $this->{$k} = $v;
        }
      }
    }

    $this->client = $this->getClient();
    $this->cms = $this->createCMSObject($this->client);
  }

  /**
   * Creates a new CMS object instance.
   *
   * @param Client $client
   *   The $client instance to use. If NULL, then the client of this class will be used.
   * @return CMS
   */
  protected function createCMSObject(Client $client = NULL) {
    if ($client === NULL) {
      $client = $this->getClient();
    }
    return new CMS($client, $this->account);
  }

  /**
   * Creates the filter for the search terms.
   *
   * @return $filter
   * @throws AuthenticationException
   */
  protected function getFilters($value = '*', $field = 'id', $operator = 'matches') {
    $filters = [];
    $filters[] = [
      'field' => $field,
      'operator' => $operator,
      'value' => $value,
    ];
    return $filters;
  }

}
