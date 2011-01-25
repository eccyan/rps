<?php
require_once('./configs/common.php');
/**
 * Model Abstract Class
 */
class Model {
    var $config = null;
    var $table  = null;
    protected static $connection = null;
    protected static $database = null;

    function __construct() {
	$config = new DatabaseConfig();

	if ( is_null(self::$connection) ) {
	    $connection = mysql_connect($config->default->server, $config->default->user, $config->default->password) 
		or die ( " Could not connect server.  ".mysql_error() );

	    self::$connection = $connection;
	}
	if ( is_null(self::$database) ) {
	    $database = mysql_select_db($config->default->name, $connection)
		or die ( " Could not connect database.  ".mysql_error() );

	    self::$database = $database;
	}

	$this->config = $config;
    }
    function __destruct() {
	if ( !is_null(self::$connection) ) {
	    mysql_close(self::$connection);
	    self::$connection = null;
	}
    }

    function getFields() {
	if ( empty($this->table->name) ) {
	    throw new Exception( " Did not set table name. " );
	}

	if ( empty($this->table->fields) ) {
	    $resource = mysql_query("SHOW COLUMNS FROM {$this->table->name}");
	    if ( $resource === false ) {
		throw new Exception( " Could not get columns. ".mysql_error() );
	    }

	    if ( mysql_num_rows($resource) > 0) {
		$columns = array ();
		while ( $column = mysql_fetch_object($resource) ) {
		    $columns[$column->Field] = $column;
		}
		$this->table->fields = (object)$columns;
	    }
	    else {
		throw new Exception( " Nothing columns of {$this->table->name}. ".mysql_error() );
	    }
	}

	return $this->table->fields;
    }

    function isUpdateable($values) {
	if ( empty($values) ) {
	    throw new Exception( " Invalid Parameters " );
	}

	$valuesArray = (array)$values;
	$fieldsArray = (array)$this->getFields();

	$result = true;
	foreach ( $fieldsArray as $key => $fieldArray ) {
	    $field = (object)$fieldArray;
	    $value = isset($valuesArray[$key]) ? $valuesArray[$key] : null;

	    if ( is_null($value) ) {
		// PK は必須
		if ( strcmp($field->Key, 'PRI') == 0 ) { $result = false; }
	    }
	}

	return $result;
    }

    function getQueryValue($value) {
	$result = null;
	if ( is_null($value) ) {
	    $result = 'NULL';
	}
	elseif ( is_numeric($value) ) {
	    $result = $value;
	}
	elseif ( strtotime($value) !== false ) {
	    $result = date( 'Y-m-d H:i:s', strtotime($value) );
	}
	elseif ( is_string($value) ) {
	    $escaped = mysql_real_escape_string($value);
	    $result  = "'$escaped'"; 
	}

	if ( is_null($result) ) {
	    throw new Exception( " Could not convert to query value.  " );
	}

	return $result;
    }

    /*
     * 追加・更新 クエリ取得
     */
    function getSaveQuery($values) {
	if ( empty($values) ) {
	    throw new Exception( " Invalid Parameters " );
	}

	$valuesArray = (array)$values;

	$query = null;
	if ( !$this->isUpdateable($values) ) {
	    foreach ($valuesArray as $key => $value) {
		$qColumns[] = $key;
		$qValues[]  = $this->getQueryValue($value);
	    }
	    $qColumns[] = 'modified';
	    $qValues[]  = "now()'";
	    $qColumns[] = 'created';
	    $qValues[]  = "now()'";

	    $query = "";
	    $query .= " INSERT INTO {$this->table->name} ";
	    $query .= " ( ".implode(", ", $qColumns).") ";
	    $query .= " VALUES ( ".implode(", ", $qValues).") ";
	}
	else {
	    $qSets = null;
	    foreach ($valuesArray as $key => $value) {
		$queryValue = $this->getQueryValue($value);
		$qSets[] = " $key = $queryValue ";
	    }
	    $qSets[] = " modified = 'now()'";

	    $query = "";
	    $query .= " UPDATE {$this->table->name} ";
	    $query .= " SET ".implode(", ", $qSets);
	}

	return $query;
    }

    function begin() {
	mysql_query("begin") or die ( " Could not begin transaction. ".mysql_error() );
    }
    function commit() {
	mysql_query("commit") or die ( " Could not commit transaction. ".mysql_error() );
    }
    function rollback() {
	$resource = mysql_query("rollback");
	if ( $resource === false ) {
	    throw new Exception( "Could not rollback transaction. ".mysql_error() );
	}
    }

    function create($values) {
	if ( empty($values) ) {
	    throw new Exception( " Invalid arguments. " );
	}

	$query = $this->getSaveQuery($values);

	// クエリ実行
	$resource = mysql_query( $query );
	if ( $resource === false ) {
	    throw new Exception( " Could not save row. ".mysql_error(). " QUERY:$query " );
	}

	// 更新された ID を取得
	$id = isset($values->id) ? $values->id : null;
	if ( is_null($id) ) {
	    $id = mysql_insert_id(self::$connection);
	    if ( $id === false ) {
		throw new Exception( " Could not get inserted id. ".mysql_error() );
	    }
	}
	
	return $id;
    }
    function destroy( $values ) { }
}
?>
