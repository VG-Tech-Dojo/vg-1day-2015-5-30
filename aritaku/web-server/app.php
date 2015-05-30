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

    //bot機能を追加する
    $username = isset($data['username']) ? $data['username'] : '';
    $body = isset($data['body']) ? $data['body'] : '';

    if ($body == "uranai") {
    
    //占い機能を追加
    $input = array("大吉", "中吉", "小吉");
    $rand_keys = array_rand($input,1);

        if ($rand_keys == 1) {
            $body = "大吉";
        } else if ($rand_keys == 2) {
            $body = "中吉";
        } else if ($rand_keys == 3) {
            $body = "小吉";
        };

    $createdMessage = $app->createMessage("uranai", $body, base64_encode(file_get_contents($app['icon_image_path'])));
    
    } else {
     
    $createdMessage = $app->createMessage($username, $body, base64_encode(file_get_contents($app['icon_image_path'])));
    $createdMessage = $app->createMessage("bot", $body, base64_encode(file_get_contents($app['icon_image_path'])));
    
    };

    return $app->json($createdMessage);
});

return $app;
