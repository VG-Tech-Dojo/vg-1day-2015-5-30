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

    $botname = "bot";

    $createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));

    $uranai = function () use ($body) {
      if ($body === "uranai") {
        $result = ["daikichi", "kichi", "kyo"];
        $body = $result[rand(0,2)];
        return $body;
      } else {
        return $body;
      }
    };

    $createdMessage = $app->createMessage($botname, $uranai(), base64_encode(file_get_contents($app['icon_image_path'])));

    return $app->json($createdMessage);
});

return $app;
