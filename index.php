<?php
require_once('./controllers/user_controller.php');

$userController = new UserController();
$me = $userController->me;
if ( empty($me) ) { die ( "<p>redirecting ...</p> " ); }
$userController->create();
?>
<!doctype html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>facebook auth test</title>
</head>
<body>

<div>プロフィール情報</div>
<img src="https://graph.facebook.com/<?php echo $me['id']; ?>/picture">
<?php echo $me['name']; ?>

</body>
</html>
