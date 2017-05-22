<?php

class Call {

    /**
     * Исходный объект с Задарма
     *
     * @var
     */
    public $call;

    public $call_id;
    public $sip;
    public $callstart;
    public $clid;
    public $destination;
    public $disposition;
    public $seconds;
    public $mysqli;

    public $call_id2;
    public $sip2;
    public $callstart2;
    public $clid2;
    public $seconds2;

    protected $r;

    public function __construct($mysqli, $call) {
        $this->mysqli = $mysqli;
        $this->init($call);
    }

    protected function init($call) {
        $this->call = $call;
        $this->call_id = htmlspecialchars($call->call_id);
        $this->sip = htmlspecialchars($call->sip);
        $this->callstart = date("Y-m-d H:i:s", strtotime($call->callstart));
        $this->clid = htmlspecialchars($call->clid);
        $this->destination = htmlspecialchars($call->destination);
        $this->disposition = htmlspecialchars($call->disposition);
        $this->seconds = (int)$call->seconds;
    }

    public function exists() {
        $results = $this->mysqli->query("SELECT COUNT(call_id) FROM `mod_helpistcalls` where call_id='$this->call_id'");
        $get_total_rows = $results->fetch_row();
        return $get_total_rows[0];
    }

    public function save() {
        $sql = "INSERT INTO `mod_helpistcalls`(`id`, `call_id`, `sip`, `callstart`, `clid`, `destination`, `disposition`, `seconds`)
               VALUES (NULL,'$this->call_id','$this->sip','$this->callstart','$this->clid','$this->destination','$this->disposition',$this->seconds)";
        $insert_row = $this->mysqli->query($sql);
        if (!$insert_row) {
            throw new Exception('Error : ('.$this->mysqli->errno.') '.$this->mysqli->error);
        }
    }

    public function fetch() {
        $results = $this->mysqli->query("SELECT * FROM `mod_helpistcalls` where call_id='$this->call_id'");
        return $results->fetch_assoc();
    }

    public function updateFileName($filename) {
        $this->mysqli->query("UPDATE `mod_helpistcalls` SET filename='$filename' WHERE call_id='$this->call_id'");
    }

    static public function noanswer() {
        $mysqli = require 'db.php';
        //
        $firstdate = date("Y-m-d H:i:s", strtotime("-75 day"));
        $enddate = date("Y-m-d H:i:s", strtotime("-15 min"));
        $results = $mysqli->query("SELECT id, call_id, CHAR_LENGTH(sip) as aaaa, sip, clid,callstart, destination, disposition, seconds FROM `mod_helpistcalls`
                                        WHERE callstart
                                        BETWEEN STR_TO_DATE('$firstdate', '%Y-%m-%d %H:%i:%s')
                                                AND STR_TO_DATE('$enddate', '%Y-%m-%d %H:%i:%s')
                                                AND disposition
                                                != 'answered' and CHAR_LENGTH(sip)>9
                                        group by sip");
        $get_total_rows = array();
        while ($row = mysqli_fetch_assoc($results)) {
            $get_total_rows[] = $row;
        }
        foreach ($get_total_rows as $item) {
            $results = $mysqli->query("SELECT COUNT(call_id) FROM `mod_helpistcallslost` where call_id='$item[0]'");
            $get_total_rows = $results->fetch_row();
            if ($get_total_rows[0] < 1) {
                $date = date("Y-m-d H:i:s", strtotime($item[5]));
                $sql = "INSERT INTO `mod_helpistcallslost`(`id`, `call_id`, `sip`, `callstart`, `clid`, `status`)
                                          VALUES (NULL,'$item[0]','$item[1]','$date','$item[3]','new')";
                $insert_row = $mysqli->query($sql);
                if (!$insert_row) {
                    die('Error : ('.$mysqli->errno.') '.$mysqli->error);
                }
            }
        }
        return "Записи добавлены";
    }

}
