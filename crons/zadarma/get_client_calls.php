<?php

ini_set('display_errors', 1);

$clientId = (int)$_GET['clientId'];

require 'ClientCalls.php';

$calls = (new ClientCalls($clientId))->get(empty($_GET['all']) ? 10 : 1000);

if (!$calls) {
    print 'Нет звонков';
    return;
}

print <<<HTML
<style>
.clientssummarystats img {
height: 20px;
}
</style>

<table class="clientssummarystats">
HTML;
foreach ($calls as $v) {
    if ($v['incoming']) {
        $title  = 'Клиент ⟶ '.$v['managerName'];
    } else {
        $title  = $v['managerName'].' ⟶ Клиент';
    }
    $direction = $v['incoming'] ? 'входящий' : 'исходящий';
    if ($v['duration']) {
        $download = "<a href='/crons/zadarma/download.php?file={$v['filename']}' title='Скачать'><img src='/crons/zadarma/img/download.png'></a>";
        $play = "<a href='/crons/zadarma/play.php?file={$v['filename']}' target='_blank' title='Проиграть'><img src='/crons/zadarma/img/play.jpg'></a>";
    } else {
        $download = '';
        $play = '';
    }
    print <<<HTML
<tr>
    <td>{$v['callstart']}</td>
    <td>{$title}</td>
    <td>{$v['status']}</td>
    <td>{$v['duration']}</td>
    <td>$download</td>
    <td>$play</td>
</tr>
HTML;
}

$showAll = false;
if (empty($_GET['all'])) {
    $showAll = '<p><a href="/crons/zadarma/get_client_calls.php?clientId='.$clientId.'&all=1" target="_blank">Показать все</a></p>';
}

print <<<HTML
</table>
{$showAll}
HTML;
