<?php
namespace EnterMedia\API;

use EnterMedia\Object\Asset\Asset;
use EnterMedia\Object\CustomFields;
use EnterMedia\Object\ObjectInterface;
use EnterMedia\Object\ObjectBase;

/**
  * This class provides uncached read access to the data via request functions.
 *
 * @api
 */
class CMS extends API {

  protected function cmsRequest($method, $endpoint, $result, $is_array = FALSE, $post = NULL) {
    return $this->client->request($method, '1','cms', NULL, $endpoint, $result, $is_array, $post);
  }

  /**
   * Lists asset objects with the given restrictions.
   *
   * @return Asset[]
   */
  public function listAssets($filters = [], $page = 1,  $number_of_items = 20) {

    $body = [
      'json' => [
        'page' => (string) $page,
        'hitsperpage' => (string) $number_of_items,
        'showfilters' => "true",
        'query' => [
          'terms' => $filters,
        ],
      ],
    ];

    $post_data = json_encode($body['json']);

    return $this->cmsRequest('POST', "/services/module/asset/search", Asset::class, TRUE, $post_data);
  }

  public function getAssetFields() {
    return $this->cmsRequest('GET', "/services/module/asset/search", CustomFields::class, FALSE);
  }

  /**
   * Gets the data for a single asset by issuing a GET request.
   *
   * @return Asset $asset
   */
  public function getAsset($asset_id) {
    return $this->cmsRequest('GET', "/services/module/asset/search", Asset::class);
  }

  /**
   * Updates a asset object with an HTTP PATCH request.
   *
   * @return Asset $asset
   */
  public function updateAsset(Asset $asset) {
    // not implemented
    return null;
  }


}
