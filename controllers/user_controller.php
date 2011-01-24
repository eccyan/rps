<?php
require_once('./controllers/controller.php');
require_once('./models/user_data_model.php');
require_once('./models/own_game_data_model.php');

/**
 * User Controller Class
 */
class UserController extends Controller {
    function create() {
	$model = new Model();

	// BEGIN TRANSACTION
	$model->begin();

	try {
	    /*
	     * $B%f!<%6!<%G!<%?EPO?(B
	     */
	    $userDataModel = new UserDataModel();
	    $userData = $userDataModel->getRowFromFbid( $this->fbid ); 

	    // $BEPO?:Q%f!<%6$N>l9g!"IUM?$5$l$?(B ID $B$r;HMQ$9$k(B
	    $values = new stdClass();
	    if ( !empty($userData) ) {
		$values->id = $userData->id;
	    }
	    $values->fbid      = $this->fbid;
	    $values->fbid_text = $this->fbid;
	    $values->name      = $this->me['name'] or die ( " Could not get your name. " );
	    $values->gender    = isset($this->me['gender']) ? $this->me['gender'] : null; 
	    $values->birthday  = isset($this->me['birthday']) ? $this->me['birthday'] : null; 
	    $values->link      = isset($this->me['link']) ? $this->me['link'] : null; 

	    $updatedId = $userDataModel->create( $values );

	    /*
	     * $B%2!<%`%G!<%?EPO?(B
	     */
	    $ownGameDataModel = new OwnGameDataModel();
	    $values = new stdClass();
	    $values->user_data_id = $updatedId;

	    $ownGameDataModel->create($values);
	}
	catch (Exception $e) {
	    // ROLLBACK TRANSACTION
	    $model->rollback();
	    die ( " Colud not commit transaction. Data has rollbacked. ".$e->getMessage() );
	}

	// COMMIT TRANSACTION
	$model->commit();
    }
    function destroy() {
    }
}
?>
