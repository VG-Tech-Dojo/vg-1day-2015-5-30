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

//ここをいじる
$app->post('/messages', function (Request $request) use ($app) {
    $data = $app->validateRequestAsJson($request);

    $username = isset($data['username']) ? $data['username'] : '';
    $body = isset($data['body']) ? $data['body'] : '';

    $createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));
    
    $username = isset($data['username']) ? $data['username'] : '';
    $body = isset($data['body']) ? $data['body'] : '';

    $createdMessage = $app->createMessage("bot", $body, base64_encode(file_get_contents($app['icon_image_path'])));


    return $app->json($createdMessage);
});

return $app;
