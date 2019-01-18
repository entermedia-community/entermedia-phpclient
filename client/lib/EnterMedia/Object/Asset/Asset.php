<?php

namespace EnterMedia\Object\Asset;

use EnterMedia\Object\ObjectBase;

/**
 * Representation of all data related to an Asset object.
 *
 * @api
 */
class Asset extends ObjectBase {
  /**
   * The asset id.
   *
   * @var string
   */
  protected $id;
  /**
   * ISO 8601 date-time string
   * Date-time Asset was added to the account; example: "2014-12-09T06:07:11.877Z".
   *
   * @var string
   */
  protected $assetaddeddate;
  /**
   * Asset title - required field
   *
   * @var string
   */
  protected $name;
  /**
   * Long caption of the Asset
   *
   * @var string
   */
  protected $longcaption;
  /**
   * Source Path of the Asset.
   *
   * @var string
   */
  protected $sourcepath;
  /**
   * ISO 8601 date-time string
   * date-time Asset was last modified.
   * Example: "2015-01-13T17:45:21.977Z"
   *
   * @var string
   */
  protected $assetmodificationdate;

  public function applyJSON(array $json) {
    parent::applyJSON($json);
    $this->applyProperty($json, 'id');
    $this->applyProperty($json, 'assetaddeddate');
    $this->applyProperty($json, 'name');
    $this->applyProperty($json, 'longcaption');
    $this->applyProperty($json, 'sourcepath');
    $this->applyProperty($json, 'assetmodificationdate');
  }

  /**
   * @return string
   */
  public function getId() {
    return $this->id;
  }

  /**
   * @param string $id
   * @return $this
   */
  public function setId($id) {
    $this->id = $id;
    $this->fieldChanged('id');
    return $this;
  }

  /**
   * @return string
   */
  public function getassetaddeddate() {
    return $this->assetaddeddate;
  }

  /**
   * @param string $assetaddeddate
   * @return $this
   */
  public function setassetaddeddate($assetaddeddate) {
    $this->assetaddeddate = $assetaddeddate;
    $this->fieldChanged('assetaddeddate');
    return $this;
  }

  /**
   * @return string
   */
  public function getName() {
    return $this->name;
  }

  /**
   * @param string $name
   * @return $this
   */
  public function setName($name) {
    $this->name = $name;
    $this->fieldChanged('name');
    return $this;
  }

  /**
   * @return string
   */
  public function getLongCaption() {
    return $this->longcaption;
  }

  /**
   * @param string $longcaption
   * @return $this
   */
  public function setLongCaption($longcaption) {
    $this->longcaption = $longcaption;
    $this->fieldChanged('longcaption');
    return $this;
  }

  /**
   * @return string
   */
  public function getSourcePath() {
    return $this->sourcepath;
  }

  /**
   * @param string $sourcepath
   * @return $this
   */
  public function setSourcePath($sourcepath) {
    $this->sourcepath = $sourcepath;
    $this->fieldChanged('sourcepath');
    return $this;
  }

  /**
   * @return string
   */
  public function getAssetModificationDate() {
    return $this->assetmodificationdate;
  }

  /**
   * @param string $assetmodificationdate
   * @return $this
   */
  public function setAssetModificationDate($assetmodificationdate) {
    $this->assetmodificationdate = $assetmodificationdate;
    $this->fieldChanged('assetmodificationdate');
    return $this;
  }
}
