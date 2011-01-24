<?php
require_once('./models/model.php');
/**
 * User Data Model Class 
 */
class UserDataModel extends Model {
    
    function __construct() {
	parent::__construct();

	$this->table->name = 'user_datas';
    }

    function getRowFromFbid( $fbid ) {
# TODO:create select query function
	$query = "";
	$query .= " SELECT * FROM {$this->table->name} ";
	$query .= " WHERE fbid = {$fbid} ";

	// クエリ実行
	$resource = mysql_query( $query );
	if ( $resource === false ) {
	    throw new Exception( " Could not get $fbid row. ".mysql_error() );
	}

	$data = mysql_fetch_object( $resource );

	return $data;
    }

    function destroy($values) {
	return $count;
    }
}
?>
