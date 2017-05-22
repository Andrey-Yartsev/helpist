{$infobox}

<!--/* BusyRack section */-->
<script type="text/javascript">
{literal}
function loadBZRemovingResult(target, ticket_id, timer_id) {
    var loading_text = '<img src="images/loading.gif" align="top" />Loading..';
    $("#tab"+target+" #tab_content #timer_list_existing_timers").html(loading_text);
    $.post("addonmodules.php?module=br_ticket_timer",
    {action: "removetimer", id:ticket_id, timer_id: timer_id, target: target},
    function(data){
        $("#tab"+target+" #tab_content #timer_list_existing_timers").html(data);
    });
}
function loadBZAddingResult(target) {
    $("#timer_save_button").attr('value', 'Saving..');
    $("#timer_save_button").attr('disabled', 'disabled');
    $.post("addonmodules.php?module=br_ticket_timer&action=addtimer",
    $("#timer_adding_form").serialize(),
    function(data){
        $("#tab"+target+" #tab_content #timer_list_existing_timers").html(data);
        $("#timer_save_button").removeAttr('disabled');
        $("#timer_save_button").attr('value', 'Add Timer');
    });
}
function loadBZSavingTemplate(target) {
    $("#template_save_button").attr('value', 'Saving..');
    $("#template_save_button").attr('disabled', 'disabled');
    $.post("addonmodules.php?module=br_ticket_timer&action=savetemplate",
    $("#timer_adding_form").serialize(),
    function(data){
        $("#tab"+target+" #tab_content #timer_list_existing_timers").html(data);
        $("#template_save_button").removeAttr('disabled');
        $("#template_save_button").attr('value', 'Save as Timer Template');
    });
}
function loadBZTab(template,target,type,offset) {
    $.post("addonmodules.php?module=br_ticket_timer&template="+template+"&target="+target,
    { action: type, id: ticketid, userid: userid,
        target: target, offset: offset },
    function(data){
        $("#tab"+target+" #tab_content").html(data);
    });
}
{/literal}
</script>
<!--/* BusyRack section */-->
  <style scoped>
   A.dot {
    text-decoration: none; /* Убираем подчеркивание */
    border-bottom: 1px dashed #000080; /* Добавляем свою линию */ 
   }
   A.dot:hover {
    color: #f00000; /* Цвет ссылки при наведении на нее курсора */
   }
  </style>
  
<!--/* AJAX ContactDate section */-->
<script type="text/javascript">
{literal}
$( document ).ready(function() {
//при любом изменении убираем пометку "сохранено" или "ошибка"
    $( "#contactDate" ).change(function() {
        $("#contactDateSuccess").css("display", "none");
        $("#contactDateError").css("display", "none");
    });
//щелчок по "Очистить"
    $( "#clearContactDate" ).click(function() {
        $("#contactDate").val("");
        //тоже очистим ошибки
        $("#contactDateSuccess").css("display", "none");
        $("#contactDateError").css("display", "none");
    });
//сохранение
    $( "#saveContactDate" ).click(function() {
    	//передаём дату в скрытое поле ввода
		$("#contactDateSend").val($("#contactDate").val());
		//очищаем дисплей сохранено/ошибка
        $("#contactDateSuccess").css("display", "none");
        $("#contactDateError").css("display", "none");
        //аякс
        $.ajax({
            url: 'addonmodules.php?module=helpisttickets&post=1',
            type: 'post',
            data: $('#contactDateForm').serialize(),
            success: function(data) {
            			var match=data.match(/%%(.*?)%%/);
            			if (match === null && typeof match === "object")
            			{
        					$("#contactDateError").css("display", "inline-block");
            			}
            			else
            			{
            			  data=$.parseJSON(match[1]);
            			  //назначаем возвращённую дату
		        	 	  $("#contactDate").val(data.date);
				          $("#contactDateSuccess").css("display", "inline-block");
				        }
                     },
            error: function(data) {
        				$("#contactDateError").css("display", "inline-block");
                     }
                     
        });
    });

});
{/literal}
</script>
<!--/* End of AJAX ContactDate section */-->

<!--/* MOD helpistnewcustomers start */-->
<script type="text/javascript">
{literal}
$( document ).ready(function() {
//при любом изменении убираем пометку "сохранено" или "ошибка"
    $( "#newCustomerNotes" ).change(function() {
        $("#newCustomerNotesSuccess").css("display", "none");
        $("#newCustomerNotesError").css("display", "none");
    });
//щелчок по "Очистить"
    $( "#clearNewCustomerNotes" ).click(function() {
        $("#newCustomerNotes").val("");
        //тоже очистим ошибки
        $("#newCustomerNotesSuccess").css("display", "none");
        $("#newCustomerNotesError").css("display", "none");
    });
//сохранение
    $( "#saveNewCustomerNotes" ).click(function() {
    	//передаём дату в скрытое поле ввода
		$("#newCustomerNotesSend").val($("#newCustomerNotes").val());
		//очищаем дисплей сохранено/ошибка
        $("#newCustomerNotesSuccess").css("display", "none");
        $("#newCustomerNotesError").css("display", "none");
        //аякс
        $.ajax({
            url: 'addonmodules.php?module=helpistnewcustomers&post=1',
            type: 'post',
            data: $('#newCustomerNotesForm').serialize(),
            success: function(data) {
            			var match=data.match(/%%(.*?)%%/);
            			if (match === null && typeof match === "object")
            			{
        					$("#newCustomerNotesError").css("display", "inline-block");
            			}
            			else
            			{
            			  //data=$.parseJSON(match[1]);
            			  //назначаем возвращённую дату
		        	 	  //$("#newCustomerNotes").val(data.date);
				          $("#newCustomerNotesSuccess").css("display", "inline-block");
				        }
                     },
            error: function(data) {
        				$("#newCustomerNotesError").css("display", "inline-block");
                     }
                     
        });
    });

});
{/literal}
</script>
<!--/* MOD helpistnewcustomers end */-->   
  
<!--/* AJAX EstimatedBudget section */-->
<script type="text/javascript">
{literal}
$( document ).ready(function() {
//при любом изменении убираем пометку "сохранено" или "ошибка"
    $( "#estimatedBudget" ).change(function() {
        $("#estimatedBudgetSuccess").css("display", "none");
        $("#estimatedBudgetError").css("display", "none");
    });
//щелчок по "Очистить"
    $( "#clearEstimatedBudget" ).click(function() {
        $("#estimatedBudget").val("");
        //тоже очистим ошибки
        $("#estimatedBudgetSuccess").css("display", "none");
        $("#estimatedBudgetError").css("display", "none");
    });
//сохранение
    $( "#saveEstimatedBudget" ).click(function() {
    	//передаём дату в скрытое поле ввода
		$("#estimatedBudgetSend").val($("#estimatedBudget").val());
		//очищаем дисплей сохранено/ошибка
        $("#estimatedBudgetSuccess").css("display", "none");
        $("#estimatedBudgetError").css("display", "none");
        //аякс
        $.ajax({
            url: 'addonmodules.php?module=helpisttickets&post=2',
            type: 'post',
            data: $('#estimatedBudgetForm').serialize(),
            success: function(data) {
            			var match=data.match(/%%(.*?)%%/);
            			if (match === null && typeof match === "object")
            			{
        					$("#estimatedBudgetError").css("display", "inline-block");
            			}
            			else
            			{
            			  data=$.parseJSON(match[1]);
            			  //назначаем возвращённую дату
		        	 	  $("#estimatedBudget").val(data.sum);
		        	 	  if (data.sum+''=='') 
			        	 	  $("#estimatedBudgetWarning").css('color','red');
		        	 	  else
			        	 	  $("#estimatedBudgetWarning").css('color','');
				          $("#estimatedBudgetSuccess").css("display", "inline-block");
				        }
                     },
            error: function(data) {
        				$("#estimatedBudgetError").css("display", "inline-block");
                     }
                     
        });
    });

});
{/literal}
</script>
<!--/* End of AJAX EstimatedBudget section */-->


{literal}
<!--/* START of EDITOR FIX section */-->
    <script type="text/javascript">
        var datepickerformat = "dd.mm.yy";
                    $(document).ready(function(){
                $(".admin-tabs").tabdrop();
var element = jQuery("#replymessage1"),
    counter = 0;
    element.attr("id","replymessage");
var replyTicketMDE = element.markdown(
    {
        footer: '<div id="replymessage-footer" class="markdown-editor-status"></div>',
        autofocus: false,
        savable: false,
        resize: 'vertical',
        iconlibrary: 'fa',
        language: 'ru_RU',
        onShow: function(e){
            var content = '',
                save_enabled = false;
            if(typeof(Storage) !== "undefined") {
                // Code for localStorage/sessionStorage.
                content = localStorage.getItem("ticket_reply_5a18d4d461d0cd7671302110b92e152a");
                save_enabled = true;
                if (content && typeof(content) !== "undefined") {
                    e.setContent(content);
                }
            }
            jQuery("#replymessage-footer").html(parseMdeFooter1(content, save_enabled, 'saved'));
        },
        onChange: function(e){
            var content = e.getContent(),
                save_enabled = false;
            if(typeof(Storage) !== "undefined") {
                counter = 3;
                save_enabled = true;
                localStorage.setItem("ticket_reply_5a18d4d461d0cd7671302110b92e152a", content);
                doCountdown();
            }
            jQuery("#replymessage-footer").html(parseMdeFooter1(content, save_enabled));
        },
        onPreview: function(e){
            var originalContent = e.getContent(),
                parsedContent;

            jQuery.ajax({
                url: '/admin/supporttickets.php',
                async: false,
                data: {token: 'ac149c19928cf970a0da9de4679e40b301607731', action: 'parseMarkdown', content: originalContent},
                success: function (data) {
                    parsedContent = data;
                }
            });

            return parsedContent.body ? parsedContent.body : '';
        },
        additionalButtons: [
            [{
                name: "groupCustom",
                data: [{
                    name: "cmdHelp",
                    title: "Help",
                    hotkey: "Ctrl+F1",
                    btnClass: "btn open-modal",
                    href: "supporttickets.php?action=markdown",
                    icon: {
                        glyph: 'glyphicons glyphicons-question-sign',
                        fa: 'fa fa-question-circle',
                        'fa-3': 'icon-question-sign'
                    },
                    callback: function(e) {
                        e.$editor.removeClass("md-fullscreen-mode");
                    },
                    additionalAttr: [
                        {
                            name: 'data-modal-title',
                            value: 'Markdown Guide'
                        },
                        {
                            name: 'data-modal-size',
                            value: 'modal-lg'
                        }
                    ]
                }]
            }]
        ]
    }
);

element.closest("form").bind({
    submit: function() {
        if(typeof(Storage) !== "undefined") {
            // Code for localStorage/sessionStorage.
            if (jQuery(this).attr('data-no-clear') == "false") {
                localStorage.removeItem("ticket_reply_5a18d4d461d0cd7671302110b92e152a");
            }
        }
    }
});
function parseMdeFooter1(content, auto_save, saveText)
{
    if (typeof saveText == 'undefined') {
        saveText = 'autosaving';
    }
    var pattern = /[a-zA-Z0-9_\u0392-\u03c9]+|[\u4E00-\u9FFF\u3400-\u4dbf\uf900-\ufaff\u3040-\u309f\uac00-\ud7af]+/g,
        m = [],
        word_count = 0,
        line_count = 0;
    if (content) {
        m = content.match(pattern);
        line_count = content.split(/\r\n|\r|\n/).length;
    }
    if (m)
    for(var i = 0; i < m.length; i++) {
        if(m[i].charCodeAt(0) >= 0x4E00) {
            word_count += m[i].length;
        } else {
            word_count += 1;
        }
    }
    return '<div class="smallfont">lines: ' + line_count
        + '&nbsp;&nbsp;&nbsp;words: ' + word_count + ''
        + (auto_save ? '&nbsp;&nbsp;&nbsp;<span class="markdown-save">' + saveText + '</span>' : '')
        + '</div>';
}

function doCountdown()
{
    if (counter >= 0) {
        if (counter == 0) {
            jQuery("span.markdown-save").html('saved');
        }
        counter--;
        setTimeout(doCountdown, 1000);
    }
}
var element = jQuery("#replynote1"),
    counter = 0;
element.attr("id","replynote");
var noteMDE = element.markdown(
    {
        footer: '<div id="replynote-footer" class="markdown-editor-status"></div>',
        autofocus: false,
        savable: false,
        resize: 'vertical',
        iconlibrary: 'fa',
        language: 'ru_RU',
        onShow: function(e){
            var content = '',
                save_enabled = false;
            if(typeof(Storage) !== "undefined") {
                // Code for localStorage/sessionStorage.
                content = localStorage.getItem("note_5a18d4d461d0cd7671302110b92e152a");
                save_enabled = true;
                if (content && typeof(content) !== "undefined") {
                    e.setContent(content);
                }
            }
            jQuery("#replynote-footer").html(parseMdeFooter1(content, save_enabled, 'saved'));
        },
        onChange: function(e){
            var content = e.getContent(),
                save_enabled = false;
            if(typeof(Storage) !== "undefined") {
                counter = 3;
                save_enabled = true;
                localStorage.setItem("note_5a18d4d461d0cd7671302110b92e152a", content);
                doCountdown();
            }
            jQuery("#replynote-footer").html(parseMdeFooter1(content, save_enabled));
        },
        onPreview: function(e){
            var originalContent = e.getContent(),
                parsedContent;

            jQuery.ajax({
                url: '/admin/supporttickets.php',
                async: false,
                data: {token: 'ac149c19928cf970a0da9de4679e40b301607731', action: 'parseMarkdown', content: originalContent},
                success: function (data) {
                    parsedContent = data;
                }
            });

            return parsedContent.body ? parsedContent.body : '';
        },
        additionalButtons: [
            [{
                name: "groupCustom",
                data: [{
                    name: "cmdHelp",
                    title: "Help",
                    hotkey: "Ctrl+F1",
                    btnClass: "btn open-modal",
                    href: "supporttickets.php?action=markdown",
                    icon: {
                        glyph: 'glyphicons glyphicons-question-sign',
                        fa: 'fa fa-question-circle',
                        'fa-3': 'icon-question-sign'
                    },
                    callback: function(e) {
                        e.$editor.removeClass("md-fullscreen-mode");
                    },
                    additionalAttr: [
                        {
                            name: 'data-modal-title',
                            value: 'Markdown Guide'
                        },
                        {
                            name: 'data-modal-size',
                            value: 'modal-lg'
                        }
                    ]
                }]
            }]
        ]
    }
);

element.closest("form").bind({
    submit: function() {
        if(typeof(Storage) !== "undefined") {
            // Code for localStorage/sessionStorage.
            if (jQuery(this).attr('data-no-clear') == "false") {
                localStorage.removeItem("note_5a18d4d461d0cd7671302110b92e152a");
            }
        }
    }
});

(function() {
    var fieldSelection = {
        addToReply: function() {
            var url = arguments[0] || '',
                title = arguments[1] || ''
                e = this.jquery ? this[0] : this,
                text = '';

            if (title != '') {
                text = '[' + title + '](' + url + ')';
            } else {
                text = url;
            }

            return (
                ('selectionStart' in e && function() {
                    if (e.value=="\n\nС уважением, Иван Жаданов") {
                        e.selectionStart=0;
                        e.selectionEnd=0;
                    }
                    e.value = e.value.substr(0, e.selectionStart) + text + e.value.substr(e.selectionEnd, e.value.length);
                    e.focus();
                    return this;
                }) ||
                (document.selection && function() {
                    e.focus();
                    document.selection.createRange().text = text;
                    return this;
                }) ||
                function() {
                    e.value += text;
                    return this;
                }
            )();
        }
    };
    jQuery.each(fieldSelection, function(i) { jQuery.fn[i] = this; });
    })();
            });
                            function insertKBLink(url, title) {
    $("#replymessage").addToReply(url, title);
}
            </script>
<!--/* END of EDITOR FIX section */-->
{/literal}

<!-- OLD STATUSES BEGIN -->
{php}
$status_count=\Illuminate\Database\Capsule\Manager::table('mod_helpistticketstatushistory')->where('ticket_id',$template->getVariable('ticketid')->__toString())->count();
$status_id=\Illuminate\Database\Capsule\Manager::table('mod_helpistticketstatushistory')->where('ticket_id',$template->getVariable('ticketid')->__toString())->
	pluck(\Illuminate\Database\Capsule\Manager::raw('MAX(id)'));
$status=\Illuminate\Database\Capsule\Manager::table('mod_helpistticketstatushistory')->where('id',$status_id)->pluck('status');
foreach ($template->getVariable('statuses')->value as $statusitem)
{
	if ($statusitem['title']==$status) 
	$template->assign('old_status_color',$statusitem['color']);
}
$template->assign('old_status_count',$status_count);
$template->assign('old_status',$status);
{/php}
<!-- OLD STATUSES END -->

<h2 class="pull-left">
    #{$tid} - {$subject}
    <select name="ticketstatus" id="ticketstatus" class="form-control select-inline">
        {foreach $statuses as $statusitem}
            <option value="{$statusitem.title}"{if $statusitem.title eq $status} selected{/if} style="color:{$statusitem.color}">{$statusitem.title}</option>
        {/foreach}
    </select>
    <a href="#" onclick="$('#ticketstatus').val('Closed');$('#ticketstatus').trigger('change');return false" style="display:none;">{$_ADMINLANG.global.close}</a>
    {if $old_status_count}<span style="font-size:small;">Пред. статус: <span style="color:{$old_status_color}">{$old_status}</span></span>{/if}
</h2>

<span class="ticketlastreply">{$_ADMINLANG.support.lastreply}: {$lastreply}</span>

<!--/* TASK DUE Start */-->
{php}
// If tasks department
if ($template->getVariable('deptid') == '2') {
	$no_due_date = TRUE;
	$color = '#7e7e7e';
	$custom_fields = $template->getVariable('customfields')->value;
	if (count ($custom_fields) > 0) {
		foreach ($custom_fields as $field) {
			if ($field['id'] == 61) {
				$due_date = $field['value'];
				$regex_date = '{literal}/^(?:(?:31(\.)(?:0?[13578]|1[02]|(?:Jan|Mar|May|Jul|Aug|Oct|Dec)))\1|(?:(?:29|30)(\.)(?:0?[1,3-9]|1[0-2]|(?:Jan|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec))\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\.)(?:0?2|(?:Feb))\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\.)(?:(?:0?[1-9]|(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep))|(?:1[0-2]|(?:Oct|Nov|Dec)))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/{/literal}';
				if (preg_match($regex_date, $due_date)) {
					$no_due_date = FALSE;
					$today_date = new DateTime('now');
					$due_date = DateTime::createFromFormat('d.m.Y', $due_date);
					if ($due_date < $today_date) $color = "#cc0000";
					elseif ($due_date == $today_date) $color = "#2421b0";
					else $color = "#779500";
				}
			}
		}
	}
	if ($no_due_date) $due_date = 'не установлен';
	else $due_date = $due_date->format ('d.m.Y');
	$due_date_text = 'Срок: '.$due_date;
	echo '<script>$(".contexthelp").text("'.$due_date_text.'"); $(".contexthelp").css("background-color", "'.$color.'");</script>';
	//echo '<div class="ticketlastreply" style="margin: -15px 0 0 0;background:'.$color.';">Срок: '.$due_date.'</div>';
}
{/php}
<!--/* TASK DUE End */-->

<div class="clearfix"></div>
<!--/* MOD helpistnewcustomers start */-->
{php}
$notes_count=\Illuminate\Database\Capsule\Manager::table('mod_helpistnewcustomers')->where('id',$template->getVariable('userid')->__toString())->count();
$notes=\Illuminate\Database\Capsule\Manager::table('mod_helpistnewcustomers')->where('id',$template->getVariable('userid')->__toString())->pluck('notes');
$template->assign('notes_count',$notes_count);
$template->assign('notes',$notes);
{/php}
{if $notes_count}
<div class="contexthelp" style="float:left;background-color: rgb(230, 230, 230);">Новый клиент<br>
<textarea rows="4" cols="100" name="newCustomerNotes" id="newCustomerNotes">{$notes}</textarea><br>
<button type="button" class="btn btn-xs btn-small btn-default" id="clearNewCustomerNotes">
                    <i class="fa fa-times"></i>
                    &nbsp;
                    Очистить
                </button>
<button type="button" class="btn btn-xs btn-small btn-default" id="saveNewCustomerNotes">
                    <i class="fa fa-floppy-o"></i>
                    &nbsp;
                    Сохранить
                </button>
<div id="newCustomerNotesSuccess" class="alert alert-success" role="alert" style="display:none;padding-top: 2px; padding-bottom: 2px;"><i class="fa fa-check" aria-hidden="true"></i> <strong>Сохранено</strong></div>
<div id="newCustomerNotesError" class="alert alert-danger" role="alert" style="display:none;padding-top: 2px; padding-bottom: 2px;"><i class="fa fa-close" aria-hidden="true"></i> <strong>Произошла ошибка!</strong></div>
</div>
<!--/* MOD helpistnewcustomers end */-->
<div class="clearfix"></div><br>
{/if}
 
<script type="text/javascript">
	  function get_client_info(clientid, adminid){
	      var clientid = clientid;
        var adminid = adminid;
	      $("#client_info").load("client_info.php", { clientid: clientid, adminid: adminid });
	  }
    function client_to_group(clientid, groupid){
        var clientid = clientid;
        var groupid = groupid;
        $("#temp").load("client_to_group.php", { clientid: clientid, groupid: groupid });
    }
    function get_client_calls(clientId) {
        $("#client_calls").load("/crons/zadarma/get_client_calls.php?clientId=" + clientId);
        $("#client_calls").toggle();
    }
</script>


{php}
    $client_id = $template->getVariable('userid');
    $query = "SELECT groupid FROM tblclients WHERE id = " . $client_id;
    $result = full_query($query);
    $data = mysql_fetch_array($result);
    $groupid = $data['groupid'];;

    global $colour;
    $query = "SELECT groupcolour FROM tblclientgroups WHERE id = " . $groupid;
    $result = full_query($query);
    $data = mysql_fetch_array($result);
    $colour = $data['groupcolour']; //echo $colour;

    echo '<span id="client_name">Клиент: <a onclick="get_client_info({$userid},'.$_SESSION['adminid'].');$(\'#client_info\').toggle();" style="background: ' . $colour . '"> {$clientname} </a></span>';
    echo ' | <a href="#" onclick="get_client_calls({$userid});" style="border-bottom:1px dotted #000">Звонки</a>';
{/php}

<div id="client_info" style="width:250px;position:absolute;z-index:9999;border:1px dashed black;display:none;"></div>
<div id="client_calls" style="width:500px;position:absolute;left:265px;z-index:9999;border:1px dashed black;display:none;"></div>

<div class="client-notes">
    {foreach $clientnotes as $note}
        <div class="panel panel-warning">
            <div class="panel-heading">
                {$note.adminuser}
                <div class="pull-right">
                    {$note.modified}
                    &nbsp;
                    <a href="clientsnotes.php?userid={$note.userid}&action=edit&id={$note.id}" class="btn btn-default btn-xs">
                        <i class="fa fa-pencil"></i>
                        {$_ADMINLANG.global.edit}
                    </a>
                </div>
            </div>
            <div class="panel-body">
                {$note.note}
            </div>
        </div>
    {/foreach}
</div>

{foreach $addons_html as $addon_html}
    <div class="addon-html-output-container">
        {$addon_html}
    </div>
{/foreach}

<div class="alert alert-info text-center{if !$replyingadmin} hidden{/if}" role="alert" id="replyingAdminMsg">
    {$replyingadmin.name} {$_ADMINLANG.support.viewedandstarted} @ {$replyingadmin.time}
</div>

<ul class="nav nav-tabs admin-tabs" role="tablist">
    <li class="active"><a href="#tab0" role="tab" data-toggle="tab">{$_ADMINLANG.support.addreply}</a></li>
    <li><a href="#tab1" role="tab" data-toggle="tab">{$_ADMINLANG.support.addnote}</a></li>
    <li><a href="#tab2" role="tab" data-toggle="tab" onclick="loadTab(2, 'customfields', 0)">{$_ADMINLANG.setup.customfields}</a></li>
    <li><a href="#tab3" role="tab" data-toggle="tab" onclick="loadTab(3, 'tickets', 0)">{$_ADMINLANG.support.clienttickets}</a></li>
    <li><a href="#tab4" role="tab" data-toggle="tab" onclick="loadTab(4, 'clientlog', 0)">{$_ADMINLANG.support.clientlog}</a></li>
    <li><a href="#tab5" role="tab" data-toggle="tab">{$_ADMINLANG.fields.options}</a></li>
    <li><a href="#tab6" role="tab" data-toggle="tab" onclick="loadTab(6, 'ticketlog', 0)">{$_ADMINLANG.support.ticketlog}</a></li>
    <!-- BusyRack section -->
    {if $timer_enabled=='yes'}
    <li><a href="#tab7" role="tab" data-toggle="tab" onclick="loadBZTab(0,7,'getlist',0)">Timer</a></li>
    {/if}
    <!-- BusyRack section -->
</ul>
<div class="tab-content admin-tabs">
  <div class="tab-pane active" id="tab0">

    <form method="post" action="{$smarty.server.PHP_SELF}?action=viewticket&id={$ticketid}" enctype="multipart/form-data" name="replyfrm" id="frmAddTicketReply" data-no-clear="true">
        <input type="hidden" name="postreply" value="1" />

        <textarea name="message" id="replymessage1" rows="14" class="form-control bottom-margin-10">{if $signature}



{$signature}{/if}</textarea>

        <div class="row ticket-reply-edit-options">
            <div class="col-sm-3">
                <select name="deptid" class="form-control selectize-select" data-value-field="id">
                    <option value="nochange" selected>- {$_ADMINLANG.support.setDepartment} -</option>
                    {foreach $departments as $department}
                        <option value="{$department.id}">{$department.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-sm-3">
                <select name="flagto" class="form-control selectize-select" data-value-field="id">
                    <option value="nochange" selected>- {$_ADMINLANG.support.setAssignment} -</option>
                    <option value="0">{$_ADMINLANG.global.none}</option>
                    {foreach $staff as $staffmember}
                        <option value="{$staffmember.id}">{$staffmember.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-sm-3">
                <select name="priority" class="form-control selectize-select" data-value-field="id">
                    <option value="nochange" selected>- {$_ADMINLANG.support.setPriority} -</option>
                    <option value="High">{$_ADMINLANG.status.high}</option>
                    <option value="Medium">{$_ADMINLANG.status.medium}</option>
                    <option value="Low">{$_ADMINLANG.status.low}</option>
                </select>
            </div>
            <div class="col-sm-3">
                <select name="status" class="form-control selectize-select" data-value-field="id">
<!-- OLD STATUSES BEGIN -->
{php}
$status=$template->getVariable('old_status_count')->__toString()==0 ? $template->getVariable('status')->value : $template->getVariable('old_status')->value;  
$template->assign('new_old_status',$status);
{/php}
                    {foreach $statuses as $statusitem}
						{if $statusitem.title ne "Answered" and $statusitem.title ne "В работе у продажника" and $statusitem.title ne "Ждем клиента"}
	                        <option value="{$statusitem.title}" style="color:{$statusitem.color}"{if $statusitem.title eq $new_old_status} selected{/if}>{$statusitem.title}</option>
						{/if}
                    {/foreach}
<!-- OLD STATUSES END -->
                </select>
            </div>
        </div>
        <div class="ticket-reply-submit-options clearfix">
            <div class="pull-left">
                <button type="button" class="btn btn-default btns-padded" id="btnAttachFiles">
                    <i class="fa fa-file-o"></i>
                    &nbsp;
                    {$_ADMINLANG.support.attachFiles}
                </button>
                <button type="button" class="btn btn-default btns-padded" id="insertpredef">
                    <i class="fa fa-pencil"></i>
                    &nbsp;
                    {$_ADMINLANG.support.insertpredef}
                </button>
                <div class="dropdown btns-padded">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMoreOptions" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        <i class="fa fa-cog"></i>
                        {$_ADMINLANG.support.moreOptions}
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMoreOptions">
                        <li><a href="#" id="btnInsertKbArticle">{$_ADMINLANG.support.insertkblink}</a></li>
                        <li style="display:none;"><a href="#" id="btnAddBillingEntry">{$_ADMINLANG.support.addbilling}</a></li>
                    </ul>
                </div>
            </div>
            <div class="pull-right">
                <button type="submit" class="btn btn-primary pull-right" name="postreply" id="btnPostReply" value="true">
                    <i class="fa fa-reply"></i>
                    {$_ADMINLANG.support.reply}
                </button>
                <div class="return-to-ticket-list">
                    <label class="checkbox-inline">
                        <input type="checkbox" name="returntolist" value="1"{if $returnToList == true} checked{/if} />
                        {$_ADMINLANG.support.returnToTicketList}
                    </label>
                </div>
            </div>
            <div class="clearfix"></div>
            <div id="ticketReplyBillingEntry" class="inner-container" style="display:block;padding:5px;">
                <table class="form" width="100%" border="0" cellspacing="2" cellpadding="3">
                    <tr>
                        <td class="fieldlabel">
                            {$_ADMINLANG.support.addbilling}
                        </td>
                        <td class="fieldarea">
                            <div class="form-inline">
                                <input type="text" name="billingdescription" size="50" placeholder="{$_ADMINLANG.support.toinvoicedes}" class="form-control" /> @ <input type="text" name="billingamount" size="10" placeholder="{$_ADMINLANG.fields.amount}" class="form-control" />
                                <select name="billingaction" class="form-control select-inline" style="display:none;">
                                    <option value="3" /> {$_ADMINLANG.billableitems.invoiceimmediately}</option>
                                    <option value="0" /> {$_ADMINLANG.billableitems.dontinvoicefornow}</option>
                                    <option value="1" /> {$_ADMINLANG.billableitems.invoicenextcronrun}</option>
                                    <option value="2" /> {$_ADMINLANG.billableitems.addnextinvoice}</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
			<div id="ticketPredefinedReplies" class="inner-container">
                <div class="predefined-replies-search">
                    <input type="text" id="predefq" size="25" value="{$_ADMINLANG.global.search}" onfocus="this.value=(this.value=='{$_ADMINLANG.global.search}') ? '' : this.value;" onblur="this.value=(this.value=='') ? '{$_ADMINLANG.global.search}' : this.value;" />
                </div>
                <div id="prerepliescontent">
                    {$predefinedreplies}
                </div>
            </div>
            <div id="ticketReplyAttachments" class="inner-container">
                <div class="row">
                    <div class="col-sm-9">
                        <input type="file" name="attachments[]" class="form-control" />
                        <div id="fileuploads"></div>
                    </div>
                    <div class="col-sm-3">
                        <a href="#" id="add-file-upload" class="btn btn-success btn-block add-file-upload" data-more-id="fileuploads"><i class="fa fa-plus"></i> {$_ADMINLANG.support.addmore}</a>
                    </div>
                </div>
            </div>
			
<!--/* Helpist PWD Start */-->
{if $userid}
<link rel="stylesheet" href="../../modules/addons/helpistpwd2/css/jBox.css">
<link rel="stylesheet" href="../../modules/addons/helpistpwd2/css/TooltipBorder.css">
<script type="text/javascript">
var openjbox=false;
</script>

<div class="row" style="padding-top:8px;"><div class="col-sm-2 fieldlabel" style="text-align:right; border-right:1px dashed #737373;">Доступы</div><div class="col-sm-10 fieldarea"><a href="addonmodules.php?module=helpistpwd2&action=view_client&client_id={$userid}">Все доступы клиента</a>
{php}
$client_id = $template->getVariable('userid');
$query = "SELECT COUNT(*) from mod_helpistpwd2 WHERE client_id = " . $client_id;
$result = full_query($query);
$data = mysql_fetch_array($result);
$sites=$data[0];
$query = "SELECT COUNT(*) from mod_helpistpwd2 INNER JOIN mod_helpistpwd2_credentials
ON site_id=mod_helpistpwd2.id
WHERE client_id = " . $client_id;
$result = full_query($query);
$data = mysql_fetch_array($result);
$creds=$data[0];
echo "<a class='dot'>[" . $creds."/".$sites . ']</a>';

{/php}
</div></div>
{/if}
<!--/* Helpist PWD End */-->

<!--/* STAFF.HELPIST.RU Start */-->
<div class="row" style="padding-top:8px;">
{php}
$panel_text = 'Панель исполнителей';
$staff_ticket_id = 0;
$custom_fields = $template->getVariable('customfields')->value;
//print_r($template->getVariable('customfields')->value);
if (count ($custom_fields) > 0) {
	foreach ($custom_fields as $field) {
		if ($field['id'] == 12) $staff_ticket_id = $field['value'];
	}
}
$staff_ticket_ids = explode(",",$staff_ticket_id);
foreach ($staff_ticket_ids as $staff_ticket_id) {
	$pattern = '{literal}/ST-(\d{6})/{/literal}';
if (preg_match($pattern, $staff_ticket_id)) {

// CREATE LINK
$link = 'http://staff.helpist.ru/scp/router.php?id=' . $staff_ticket_id;

// OST DB
$ost_host = 'localhost';
$ost_user = 'ost_user';
$ost_pass = '8Njjdhfi';
$ost_name = 'ost_db';

// GET TICKET INFO FROM OST
$mysqli_ost = new mysqli($ost_host, $ost_user, $ost_pass, $ost_name);
$mysqli_ost->set_charset("utf8");
$query = "SELECT status_id, updated FROM ost_ticket WHERE number = '" . $staff_ticket_id . "'";
$result = $mysqli_ost->query($query);
$data = $result->fetch_array();
$status_id = $data['status_id'];
$updated = $data['updated'];
if ($status_id > 0) {
	$query = "SELECT name FROM ost_ticket_status WHERE id = " . $status_id;
	$result = $mysqli_ost->query($query);
	$data = $result->fetch_array();
	$status_name = $data['name'];
}

$updated_date = new DateTime ($updated);
$updated_date->sub (new DateInterval('PT1H'));


echo '<div class="col-sm-2" style="text-align:right; border-right:1px dashed #737373;">'.$panel_text.'</div><div class="col-sm-10"><a href="' . $link . '">Задание #' . $staff_ticket_id . '</a>';
if ($status_id > 0) echo ' (Статус: ' . $status_name . ', последняя активность: ' . $updated_date->format('d.m.Y H:i') .')';
echo '</div>';
$panel_text = '&nbsp;';
}
}
{/php}
</div>

<!--/* STAFF.HELPIST.RU End */-->

<!--/* Helpist Invoices To Tickets Start*/-->
{if $userid}<div class="row" style="padding-top:8px;"><div class="col-sm-2" style="text-align:right; border-right:1px dashed #737373;">Счета по заданию</div><div class="col-sm-10">
{php}
$invoice_statuses = array(
	"Paid" => "Оплачено",
	"Cancelled" => "Отменено",
	"Unpaid" => "Не оплачено",
	"Refunded" => "Возвращено",
	"Collections" => "Инкассо"
);
$payment_methods = array(
	"rbkmoney" => "RBK Money",
	"cashless" => "Безналичный расчет",
	"banktransfer2" => "Оплата через банк",
	"yandex" => "Яндекс.Деньги",
	"webmoneyr" => "Webmoney WMR",
	"webmoneyz" => "Webmoney WMZ"
);
$first_tr = TRUE;
$tid = $template->getVariable('tid');
$table = "mod_helpistinvoicestotickets";
$fields = "id";
$where = array("tid" => $tid);
$result = select_query($table, $fields, $where);
echo '<table>';
while ($data = mysql_fetch_array($result)) {
	if ($first_tr) {
		echo '<tr><td style="padding:1px 3px;">#</td><td style="padding:1px 3px;">Дата</td><td style="padding:1px 3px;">Сумма</td><td style="padding:1px 3px;">Статус</td><td style="padding:1px 3px;">Способ оплаты</td><td>Менеджер</td></tr>';
		$first_tr = FALSE;
	}
	$invoiceid = $data['id'];

	$table = "mod_helpistpercent";
	$fields = "adminid";
	$where = array ("invoiceid" => $invoiceid);
	$result2 = select_query($table, $fields, $where);
	$data2 = mysql_fetch_array($result2);
	$adminid = $data2['adminid'];
	if ($adminid) {
		$table = "tbladmins";
		$fields = "firstname, lastname";
		$where = array ("id" => $adminid);
		$result2 = select_query($table, $fields, $where);
		$data2 = mysql_fetch_array($result2);
		$admin_name = $data2['firstname']	. ' ' . $data2['lastname'];
	}
	

	$command = "getinvoice";
	$adminuser = "admin";
	$values["invoiceid"] = $invoiceid;
	$results = localAPI($command,$values,$adminuser);
	if ($results['result'] == 'success') {
		foreach ($invoice_statuses as $eng => $rus) {
			if ($results['status'] == $eng) {
				$results['status'] = $rus;
				break;
			}
		}
		foreach ($payment_methods as $eng => $rus) {
			if ($results['paymentmethod'] == $eng) {
				$results['paymentmethod'] = $rus;
				break;
			}
		}
		echo '<tr>';
		echo '<td style="padding:1px 3px;"><a href="invoices.php?action=edit&id=' . $results['invoiceid'] . '">#' . $results['invoiceid'] . '</a></td>';
		echo '<td style="padding:1px 3px;">' . $results['date'] . '</td>';
		echo '<td style="padding:1px 3px;">' . $results['subtotal'] . ' руб.</td>';
		echo '<td style="padding:1px 3px;">' . $results['status'] . '</td>';
		echo '<td style="padding:1px 3px;">' . $results['paymentmethod'] . '</td>';
		echo '<td>';
			if ($adminid) echo $admin_name;
			else 'Нет менеджера';
		echo '</td>';
		echo '</tr>';
	}
}
echo '</table>';
{/php}

</div></div>{/if}

<!--/* Helpist Invoices To Tickets End*/-->

<!--/* Helpist Tickets' Contact Date Start*/-->
{if $userid and in_array($status,['Ждем оплату','Уточнение запроса','Согласование ТЗ','Ждем решение'])}
{php}
    $query = "SELECT contact_date FROM mod_helpisttickets_contactdate WHERE id = " . $template->getVariable('ticketid');
    $result = full_query($query);
    $data = mysql_fetch_array($result);
    $contact_date = $data['contact_date'];
    if ($contact_date) $contact_date =implode('.', array_reverse(explode('-', $contact_date)));
    $template->assign('contact_date',$contact_date);
{/php}
<div class="row" style="padding-top:8px;"><div class="col-sm-2" style="text-align:right; border-right:1px dashed #737373;">Дата контакта</div><div class="col-sm-10">
<input type="text" size="20" id="contactDate" name="contactDate" class="datepick" value="{$contact_date}"/>
<button type="button" class="btn btn-xs btn-small btn-default" id="clearContactDate">
                    <i class="fa fa-times"></i>
                    &nbsp;
                    Очистить
                </button>
<button type="button" class="btn btn-xs btn-small btn-default" id="saveContactDate">
                    <i class="fa fa-floppy-o"></i>
                    &nbsp;
                    Сохранить
                </button>
<div id="contactDateSuccess" class="alert alert-success" role="alert" style="display:none;padding-top: 2px; padding-bottom: 2px;"><i class="fa fa-check" aria-hidden="true"></i> <strong>Сохранено</strong></div>
<div id="contactDateError" class="alert alert-danger" role="alert" style="display:none;padding-top: 2px; padding-bottom: 2px;"><i class="fa fa-close" aria-hidden="true"></i> <strong>Произошла ошибка!</strong></div>
</div></div>{/if}
<!--/* Helpist Tickets' Contact Date End*/-->

<!--/* Helpist Tickets' Estimated Budget Start*/-->
{if $userid and in_array($status,['Уточнение запроса','Согласование ТЗ','Ждем решение'])}
{php}
    $query = "SELECT value FROM tblcustomfieldsvalues  WHERE fieldid=65 AND  relid= " . $template->getVariable('ticketid');
    $result = full_query($query);
    $data = mysql_fetch_array($result);
    $template->assign('estimated_budget',$data['value']);
    $template->assign('estimated_budget_red',is_null($data['value']));
{/php}
<div class="row" style="padding-top:8px;"><div id="estimatedBudgetWarning" class="col-sm-2" style="text-align:right; border-right:1px dashed #737373;{if $estimated_budget_red}color:red;{/if}">Ориентир. бюджет</div><div class="col-sm-10">
<input type="text" size="20" id="estimatedBudget" name="estimatedBudget" class="" value="{$estimated_budget}"/>
<button type="button" class="btn btn-xs btn-small btn-default" id="clearEstimatedBudget">
                    <i class="fa fa-times"></i>
                    &nbsp;
                    Очистить
                </button>
<button type="button" class="btn btn-xs btn-small btn-default" id="saveEstimatedBudget">
                    <i class="fa fa-floppy-o"></i>
                    &nbsp;
                    Сохранить
                </button>
<div id="estimatedBudgetSuccess" class="alert alert-success" role="alert" style="display:none;padding-top: 2px; padding-bottom: 2px;"><i class="fa fa-check" aria-hidden="true"></i> <strong>Сохранено</strong></div>
<div id="estimatedBudgetError" class="alert alert-danger" role="alert" style="display:none;padding-top: 2px; padding-bottom: 2px;"><i class="fa fa-close" aria-hidden="true"></i> <strong>Произошла ошибка!</strong></div>
</div></div>{/if}
<!--/* Helpist Tickets' Estimated Budget End*/-->

<!--/* Errors Start */-->

{php}

$errors = array();
$custom_fields = $template->getVariable('customfields')->value;
// CHECK TASKS CATEGORY
if ($template->getVariable('deptid') == '2') {
	$has_category = TRUE;
	if (count ($custom_fields) > 0) {
		foreach ($custom_fields as $field) {
			if ($field['id'] == 56) $task_category = $field['value'];
		}
		if ($task_category == 'Не определено' OR $task_category == '') $has_category = FALSE;
	} else $has_category = FALSE;
	if (!$has_category) $errors[] = 'Заданию не проставлена категория!';
}

// CHECK INVOICES TO NOT TASKS
if ($template->getVariable('deptid') != '2') {
	$dept_error = FALSE;
	$tid = $template->getVariable('tid');
	$table = "mod_helpistinvoicestotickets";
	$fields = "id";
	$where = array("tid" => $tid);
	$result = select_query($table, $fields, $where);
	$num_rows = mysql_num_rows($result);
	if ($num_rows >= 1) $dept_error = TRUE; 

	if (count ($custom_fields) > 0) {
		foreach ($custom_fields as $field) {
			if ($field['id'] == 12) $staff_ticket_id_2 = $field['value'];
		}
		if ($staff_ticket_id_2 > 0) $dept_error = TRUE;
	}

	if ($dept_error) $errors[] = 'Скорее всего это задание и ему нужно изменить отдел.';


}

if (count($errors) > 0) {
	echo '<div class="row" style="padding-top:8px;"><div class="col-sm-2" style="text-align:right; border-right:1px dashed #737373;">Ошибки</div><div class="col-sm-10"><span style="color:red;">';
		foreach ($errors as $error) echo $error . '<br>';
	echo '</span></div></div>';
}

{/php}

<!--/* Errors End */-->

            

        </div>

    </form>

  </div>
{if $userid}
<div id="jboxinitial" style="display:none;">
{php}
$client_id = $template->getVariable('userid')->value;
$oldget=$_GET;
$_GET['action']='view_client';
if (isset($_POST['passaction'])) $_GET['action']=$_POST['passaction'];
$_GET['client_id']=$client_id;
include('../modules/addons/helpistpwd2/helpistpwd2.php');
helpistpwd2_ajax([]);
$_GET=$oldget;
{/php}
</div>
<script src="../../modules/addons/helpistpwd2/js/jBox.min.js"></script>
<script>{literal}
var jbox = new jBox('Tooltip', {
	id:'jboxdot',
	attach: $('.dot'),
	theme: 'TooltipBorder',
	trigger: 'click',
	width: 600,
	height: 600,
	adjustTracker: true,
	adjustDistance: {top: 55, right: 5, bottom: 5, left: 5},
	closeOnClick: 'body',
	closeOnEsc: true,
	animation: 'move',
	zIndex: 8000,
	position: {
		x: 'right',
		y: 'center'
	},
	outside: 'x',
	content: 'Scroll up and down or resize your browser, I will adjust my position!<br><br>Press [ESC] or click anywhere to close.',
	onInit: function() {
		this.options.height = ($(window).height() - 200);
		var inner=$("#jboxinitial").html();
		$("#jboxinitial").html("");
		this.setContent(inner);
		if (openjbox) 	 $('.dot').click();
		
	}
});
{/literal}
</script>
{/if}  
  
<span style="display:none;">
<form method="post" id="contactDateForm">
	<input type="text" id="contactDateSend" name="contactDate" />
   <input type="text" name="contactDateId" value="{$ticketid}"/> 
</form>
<form method="post" id="estimatedBudgetForm">
	<input type="text" id="estimatedBudgetSend" name="estimatedBudget" />
   <input type="text" name="estimatedBudgetId" value="{$ticketid}"/> 
</form>
<form method="post" id="newCustomerNotesForm">
	<input type="text" id="newCustomerNotesSend" name="newCustomerNotes" />
   <input type="text" name="newCustomerNotesId" value="{$userid}"/> 
</form>
</span>
  <div class="tab-pane" id="tab1">

    <form method="post" action="{$smarty.server.PHP_SELF}?action=viewticket&id={$ticketid}" enctype="multipart/form-data" id="frmAddTicketNote" data-no-clear="true">
        <input type="hidden" name="postaction" value="note" />

        <textarea name="message" id="replynote1" rows="14" class="form-control"></textarea>

        <div class="row ticket-reply-edit-options">
            <div class="col-sm-3">
                <select name="deptid" class="form-control selectize-select" data-value-field="id">
                    <option value="nochange" selected>- {$_ADMINLANG.support.setDepartment} -</option>
                    {foreach $departments as $department}
                        <option value="{$department.id}">{$department.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-sm-3">
                <select name="flagto" class="form-control selectize-select" data-value-field="id">
                    <option value="nochange" selected>- {$_ADMINLANG.support.setAssignment} -</option>
                    <option value="0">{$_ADMINLANG.global.none}</option>
                    {foreach $staff as $staffmember}
                        <option value="{$staffmember.id}">{$staffmember.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-sm-3">
                <select name="priority" class="form-control selectize-select" data-value-field="id">
                    <option value="nochange" selected>- {$_ADMINLANG.support.setPriority} -</option>
                    <option value="High">{$_ADMINLANG.status.high}</option>
                    <option value="Medium">{$_ADMINLANG.status.medium}</option>
                    <option value="Low">{$_ADMINLANG.status.low}</option>
                </select>
            </div>
            <div class="col-sm-3">
                <select name="status" class="form-control selectize-select" data-value-field="id">
                    <option value="nochange" selected>- {$_ADMINLANG.support.setStatus} -</option>
                    {foreach $statuses as $statusitem}
                        <option value="{$statusitem.title}" style="color:{$statusitem.color}">{$statusitem.title}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="ticket-reply-submit-options clearfix">
            <div class="pull-left">
                <button type="button" class="btn btn-default btns-padded" id="btnNoteAttachFiles">
                    <i class="fa fa-file-o"></i>
                    &nbsp;
                    {$_ADMINLANG.support.attachFiles}
                </button>
            </div>
            <div class="pull-right">
                <button type="submit" class="btn btn-primary pull-right" name="postreply" id="btnAddNote">
                    <i class="fa fa-reply"></i>
                    {$_ADMINLANG.support.addnote}
                </button>
                <div class="return-to-ticket-list">
                    <label class="checkbox-inline">
                        <input type="checkbox" name="returntolist" value="1"{if $returnToList == true} checked{/if} />
                        {$_ADMINLANG.support.returnToTicketList}
                    </label>
                </div>
            </div>
            <div class="clearfix"></div>
            <div id="ticketNoteAttachments" class="inner-container">
                <div class="row">
                    <div class="col-sm-9">
                        <input type="file" name="attachments[]" class="form-control" />
                        <div id="note-file-uploads"></div>
                    </div>
                    <div class="col-sm-3">
                        <a href="#" id="add-note-file-upload" class="btn btn-success btn-block add-file-upload" data-more-id="note-file-uploads">
                            <i class="fa fa-plus"></i>
                            {$_ADMINLANG.support.addmore}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>

  </div>
  <div class="tab-pane" id="tab2">

    <img src="images/loading.gif" align="top" /> {$_ADMINLANG.global.loading}

  </div>
  <div class="tab-pane" id="tab3">

    <img src="images/loading.gif" align="top" /> {$_ADMINLANG.global.loading}

  </div>
  <div class="tab-pane" id="tab4">

    <img src="images/loading.gif" align="top" /> {$_ADMINLANG.global.loading}

  </div>
  <div class="tab-pane" id="tab5">
    <form method="post" action="{$smarty.server.PHP_SELF}?action=viewticket&id={$ticketid}">
        <table class="form" width="100%" border="0" cellspacing="2" cellpadding="3">
            <tr>
                <td width="15%" class="fieldlabel">
                    {$_ADMINLANG.support.department}
                </td>
                <td class="fieldarea">
                    <select name="deptid" class="form-control select-inline">
                        {foreach $departments as $department}
                            <option value="{$department.id}"{if $department.id eq $deptid} selected{/if}>{$department.name}</option>
                        {/foreach}
                    </select>
                </td>
                <td width="15%" class="fieldlabel">
                    {$_ADMINLANG.fields.clientid}
                </td>
                <td class="fieldarea">
                    {$userSearchDropdown}
                </td>
            </tr>
            <tr>
                <td class="fieldlabel">
                    {$_ADMINLANG.fields.subject}
                </td>
                <td class="fieldarea">
                    <input type="text" name="subject" value="{$subject}" class="form-control input-400">
                </td>
                <td class="fieldlabel">
                    {$_ADMINLANG.support.flag}
                </td>
                <td class="fieldarea">
                    <select name="flagto" class="form-control select-inline">
                        <option value="0">{$_ADMINLANG.global.none}</option>
                            {foreach $staff as $staffmember}
                                <option value="{$staffmember.id}"{if $staffmember.id eq $flag} selected{/if}>{$staffmember.name}</option>
                            {/foreach}
                    </select>
                </td>
            </tr>
            <tr>
                <td class="fieldlabel">
                    {$_ADMINLANG.fields.status}
                </td>
                <td class="fieldarea">
                    <select name="status" class="form-control select-inline">
                        {foreach from=$statuses item=statusitem}
                            <option{if $statusitem.title eq $status} selected{/if} style="color:{$statusitem.color}">{$statusitem.title}</option>
                        {/foreach}
                    </select>
                </td>
                <td class="fieldlabel">
                    {$_ADMINLANG.support.priority}
                </td>
                <td class="fieldarea">
                    <select name="priority" class="form-control select-inline">
                        <option value="High"{if $priority eq "High"} selected{/if}>{$_ADMINLANG.status.high}</option>
                        <option value="Medium"{if $priority eq "Medium"} selected{/if}>{$_ADMINLANG.status.medium}</option>
                        <option value="Low"{if $priority eq "Low"} selected{/if}>{$_ADMINLANG.status.low}</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="fieldlabel">
                    {$_ADMINLANG.support.ccrecipients}
                </td>
                <td class="fieldarea">
                    <input type="text" name="cc" value="{$cc}"  class="form-control input-300 input-inline"> ({$_ADMINLANG.transactions.commaseparated})
                </td>
                <td class="fieldlabel">
                    {$_ADMINLANG.support.mergeticket}
                </td>
                <td class="fieldarea">
                    <input type="text" name="mergetid"  class="form-control input-150 input-inline"> ({$_ADMINLANG.support.notocombine})
                </td>
            </tr>
        </table>
        <div class="btn-container">
            <input type="submit" value="{$_ADMINLANG.global.savechanges}" class="btn btn-primary" />
            <input type="reset" value="{$_ADMINLANG.global.cancelchanges}" class="btn btn-default" />
        </div>
    </form>
  </div>
  <div class="tab-pane" id="tab6">

    <img src="images/loading.gif" align="top" /> {$_ADMINLANG.global.loading}

  </div>

<!-- BusyRack section -->
  <div class="tab-pane" id="tab7">
    <div id="tab_content">
<img src="images/loading.gif" align="top" /> {$_ADMINLANG.global.loading}
    </div>
  </div>
<!-- BusyRack section -->

</div>

{if $relatedservices}
    <div class="tablebg">
        <table class="datatable" id="relatedservicestbl" width="100%" border="0" cellspacing="1" cellpadding="3">
            <tr>
                <th>{$_ADMINLANG.fields.product}</th>
                <th>{$_ADMINLANG.fields.amount}</th>
                <th>{$_ADMINLANG.fields.billingcycle}</th>
                <th>{$_ADMINLANG.fields.signupdate}</th>
                <th>{$_ADMINLANG.fields.nextduedate}</th>
                <th>{$_ADMINLANG.fields.status}</th>
            </tr>
            {foreach $relatedservices as $relatedservice}
                <tr{if $relatedservice.selected} class="rowhighlight"{/if}>
                    <td>{$relatedservice.name}</td>
                    <td>{$relatedservice.amount}</td>
                    <td>{$relatedservice.billingcycle}</td>
                    <td>{$relatedservice.regdate}</td>
                    <td>{$relatedservice.nextduedate}</td>
                    <td>{$relatedservice.status}</td>
                </tr>
            {/foreach}
        </table>
    </div>
    {if $relatedservicesexpand}
        <div id="relatedservicesexpand">
            <a href="#" onclick="expandRelServices();return false" class="btn btn-default btn-xs">
                <i class="fa fa-plus"></i>
                {$_ADMINLANG.support.expand}
            </a>
        </div>
    {/if}
{else}
    <br />
{/if}

<form method="post" action="supporttickets.php" id="ticketreplies">
    <input type="hidden" name="id" value="{$ticketid}" />
    <input type="hidden" name="action" value="split" />

    <div id="ticketreplies">

        {foreach $replies as $reply}
            <div class="reply {if $reply.note} note{elseif $reply.admin} staff{/if}">
                <div class="leftcol">
                    <div class="submitter">
                        {if $reply.admin}
                            <div class="name">{$reply.admin}</div>
                            <div class="title">
                                {if $reply.note}
                                    {$_ADMINLANG.support.privateNote}
                                {else}
                                    {$_ADMINLANG.support.staff}
                                {/if}
                            </div>
                            {if $reply.rating}
                                <br />{$reply.rating}<br /><br />
                            {/if}
                        {else}
                            <div class="name">{$reply.clientname}</div>
                            <div class="title">
                                {if $reply.contactid}
                                    {$_ADMINLANG.fields.contact}
                                {elseif $reply.userid}
                                    {$_ADMINLANG.fields.client}
                                {else}
                                    <a href="mailto:{$reply.clientemail}">{$reply.clientemail}</a>
                                {/if}
                            </div>
                            {if !$reply.userid && !$reply.contactid}
                                <a href="?action=viewticket&amp;id={$ticketid}&amp;blocksender=true&amp;token={$csrfToken}" class="btn btn-xs btn-small">{$_ADMINLANG.support.blocksender}</a>
                            {/if}
                        {/if}
                    </div>
                    <div class="tools">
                        <div class="editbtns{if $reply.id}r{$reply.id}{else}t{$ticketid}{/if}">
                            {if !$reply.note}
                                <input type="button" value="{$_ADMINLANG.global.edit}" onclick="editTicket('{if $reply.id}r{$reply.id}{else}t{$ticketid}{/if}')" class="btn btn-xs btn-small btn-default" />
                            {/if}
                            {if $deleteperm}
                                <input type="button" value="{$_ADMINLANG.global.delete}" onclick="{if $reply.id}{if $reply.note}doDeleteNote('{$reply.id}');{else}doDeleteReply('{$reply.id}');{/if}{else}doDeleteTicket();{/if}" class="btn btn-xs btn-small btn-danger" />
                            {/if}
                        </div>
                        <div class="editbtns{if $reply.id}r{$reply.id}{else}t{$ticketid}{/if}" style="display:none">
                            <input type="button" value="{$_ADMINLANG.global.save}" onclick="editTicketSave('{if $reply.id}r{$reply.id}{else}t{$ticketid}{/if}')" class="btn btn-xs btn-small btn-success" />
                            <input type="button" value="{$_ADMINLANG.global.cancel}" onclick="editTicketCancel('{if $reply.id}r{$reply.id}{else}t{$ticketid}{/if}')" class="btn btn-xs btn-small btn-default" />
                        </div>
                    </div>
                </div>
                <div class="rightcol">
                    {if !$reply.note}
                        <div class="quoteicon">
                            <a href="#" onClick="quoteTicket('{if !$reply.id}{$ticketid}{/if}','{if $reply.id}{$reply.id}{/if}')"><img src="images/icons/quote.png" border="0" /></a>
                            {if $reply.id}
                                <input type="checkbox" name="rids[]" value="{$reply.id}" />
                            {/if}
                        </div>
                    {/if}
                    <div class="postedon">
                        {if $reply.note}
                            {$reply.admin} {$_ADMINLANG.support.postedANote}
                        {else}
                            {$_ADMINLANG.support.posted}
                        {/if}
                        {if $reply.friendlydate}
                            {$_ADMINLANG.support.on} {$reply.friendlydate}
                        {else}
                            {$_ADMINLANG.support.today}
                        {/if}
                        {$_ADMINLANG.support.at} {$reply.friendlytime}
                    </div>
                    <div class="msgwrap" id="content{if $reply.id}r{$reply.id}{else}t{$ticketid}{/if}">
                        <div class="message markdown-content">
                            {$reply.message}
                        </div>
                        {if $reply.numattachments}
                            <br />
                            <strong>{$_ADMINLANG.support.attachments}</strong>
                            <br /><br />
                            {foreach $reply.attachments as $num => $attachment}
                                {if $thumbnails}
                                    <div class="ticketattachmentcontainer">
                                        <a href="../{$attachment.dllink}"{if $attachment.isImage} data-lightbox="image-{if $reply.id}{if $reply.note}n{else}r{/if}{$reply.id}{else}t{$ticketid}{/if}"{/if}><img src="../includes/thumbnail.php?{if $reply.id}{if $reply.note}nid={else}rid={/if}{$reply.id}{else}tid={$ticketid}{/if}&amp;i={$num}" class="ticketattachmentthumb" /><br />
                                            <img src="images/icons/attachment.png" align="top" />
                                            {$attachment.filename}
                                        </a>
                                        <br />
                                        <small>
                                            {if $attachment.isImage}
                                                <a href="../{$attachment.dllink}">{lang key='support.download'}</a> |
                                            {/if}
                                            <a href="{$attachment.deletelink}" onclick="return confirm('{$_ADMINLANG.support.delattachment|escape:'javascript'}')" style="color:#cc0000">
                                                {$_ADMINLANG.support.remove}
                                            </a>
                                        </small>
                                    </div>
                                {else}
                                    <a href="../{$attachment.dllink}"{if $attachment.isImage} data-lightbox="image-{if $reply.id}r{$reply.id}{else}t{$ticketid}{/if}"{/if}>
                                        <img src="images/icons/attachment.png" align="absmiddle" />
                                        {$attachment.filename}
                                    </a>
                                    <small>
                                        {if $attachment.isImage}
                                            <a href="../{$attachment.dllink}">{lang key='support.download'}</a> |
                                        {/if}
                                        <a href="{$attachment.deletelink}" onclick="return confirm('{$_ADMINLANG.support.delattachment|escape:'javascript'}')" style="color:#cc0000">
                                            {$_ADMINLANG.support.remove}
                                        </a>
                                    </small>
                                    <br />
                                {/if}
                            {/foreach}
                            <div class="clear"></div>
                        {/if}
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        {/foreach}
    </div>

    <a href="supportticketsprint.php?id={$ticketid}" target="_blank" class="btn btn-default btn-xs">
        <i class="fa fa-print"></i>
        {$_ADMINLANG.support.viewprintable}
    </a>
    {if $repliescount > 1}
        <span style="float:right;">
            <input type="button" value="{$_ADMINLANG.support.splitticketdialogbutton}" onclick="$('#modalsplitTicket').modal('show')" class="btn btn-xs" />
        </span>
    {/if}

    {$splitticketdialog}

    <input type="hidden" name="splitdeptid" id="splitdeptid" />
    <input type="hidden" name="splitsubject" id="splitsubject" />
    <input type="hidden" name="splitpriority" id="splitpriority" />
    <input type="hidden" name="splitnotifyclient" id="splitnotifyclient" />
</form>

{$statusChangedModal}

<script type="text/javascript" src="templates/{$template}/status.js"></script>

<div id="temp" style="display: none;"></div>