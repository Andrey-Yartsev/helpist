<?php

class CallRecord {

    protected $call, $record;

    static $zadarmaRecordFolder;

    function __construct(\Zadarma_API\Client $client, Call $call) {
        if ($call->call->is_recorded === 'false') {
            throw new Exception('Call has no record');
        }
        $this->call = $call;
        $this->record = json_decode($client->call('/v1/pbx/record/request/', [
            'call_id' => $call->call_id
        ]));
    }

    function update() {
        $r = $this->call->fetch();
        if ($r['filename']) return false;
        if (($fileName = $this->download()) === false) {
            echo "Ошибка загрузки {$this->record->link}";
            return false;
        }
        $this->call->updateFileName($fileName);
        return true;
    }

    protected function download() {
        $fileName = preg_replace('/.*\/(.+)$/', '$1', $this->record->link);
        $file = CallRecord::$zadarmaRecordFolder.'/'.$fileName;
        $success = copy($this->record->link, $file);
        if (!$success) return false;
        return $fileName;
    }

}

CallRecord::$zadarmaRecordFolder = dirname(dirname(__DIR__)).'/zadarma';