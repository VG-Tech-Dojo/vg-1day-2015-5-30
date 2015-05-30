<?php

use Symfony\Component\HttpFoundation\Request;

$app = new My1DayServer\Application();
$app['debug'] = true;

$app->get('/messages', function () use ($app) {
    $messages = $app->getAllMessages();

    return $app->json($messages);
});

$app->get('/messages/{id}', function ($id) use ($app) {
    $message = $app->getMessage($id);

    return $app->json($message);
});

$app->post('/messages', function (Request $request) use ($app) {
    $data = $app->validateRequestAsJson($request);

    $username = isset($data['username']) ? $data['username'] : '';
    $body = isset($data['body']) ? $data['body'] : '';
    $uranai = isset($data['body']) ? $data['body'] : '';

    if ($uranai == "uranai") {

    	srand((double) microtime() * 100000);
		$number = rand(0,3);
		// $colorCode = ""

		switch ($number) {
    case 0:
        $uranai = "dai-kichi";
        // $colorCode = "red"
        break;
    case 1:
        $uranai = "chu-kichi";
        // $colorCode = "blue"
        break;
    case 2:
        $uranai = "sue-kichi";
        // $colorCode = "yellow"
        break;
    default:
        $uranai = "sho-kichi";
        // $colorCode = "green"
	}

    	$createdMessage = $app->createMessage($username, $uranai, $colorCode, base64_encode(file_get_contents($app['icon_image_path'])));
    }else{
    	$createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));
		$botCreateMessage = $app->createMessage("bot", $body, base64_encode(file_get_contents($app['icon_image_path'])));
    }


    return $app->json($createdMessage);
});

return $app;
