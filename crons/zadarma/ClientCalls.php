<?php

class ClientCalls {

    protected $mysqli, $client, $phones;

    function __construct($clientId) {
        $this->mysqli = require 'db.php';
        $r = $this->mysqli->query("SELECT * FROM tblclients WHERE id=$clientId");
        $this->client = $r->fetch_assoc();
        if (!$this->client) {
            throw new Exception("Client not found");
        }
        if (!$this->client['phonenumber']) {
            throw new Exception("Client has no phone");
        }
        $this->phones = $this->clearPhones($this->client['phonenumber']);

    }

    protected $managers = [
        200 => 'Иван Жаданов',
        201 => 'Михаил Сабанин',
        202 => 'Павел Головкин',
        203 => 'Елена Каплич',
        205 => 'Юлия Чекель',
        400 => 'Юлия Вишер'
    ];

    protected $status = [
        'answered'    => 'отвечен',
        'call failed' => 'недозвон',
        'no answer'   => 'нет ответа',
        'busy'        => 'занято'
    ];

    protected function clearPhones($str) {
        $str = explode(',', $str);
        $result = [];
        foreach ($str as $phone) {
            $phone = preg_replace('~[^0-9]+~', '', $phone);
            if (preg_match('/^8(.+)/', $phone)) {
                $phone = preg_replace('/^8(.+)/', '7$1', $phone);
            }
            $result[] = $phone;
        }
        return $result;
    }

    protected function getProcessedCalls($limit = 1000) {
        $phonesCond = implode(', ', $this->phones);
//        $r = $this->mysqli->query("SELECT * FROM mod_helpistcalls WHERE clid IN ($phonesCond) ORDER BY callstart DESC LIMIT $limit");
        $r = $this->mysqli->query("SELECT * FROM mod_helpistcalls ORDER BY callstart DESC LIMIT $limit");
        $calls = [];
        while ($v = $r->fetch_assoc()) {
            if (strlen((int)$v['sip']) === 3) {
                $v['managerId'] = (int)$v['sip'];
                $v['incoming'] = false;
                $calls[] = $v;
            }
            if (strlen((int)$v['destination']) === 3) {
                $v['incoming'] = true;
                $v['managerId'] = (int)$v['destination'];
                $calls[] = $v;
            }
        }
        return $calls;
    }

    function get($limit) {
        $calls = $this->getProcessedCalls($limit);
        foreach ($calls as &$call) {
            $call['managerName'] = $this->managers[$call['managerId']];
            $call['status'] = $this->status[$call['disposition']];
            if ($call['disposition'] === 'answered') {
                $call['duration'] = gmdate("i:s", $call['seconds']);
            } else {
                $call['duration'] = '';
            }
        }
        return $calls;
    }

}
