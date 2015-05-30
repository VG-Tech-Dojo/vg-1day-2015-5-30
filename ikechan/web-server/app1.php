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

	$result = array(
		'daikichi',
		'kichi',
		'kyou'
	);

	if ($body === 'uranai')
	{
		$body = $result[rand() % 3];
	}

    $createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));


    return $app->json($createdMessage);
});

return $app;

 function zeikomi($body) {
	if ($body === 'pokemon')
	{
		$tmp = rand() % 3;
		if(tmp == 0){
			$pokemon_img = realpath(/resource/hitokage.jpeg)
		}
	}
//	 return $nedan;
 }
