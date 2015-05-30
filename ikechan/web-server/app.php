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

	$pokemon = ['hitokage', 'hushigidane', 'zenigame'];

	$hitokage = realpath(__DIR__.'/resource/'.$pokemon[0].'.jpg');
	$hushigidane = realpath(__DIR__.'/resource/'.$pokemon[1].'.jpg');
	$zenigame = realpath(__DIR__.'/resource/'.$pokemon[2].'.jpg');

	if ($body == 'honoo')
	{
		$createdMessage = $app->createMessage($username, $pokemon[0], base64_encode(file_get_contents($hitokage)));
	} else if ($body == 'kusa') {
		$createdMessage = $app->createMessage($username, $pokemon[1], base64_encode(file_get_contents($hushigidane)));
	} else if ($body == 'mizu') {
		$createdMessage = $app->createMessage($username, $pokemon[2], base64_encode(file_get_contents($zenigame)));
	}

    // $createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));


    return $app->json($createdMessage);
});

return $app;
