<?php

namespace EnterMedia\API;

/**
 * A superclass for the EnterMedia API implementations.
 *
 * @internal
 */
abstract class API {

  protected $client;

  /**
   * API constructor.
   *
   * @param \EnterMedia\API\Client $client
   *
   * @internal
   */
  public function __construct(Client $client) {
    $this->client = $client;
  }
}
