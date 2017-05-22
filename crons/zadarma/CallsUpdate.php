<?php

class CallsUpdate {

    protected $client, $mysqli, $calls;

    function __construct(\Zadarma_API\Client $client) {
        $this->client = $client;
        $this->mysqli = require 'db.php';
    }

    protected function getCalls() {
        if (isset($this->calls)) return $this->calls;
        $firstDate = date("Y-m-d H:i:s", strtotime("-200 hours"));
        $today = date("Y-m-d H:i:s");
        $calls = json_decode($this->client->call('/v1/statistics/pbx/', [
            'start' => $firstDate,
            'end'   => $today
        ]));
        if ($calls->status !== 'success') throw new Exception($calls->message);
        return $this->calls = $calls->stats;
    }

    protected function updateRecords() {
        $recordedCalls = array_filter($this->getCalls(), function ($call) {
            if ($call->disposition !== 'answered') return false;
            if ($call->seconds < 3) return false;
            if ($call->is_recorded === 'false') return false;
            return true;
        });
        foreach ($recordedCalls as $call) {
            $updated = (new CallRecord($this->client, new Call($this->mysqli, $call)))->update();
            echo "Звук для call_id: $call->call_id ".($updated ? 'существует' : 'загружен');
            echo "<br/>";
        }
    }

    protected function createNewCalls() {
        foreach ($this->getCalls() as $call) {
            $call = new Call($this->mysqli, $call);
            if (!$call->exists()) {
                $call->save();
                echo "Запись call_id: $call->call_id добавилась!<br/>";
            }
        }
    }

    function update() {
        $this->createNewCalls();
        $this->updateRecords();
    }

}