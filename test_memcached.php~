<!doctype html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>memcache test</title>
</head>
<body>
<p>
<?php

$memcache = new Memcache;
$memcache->connect('localhost', 11211) or die ("接続できませんでした");

$version = $memcache->getVersion();
echo "サーバのバージョン: ".$version."<br/>\n";

$tmp_object = new stdClass;
$tmp_object->str_attr = 'test';
$tmp_object->int_attr = 123;

$memcache->set('key', $tmp_object, false, 10) or die ("データをサーバに保存できませんでした");
echo "データをキャッシュに保存します (データの有効期限は 10 秒です)<br/>\n";

$get_result = $memcache->get('key');
echo "キャッシュから取得したデータ:<br/>\n";

var_dump($get_result);

?>
</p>
</body>
</html>
