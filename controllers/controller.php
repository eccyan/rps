<?php
require_once('./php-sdk/src/facebook.php');
require_once('./config/config.php');


/**
 * Controller Class
 */
class Controller {
    protected static $facebook = null;  
    protected static $session = null;
    static $me = null;
    static $fbid = null;

    function __construct() {
	$facebook = new Facebook( array(
		'appId' => '182711508416132',
		'secret' => '0622e8cf9660d87e56136f32f787a390',
		'cookie' => true,
	) );

	$session = $facebook->getSession();
	if ( !$session ) {
		$url = $facebook->getLoginUrl(array(
			'canvas' => 1,
			'fbconnect' => 0,
			'req_perms' => 'status_update,publish_stream' // ステータス更新とフィードへの書き込み許可
		) );
		// アプリ未登録ユーザーなら facebook の認証ページへ遷移
		echo "<script type='text/javascript'>top.location.href = '$url';</script>"; 
		exit();
	} else {
		try {
			$fbid = $facebook->getUser(); // 自分のユーザー ID を取得
			$me   = $facebook->api('/me'); // 自分の情報を取得

			// プロフィールを取得できない場合終了
			if ( empty($fbid) ) {
			    exit();
			}
		} catch ( FacebookApiException $e ) {
			$error = "Error : something is wrong, please try again later.";
			exit();
		}
	}

	$this->facebook = $facebook;
	$this->session = $session;
	$this->me   = $me;
	$this->fbid = $fbid;
    }

    function __destruct() {
    }

}    

?>
