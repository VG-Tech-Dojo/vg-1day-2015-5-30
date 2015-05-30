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

		switch ($number) {
    case 0:
        $uranai = "dai-kichi";
        break;
    case 1:
        $uranai = "chu-kichi";
        break;
    case 2:
        $uranai = "sue-kichi";
        break;
    default:
        $uranai = "sho-kichi";
	}

    	$createdMessage = $app->createMessage($username, $uranai, base64_encode(file_get_contents($app['icon_image_path'])));
    }else{
    	$createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));
		$botCreateMessage = $app->createMessage("bot", $body, base64_encode(file_get_contents($app['icon_image_path'])));
    }


    return $app->json($createdMessage);
});

return $app;
