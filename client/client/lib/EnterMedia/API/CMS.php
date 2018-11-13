<?php
namespace EnterMedia\API;

use EnterMedia\Object\Asset\Asset;
use EnterMedia\Object\CustomFields;

/**
  * This class provides uncached read access to the data via request functions.
 *
 * @api
 */
class CMS extends API {

  protected function cmsRequest($method, $endpoint, $result, $is_array = FALSE, $post = NULL) {
    return $this->client->request($method, '1','cms', $this->account, $endpoint, $result, $is_array, $post);
  }

  /**
   * Lists video objects with the given restrictions.
   *
   * @return Video[]
   */
  public function listAssets($search = NULL, $sort = NULL, $limit = NULL, $offset = NULL) {
    $query = '';
    if ($search) {
      $query .= '&q=' . urlencode($search);
    }
    if ($sort) {
      $query .= "&sort={$sort}";
    }
    if ($limit) {
      $query .= "&limit={$limit}";
    }
    if ($offset) {
      $query .= "&offset={$offset}";
    }
    if (strlen($query) > 0) {
      $query = '?' . substr($query, 1);
    }
    return $this->cmsRequest('GET', "/<endpoint>{$query}", Asset::class, TRUE);
  }

  public function getAssetFields() {
    return $this->cmsRequest('GET', "/<endpoint>", CustomFields::class, FALSE);
  }

  /**
   * Gets the data for a single asset by issuing a GET request.
   *
   * @return Video $video
   */
  public function getAsset($asset_id) {
    return $this->cmsRequest('GET', "/<endpoint>/{$asset_id}", Asset::class);
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