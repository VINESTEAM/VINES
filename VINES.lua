http = require("socket.http")
https = require("ssl.https")
JSON = dofile("./lib/dkjson.lua")
json = dofile("./lib/JSON.lua")
URL = dofile("./lib/url.lua")
serpent = dofile("./lib/serpent.lua")
redis = dofile("./lib/redis.lua").connect("127.0.0.1", 6379)
Server_VINES = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
DEV_Bot_VINES = 833156404  --- ايدي مطور السورس
------------------------------------------------------------------------------------------------------------
local function Load_File()
local f = io.open("./Info_Sudo.lua", "r")  
if not f then   
if not redis:get(Server_VINES.."Token_DevVINES") then
io.write('\n\27[1;35m᥀︙Send Token For Bot : ارسل توكن البوت ...\n\27[0;39;49m')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m᥀︙Token Is Communication Error\n التوكن غلط جرب مره اخره \n\27[0;39;49m')
else
io.write('\n\27[1;31m᥀︙Done Save Token : تم حفظ التوكن \n\27[0;39;49m')
redis:set(Server_VINES.."Token_DevVINES",token)
end 
else
io.write('\n\27[1;31m᥀︙Token was not saved \n لم يتم حفظ التوكن \n\27[0;39;49m')
end 
os.execute('lua VINES.lua')
end
------------------------------------------------------------------------------------------------------------
if not redis:get(Server_VINES.."User_DevVINES1") then
io.write('\n\27[1;35m᥀︙Send ID For Sudo : ارسل ايدي المطور الاساسي ...\n\27[0;39;49m')
local User_Sudo = io.read():gsub('@','')
if User_Sudo ~= '' then
io.write('\n\27[1;31m᥀︙The ID Is Saved : تم حفظ ايدي المطور\n\27[0;39;49m')
redis:set(Server_VINES.."Id_DevVINES",User_Sudo)
io.write('\n\27[1;35m᥀︙Send UserName For Sudo : ارسل معرف المطور الاساسي ...\n\27[0;39;49m')
local User_Sudo2 = io.read():gsub('@','')
if User_Sudo ~= '' then
redis:set(Server_VINES.."User_DevVINES1",User_Sudo2)
end
else
io.write('\n\27[1;31m᥀︙The ID was not Saved : لم يتم حفظ ايدي المطور الاساسي\n\27[0;39;49m')
end 
os.execute('lua VINES.lua')
end
------------------------------------------------------------------------------------------------------------
local DevVINES_Info_Sudo = io.open("Info_Sudo.lua", 'w')
DevVINES_Info_Sudo:write([[
do 
local VINES_INFO = {
Id_DevVINES = ]]..redis:get(Server_VINES.."Id_DevVINES")..[[,
UserName_VINES = "]]..redis:get(Server_VINES.."User_DevVINES1")..[[",
Token_Bot = "]]..redis:get(Server_VINES.."Token_DevVINES")..[["
}
return VINES_INFO
end

]])
DevVINES_Info_Sudo:close()
------------------------------------------------------------------------------------------------------------
local Run_File_VINES = io.open("VINES", 'w')
Run_File_VINES:write([[
#!/usr/bin/env bash
cd $HOME/VINES
token="]]..redis:get(Server_VINES.."Token_DevVINES")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./VINES.lua -p PROFILE --bot=$token
done
]])
Run_File_VINES:close()
------------------------------------------------------------------------------------------------------------
local Run_SM = io.open("tk", 'w')
Run_SM:write([[
#!/usr/bin/env bash
cd $HOME/VINES
while(true) do
rm -fr ../.telegram-cli
screen -S VINES -X kill
screen -S VINES ./VINES
done
]])
Run_SM:close()
io.popen("mkdir Files")
os.execute('chmod +x tg')
os.execute('chmod +x VINES')
os.execute('chmod +x tk')
os.execute('./tk')
Status = true
else   
f:close()  
redis:del(Server_VINES.."Token_DevVINES");redis:del(Server_VINES.."Id_DevVINES");redis:del(Server_VINES.."User_DevVINES1")
Status = false
end  
return Status
end
Load_File()
print("\27[36m"..[[   

]]..'\27[m')
------------------------------------------------------------------------------------------------------------
sudos = dofile("./Info_Sudo.lua")
token = sudos.Token_Bot
UserName_Dev = sudos.UserName_VINES
bot_id = token:match("(%d+)")  
Id_Dev = sudos.Id_DevVINES
Ids_Dev = {DEV_Bot_VINES,sudos.Id_DevVINES,bot_id}
Name_Bot = redis:get(bot_id.."Redis:Name:Bot") or "فاينز"
------------------------------------------------------------------------------------------------------------
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function dl_cb(arg,data)
-- var(data)  
end
------------------------------------------------------------------------------------------------------------
function Dev_VINESEnd(msg)  
local Dev_VINES = false  
for k,v in pairs(Ids_Dev) do  
if msg.sender_user_id_ == v then  
Dev_VINES = true  
end  
end  
return Dev_VINES  
end 
function Dev2Bot(msg)  
local Status = redis:sismember(bot_id.."Dev2Bot", msg.sender_user_id_) 
if Status then  
return true  
else  
return false  
end  
end
function Dev_VINES(msg)  
local Dev_VINES = false  
for k,v in pairs(Ids_Dev) do  
if Dev2Bot(msg) or  msg.sender_user_id_ == v then  
Dev_VINES = true  
end  
end  
return Dev_VINES  
end 
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end 
function Dev_VINES_User(user)  
local Dev_VINES_User = false  
for k,v in pairs(Ids_Dev) do  
if user == v then  
Dev_VINES_User = true  
end  
end  
return Dev_VINES_User  
end 
function DeveloperBot(msg)  
local Status = redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) 
if Status or Dev_VINES(msg) or Bot(msg) or Dev2Bot(msg) then  
return true  
else  
return false  
end  
end
function PresidentGroup(msg)
local hash = redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_VINES(msg) or DeveloperBot(msg) or Bot(msg) or Dev2Bot(msg) then    
return true 
else 
return false 
end 
end
function BasicBuilder(msg) 
local hash = redis:sismember(bot_id..'Basic:User'..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_VINES(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Bot(msg) or Dev2Bot(msg) then   
return true
else
return false
end 
end
function Constructor(msg) 
local hash = redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_VINES(msg) or DeveloperBot(msg) or PresidentGroup(msg) or BasicBuilder(msg) or Bot(msg) or Dev2Bot(msg) then   
return true
else
return false
end 
end
function Owner(msg) 
local hash = redis:sismember(bot_id..'Manager:Group'..msg.chat_id_,msg.sender_user_id_)
if hash or Dev_VINES(msg) or DeveloperBot(msg) or PresidentGroup(msg) or BasicBuilder(msg) or Constructor(msg) or Bot(msg) or Dev2Bot(msg) then   
return true
else
return false
end 
end
function Admin(msg) 
local hash = redis:sismember(bot_id..'Admin:Group'..msg.chat_id_,msg.sender_user_id_)
if hash or Dev_VINES(msg) or DeveloperBot(msg) or PresidentGroup(msg) or BasicBuilder(msg) or Constructor(msg) or Owner(msg) or Bot(msg) or Dev2Bot(msg) then   
return true
else
return false
end 
end
function Vips(msg) 
local hash = redis:sismember(bot_id..'Vip:Group'..msg.chat_id_,msg.sender_user_id_) 
if hash or Dev_VINES(msg) or DeveloperBot(msg) or PresidentGroup(msg) or BasicBuilder(msg) or Constructor(msg) or Owner(msg) or Admin(msg) or Bot(msg) or Dev2Bot(msg) then   
return true 
else 
return false 
end 
end
function getcustom(msg,scc)
local var = "لايوجد"
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..scc.sender_user_id_)
GeId = JSON.decode(Ge)
if GeId.result.custom_title then
var = GeId.result.custom_title
end
return var
end
function getbio(User)
local var = "لايوجد"
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchat?chat_id="..User)
data = json:decode(url)
if data.result.bio then
var = data.result.bio
end
return var
end
function GetChannelMember(msg)
local var = true 
if redis:get(bot_id..'zzzKz') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..redis:get(bot_id..'zzzKz').."&user_id="..msg.sender_user_id_)
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false 
local Text = '*᥀︙عذرا لاتستطيع استخدام البوت !\n᥀︙عليك الاشتراك في القناة اولا :*'
local Usext = redis:get(bot_id..'zzzKz'):gsub('@',"")
tdcli_function({ID = "SearchPublicChat",username_ = Usext},function(arg,data) 
local NameChat = data.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
keyboard = {} 
keyboard.inline_keyboard = {{{text =NameChat,url="t.me/"..Usext}},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
elseif data.ok then
return var
end
else
return var
end
end
------------------------------------------------------------------------------------------------------------
function Rank_Checking(user_id,chat_id)
if Dev_VINES_User(user_id) then
Status = true  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = true  
elseif redis:sismember(bot_id.."Dev2Bot", user_id) then
Status = true  
elseif redis:sismember(bot_id.."Developer:Bot", user_id) then
Status = true  
elseif redis:sismember(bot_id.."President:User"..chat_id, user_id) then
Status = true
elseif redis:sismember(bot_id.."Basic:User"..chat_id, user_id) then
Status = true
elseif redis:sismember(bot_id..'Constructor:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Manager:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Admin:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'Vip:Group'..chat_id, user_id) then  
Status = true  
else  
Status = false  
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function Get_Rank(user_id,chat_id)
if tonumber(user_id) == tonumber(DEV_Bot_VINES) then  
Status = "مطور السورس"  
elseif Dev_VINES_User(user_id) == true then
Status = "المطور الاساسي"  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = "البوت"
elseif redis:sismember(bot_id.."Dev2Bot", user_id) then
Status = "المطور الاساسي²"  
elseif redis:sismember(bot_id.."Developer:Bot", user_id) then
Status = redis:get(bot_id.."Developer:Bot:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "المطور"  
elseif redis:sismember(bot_id.."President:User"..chat_id, user_id) then
Status = redis:get(bot_id.."President:User:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "المالك"
elseif redis:sismember(bot_id.."Basic:User"..chat_id, user_id) then
Status = redis:get(bot_id.."Basic:User:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "المنشئ الاساسي"
elseif redis:sismember(bot_id..'Constructor:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Constructor:Group:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "المنشئ"  
elseif redis:sismember(bot_id..'Manager:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Manager:Group:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "المدير"  
elseif redis:sismember(bot_id..'Admin:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."Admin:Group:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "الادمن"  
elseif redis:sismember(bot_id..'Vip:Group'..chat_id, user_id) then  
Status = redis:get(bot_id.."Vip:Group:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "المميز"  
else  
Status = redis:get(bot_id.."Mempar:Group:Reply"..chat_id) or redis:get(bot_id.."Add:Validity:Users"..chat_id..user_id) or "العضو"
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function ChekBotAdd(chat_id)
if redis:sismember(bot_id.."ChekBotAdd",chat_id) then
Status = true
else 
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function MutedGroups(Chat_id,User_id) 
if redis:sismember(bot_id.."Silence:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end
function MutedGroupsval(uQuuu) 
if redis:sismember(bot_id.."Mu:User:Groups",uQuuu) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function RemovalUserGroup(Chat_id,User_id) 
if redis:sismember(bot_id.."Removal:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end 
------------------------------------------------------------------------------------------------------------
function RemovalUserGroups(User_id) 
if redis:sismember(bot_id.."Removal:User:Groups",User_id) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
------------------------------------------------------------------------------------------------------------
function Delete_Message(chat,id)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil))
end
------------------------------------------------------------------------------------------------------------
function DeleteMessage_(chat,id,func)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function getInputFile(file) 
if file:match("/") then 
infile = {ID = "InputFileLocal", 
path_ = file} 
elseif file:match("^%d+$") then 
infile = {ID = "InputFileId", 
id_ = file} 
else infile = {ID = "InputFilePersistentId", 
persistent_id_ = file} 
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function RestrictChat(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
------------------------------------------------------------------------------------------------------------
function Get_Api(Info_Web) 
local Info, Res = https.request(Info_Web) 
local Req = json:decode(Info) 
if Res ~= 200 then 
return false 
end 
if not Req.ok then 
return false 
end 
return Req 
end 
------------------------------------------------------------------------------------------------------------
function sendText(chat_id, text, reply_to_message_id, markdown) 
Status_Api = "https://api.telegram.org/bot"..token 
local Url_Api = Status_Api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
Url_Api = Url_Api .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
Url_Api = Url_Api.."&parse_mode=Markdown" 
elseif markdown == "html" then 
Url_Api = Url_Api.."&parse_mode=HTML" 
end 
return Get_Api(Url_Api)  
end
------------------------------------------------------------------------------------------------------------
function send_inline_Media(chat_id,iny,x,cx,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..token.."/"..iny.."?chat_id="..chat_id.."&"..x.."="..cx.."&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return Get_Api(send_api) 
end
function send_inline_keyboard(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local Status_Api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
Status_Api = Status_Api.."&reply_to_message_id="..reply_id 
end 
return Get_Api(Status_Api) 
end
------------------------------------------------------------------------------------------------------------
function GetInputFile(file)  
local file = file or ""   
if file:match("/") then  
infile = {ID= "InputFileLocal", path_  = file}  
elseif file:match("^%d+$") then  
infile ={ID="InputFileId",id_=file}  
else infile={ID="InputFilePersistentId",persistent_id_ = file}  
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function sendPhoto(chat_id,reply_id,photo,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ""
}
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendVoice(chat_id,reply_id,voice,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = "",
waveform_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAnimation(chat_id,reply_id,animation,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAudio(chat_id,reply_id,audio,title,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = "",
title_ = title or "",
performer_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendSticker(chat_id,reply_id,sticker,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function tdcli_update_callback_value(Data) 
url = 'https://raw.githubusercontent.com/VINESTEAM/VINES/main/VINES.lua'
file_path = 'VINES.lua'
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end
------------------------------------------------------------------------------------------------------------ 
function tdcli_update_callback_value_(Data) 
tdcli_update_callback_value(Data) 
url = 'https://raw.githubusercontent.com/VINESTEAM/VINES/main/VINES.lua'
file_path = 'VINES.lua'
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
------------------------------------------------------------------------------------------------------------
function sendVideo(chat_id,reply_id,video,caption,func)
pcall(tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendDocument(chat_id,reply_id,document,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function KickGroup(chat,user)
pcall(tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil))
end
------------------------------------------------------------------------------------------------------------
function Send_Options(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "zzzKz")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch or 'VINES'
end
if status == "Close_Status" then
send(msg.chat_id_, msg.id_,"᥀︙بواسطه -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."")
return false
end
if status == "Close_Status_Ktm" then
send(msg.chat_id_, msg.id_,"᥀︙بواسطه -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n᥀︙خاصية - الكتم 𓂅 .\n")
return false
end
if status == "Close_Status_Kick" then
send(msg.chat_id_, msg.id_,"᥀︙بواسطه -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n᥀︙خاصية - الطرد 𓂅 .\n")
return false
end
if status == "Close_Status_Kid" then
send(msg.chat_id_, msg.id_,"᥀︙بواسطه -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n᥀︙خاصية - التقييد 𓂅 .\n")
return false
end
if status == "Open_Status" then
send(msg.chat_id_, msg.id_,"᥀︙بواسطه -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply" then
send(msg.chat_id_, msg.id_,"᥀︙المستخدم -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply_Add" then
send(msg.chat_id_, msg.id_,"᥀︙بواسطه -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"᥀︙ لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
function Send_Optionspv(chat,idmsg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "zzzKz")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch
end
if status == "reply_Pv" then
send(chat,idmsg,"᥀︙المستخدم -› ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(chat,idmsg,"᥀︙ لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
------------------------------------------------------------------------------------------------------------
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'تفاعل محلو 😤' 
elseif tonumber(Message) < 200 then 
MsgText = 'تفاعلك ضعيف ليش'
elseif tonumber(Message) < 400 then 
MsgText = 'عفيه اتفاعل 😽' 
elseif tonumber(Message) < 700 then 
MsgText = 'شكد تحجي😒' 
elseif tonumber(Message) < 1200 then 
MsgText = 'ملك التفاعل 😼' 
elseif tonumber(Message) < 2000 then 
MsgText = 'موش تفاعل غنبله' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اساس لتفاعل ياب'  
elseif tonumber(Message) < 4000 then 
MsgText = 'عوف لجواهر وتفاعل بزودك' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(Message) < 5500 then 
MsgText = 'شهلتفاعل استمر يكيك' 
elseif tonumber(Message) < 7000 then 
MsgText = 'غنبله وربي 🌟' 
elseif tonumber(Message) < 9500 then 
MsgText = 'حلغوم مال تفاعل' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'تفاعل نار وشرار'  
end 
return MsgText 
end
------------------------------------------------------------------------------------------------------------
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
------------------------------------------------------------------------------------------------------------
function NotSpam(msg,Type)
if Type == "kick" then 
Send_Options(msg,msg.sender_user_id_,"reply","᥀︙قام بالتكرار هنا وتم طرده")  
KickGroup(msg.chat_id_,msg.sender_user_id_) 
return false  
end 
if Type == "del" then 
Delete_Message(msg.chat_id_,{[0] = msg.id_})
return false
end 
if Type == "keed" then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
redis:sadd(bot_id.."Keed:User:Group"..msg.chat_id_,msg.sender_user_id_) 
Send_Options(msg,msg.sender_user_id_,"reply","᥀︙قام بالتكرار هنا وتم تقييده")  
return false  
end  
if Type == "mute" then
Send_Options(msg,msg.sender_user_id_,"reply","᥀︙قام بالتكرار هنا وتم كتمه")  
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_) 
return false  
end
end  
------------------------------------------------------------------------------------------------------------
function FilesVINES(msg)
File_Bot = dofile("VINES.lua")
if File_Bot.VINES and msg then
Text_File = File_Bot.VINES(msg)
end
send(msg.chat_id_, msg.id_,Text_File)  
return false
end
function FilesVINESBot(msg)
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
Text_FileBot = dofile("Files/"..v)
if Text_FileBot.VINESFile and msg then
Text_FileBot = Text_FileBot.VINESFile(msg)
end
end
end
send(msg.chat_id_, msg.id_,Text_FileBot)  
end
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_,msg.id_,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_,'./'..ty,"تم تحويل ال mp3 الى بصمه")
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr)  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_,msg.id_,'./'..rre)
os.execute('rm -rf ./'..rre) 
end
function SetFile_Groups(msg,chat,File_id,JsonFile)
if JsonFile and not JsonFile:match('.json') then
send(chat,msg.id_,"*᥀︙عذرا الملف ليس بصيغة ال : Json*")
return false
end
-- if tonumber(JsonFile:match('(%d+)')) ~= tonumber(bot_id) then 
-- send(chat,msg.id_,"᥀︙الملف لا يتوافق مع البوت يرجى رفع ملف نسخة الكروبات الحقيفي")   
-- return false 
-- end  
local File = json:decode(https.request('https://api.telegram.org/bot'..token..'/getfile?file_id='..File_id) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,''..JsonFile) 
send(chat,msg.id_,"᥀︙جاري بدء رفع الكروبات وتحويل الخزن ...")   
local Get_Info = io.open('./'..bot_id..'.json', "r"):read('*a')
local JsonInfo = JSON.decode(Get_Info)
var(JsonInfo)  
for Id_Group,Info_Group in pairs(JsonInfo.Groups) do
redis:set(bot_id.."Status:Lock:tagservrbot"..Id_Group,true)   
list ={"Status:Lock:Bot:kick","Status:Lock:User:Name","Status:Lock:hashtak","Status:Lock:Cmd","Status:Lock:Link","Status:Lock:forward","Status:Lock:Keyboard","Status:Lock:geam","Status:Lock:Photo","Status:Lock:Animation","Status:Lock:Video","Status:Lock:Audio","Status:Lock:vico","Status:Lock:Sticker","Status:Lock:Document","Status:Lock:Unsupported","Status:Lock:Markdaun","Status:Lock:Contact","Status:Status:Lock:Spam"}
for i,v in pairs(list) do
redis:set(bot_id..v..Id_Group,"del")
end
redis:sadd(bot_id.."ChekBotAdd",Id_Group)
if Info_Group.President then
for k,Id_President in pairs(Info_Group.President) do
redis:sadd(bot_id.."President:User"..Id_Group,Id_President)
end
end
if Info_Group.President then
for k,Id_President in pairs(Info_Group.President) do
redis:sadd(bot_id.."Basic:User"..Id_Group,Id_President)
end
end
if Info_Group.Constructor then
for k,Id_Constructor in pairs(Info_Group.Constructor) do
redis:sadd(bot_id.."Constructor:Group"..Id_Group,Id_Constructor)  
end
end
if Info_Group.Manager then
for k,Id_Manager in pairs(Info_Group.Manager) do
redis:sadd(bot_id.."Manager:Group"..Id_Group,Id_Manager)  
end
end
if Info_Group.Admin then
for k,Id_Admin in pairs(Info_Group.Admin) do
redis:sadd(bot_id.."Admin:Group"..Id_Group,Id_Admin)  
end
end
if Info_Group.Vips then
for k,Id_Vips in pairs(Info_Group.Vips) do
redis:sadd(bot_id.."Vip:Group"..Id_Group,Id_Vips)  
end
end
if Info_Group.WelcomeGroup then
if Info_Group.WelcomeGroup ~= "" then
redis:set(bot_id.."Get:Welcome:Group"..Id_Group,Info_Group.WelcomeGroup)   
end
end
if Info_Group.Status_Dev then
if Info_Group.Status_Dev ~= "" then
redis:set(bot_id.."Developer:Bot:Reply"..Id_Group,Info_Group.Status_Dev)   
end
end
if Info_Group.Status_Prt then
if Info_Group.Status_Prt ~= "" then
redis:set(bot_id.."President:User:Reply"..Id_Group,Info_Group.Status_Prt)   
end
end
if Info_Group.Status_Prt then
if Info_Group.Status_Prt ~= "" then
redis:set(bot_id.."Basic:User:Reply"..Id_Group,Info_Group.Status_Prt)   
end
end
if Info_Group.Status_Cto then
if Info_Group.Status_Cto ~= "" then
redis:set(bot_id.."Constructor:Group:Reply"..Id_Group,Info_Group.Status_Cto)   
end
end
if Info_Group.Status_Own then
if Info_Group.Status_Own ~= "" then
redis:set(bot_id.."Manager:Group:Reply"..Id_Group,Info_Group.Status_Own)   
end
end
if Info_Group.Status_Md then
if Info_Group.Status_Md ~= "" then
redis:set(bot_id.."Admin:Group:Reply"..Id_Group,Info_Group.Status_Md)   
end
end
if Info_Group.Status_Vip then
if Info_Group.Status_Vip ~= "" then
redis:set(bot_id.."Vip:Group:Reply"..Id_Group,Info_Group.Status_Vip)   
end
end
if Info_Group.Status_Mem then
if Info_Group.Status_Mem ~= "" then
redis:set(bot_id.."Mempar:Group:Reply"..Id_Group,Info_Group.Status_Mem)   
end
end
if Info_Group.LinkGroup then
if Info_Group.LinkGroup ~= "" then
redis:set(bot_id.."Status:link:set:Group"..Id_Group,Info_Group.LinkGroup)   
end
end
end
send(chat,msg.id_,"᥀︙تم رفع ملف الخزن بنجاح\n᥀︙تم استرجاع جميع الكروبات ورفع المنشئين والمدراء في البوت")   
end
------------------------------------------------------------------------------------------------------------
function Dev_VINES_File(msg,data)
if msg then
msg = data.message_
text = msg.content_.text_
local function Dev2Bot(msg) 
Dev2Bot = false
local Status = redis:sismember(bot_id.."Dev2Bot", msg.sender_user_id_) 
if Status then
Dev2Bot = true  
end
if Dev_VINES(msg) == true then  
Dev2Bot = true  
end  
return Dev2Bot
end
local function DeveloperBot(msg) 
deved = false
local Status = redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) 
if Status then
deved = true  
end
if Dev_VINES(msg) == true then  
deved = true  
end  
return deved
end
function PresidentGroup(msg)
PresidentGroup = false
local hash = redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) 
if hash then 
PresidentGroup = true  
end
if Dev_VINES(msg) == true then  
PresidentGroup = true  
end
if redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) then  
PresidentGroup = true  
end 
return PresidentGroup
end
function BasicBuilder(msg)
BasicBuilder = false
local hash = redis:sismember(bot_id..'Basic:User'..msg.chat_id_, msg.sender_user_id_) 
if hash then 
BasicBuilder = true  
end
if Dev_VINES(msg) == true then  
BasicBuilder = true  
end
if redis:sismember(bot_id.."Dev2Bot", msg.sender_user_id_) then  
BasicBuilder = true  
end
if redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) then  
BasicBuilder = true  
end
if redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) then  
BasicBuilder = true  
end
return BasicBuilder
end
function Constructor(msg)
Constructor = false
local hash = redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, msg.sender_user_id_) 
if hash then 
Constructor = true  
end
if Dev_VINES(msg) == true then  
Constructor = true  
end
if redis:sismember(bot_id.."Dev2Bot", msg.sender_user_id_) then  
Constructor = true  
end
if redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) then  
Constructor = true  
end
if redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) then  
Constructor = true  
end
if redis:sismember(bot_id.."Basic:User"..msg.chat_id_, msg.sender_user_id_) then  
Constructor = true  
end
return Constructor
end
function Owner(msg)
Owner = false
local hash = redis:sismember(bot_id..'Manager:Group'..msg.chat_id_,msg.sender_user_id_)
if hash then 
Owner = true  
end
if Dev_VINES(msg) == true then  
Owner = true  
end
if redis:sismember(bot_id.."Dev2Bot", msg.sender_user_id_) then  
Owner = true  
end
if redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) then  
Owner = true  
end 
if redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) then  
Owner = true  
end
if redis:sismember(bot_id.."Basic:User"..msg.chat_id_, msg.sender_user_id_) then  
Owner = true  
end
if redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then  
Owner = true  
end
return Owner
end
function Admin(msg)
Admiin = false
local hash = redis:sismember(bot_id..'Admin:Group'..msg.chat_id_,msg.sender_user_id_)
if hash then 
Admiin = true  
end
if Dev_VINES(msg) == true then  
Admiin = true  
end
if redis:sismember(bot_id.."Dev2Bot", msg.sender_user_id_) then  
Admiin = true  
end
if redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) then  
Admiin = true  
end 
if redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) then  
Admiin = true  
end
if redis:sismember(bot_id.."Basic:User"..msg.chat_id_, msg.sender_user_id_) then  
Admiin = true  
end
if redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then  
Admiin = true  
end
if redis:sismember(bot_id..'Manager:Group'..msg.chat_id_,msg.sender_user_id_) then  
Admiin = true  
end
return Admiin 
end
function Vips(msg)
vipss = false 
local hash = redis:sismember(bot_id..'Vip:Group'..msg.chat_id_,msg.sender_user_id_) 
if hash then 
vipss = true  
end
if Dev_VINES(msg) == true then  
vipss = true  
end
if redis:sismember(bot_id.."Dev2Bot", msg.sender_user_id_) then  
vipss = true  
end
if redis:sismember(bot_id.."Developer:Bot", msg.sender_user_id_) then  
vipss = true  
end 
if redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) then  
vipss = true  
end
if redis:sismember(bot_id.."Basic:User"..msg.chat_id_, msg.sender_user_id_) then  
vipss = true  
end
if redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then  
vipss = true  
end
if redis:sismember(bot_id..'Manager:Group'..msg.chat_id_,msg.sender_user_id_) then  
vipss = true  
end
if redis:sismember(bot_id..'Admin:Group'..msg.chat_id_,msg.sender_user_id_) then   
vipss = true  
end 
if Bot(msg)  == true then   
vipss = true  
end 
return vipss
end
------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
redis:incr(bot_id..'Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) 
TypeForChat = 'ForSuppur' 
elseif id:match("^(%d+)") then
redis:sadd(bot_id..'Num:User:Pv',msg.sender_user_id_)  
TypeForChat = 'ForUser' 
else
TypeForChat = 'ForGroup' 
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Status:Lock:text"..msg.chat_id_) and not Vips(msg) then   
Delete_Message(msg.chat_id_,{[0] = msg.id_})   
return false 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(bot_id.."Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Vips(msg) then   
if redis:get(bot_id.."Status:Lock:AddMempar"..msg.chat_id_) == "kick" then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
KickGroup(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Join"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then
if redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Vips(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Vips(msg) then
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessagePhoto" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVideo" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAnimation" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAudio" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Audio"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Audio"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Audio"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Audio"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVoice" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageSticker" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageDocument" and not Vips(msg) then 
if redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Vips(msg) then  
if redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then  
if not Vips(msg) then
if redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 

if tonumber(msg.via_bot_user_id_) ~= 0 and not Vips(msg) then
if redis:get(bot_id.."Status:Lock:Inlen"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Inlen"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Inlen"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Inlen"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageContact" and not Vips(msg) then  
if redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end

--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ then  
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "del" and not Vips(msg) and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "ked" and not Vips(msg) and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "kick" and not Vips(msg) and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "ktm" and not Vips(msg) and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
if text and redis:get(bot_id..'Status:lock:Fsh'..msg.chat_id_) and not Vips(msg) then
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and redis:get(bot_id..'Status:lock:Far'..msg.chat_id_) and not Vips(msg) then
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."LoMsg"..msg.chat_id_) and not Admin(msg) then 
if msg.content_.ID == "MessagePhoto" then 
redis:sadd(bot_id..":IdMsg:"..msg.chat_id_,msg.id_)
elseif msg.content_.ID == "MessageSticker" then
redis:sadd(bot_id..":IdMsg:"..msg.chat_id_,msg.id_)
elseif msg.content_.ID == "MessageVideo" then
redis:sadd(bot_id..":IdMsg:"..msg.chat_id_,msg.id_)
elseif msg.content_.ID == "MessageAnimation" then
redis:sadd(bot_id..":IdMsg:"..msg.chat_id_,msg.id_)
elseif msg.content_.ID == "MessageUnsupported" then
redis:sadd(bot_id..":IdMsg:"..msg.chat_id_,msg.id_)
end
GetTi = redis:get(bot_id..':TiMsg:'..msg.chat_id_)
if GetTi then 
GetTi = tonumber(GetTi)
GetTi = 60*60*GetTi
end
redis:setex(bot_id..":STiMsg:"..msg.chat_id_..msg.id_,GetTi or 21600,true)  
local DoTi = redis:smembers(bot_id..":IdMsg:"..msg.chat_id_)
for k,v in pairs(DoTi) do
if not redis:get(bot_id..":STiMsg:"..msg.chat_id_..v) then
Delete_Message(msg.chat_id_, {[0] = v}) 
redis:srem(bot_id..":IdMsg:"..msg.chat_id_,v)
end
end
end
if msg.content_.ID == "MessageChatJoinByLink" then
if redis:get(bot_id.."Status:lock:kanser"..msg.chat_id_) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
local last_ = data.last_name_ or ''
local first_ = data.first_name_ or ''
local taha = (first_..''..last_)
local Num = (redis:get(bot_id..'Num:kansers'..msg.chat_id_) or 25)
if string.len(taha) > tonumber(Num) then
send(msg.chat_id_, msg.id_,'\n᥀︙الكانسر مقفول يرجى زغرفه اسمك اولاً\n ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉  ┉ ┉ ┉ ┉\n')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
end
end,nil)   
return false
end
local status_welcome = redis:get(bot_id.."Chek:Welcome"..msg.chat_id_)
if status_welcome and not redis:get(bot_id.."Status:Lock:tagservr"..msg.chat_id_) then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = redis:get(bot_id.."Get:Welcome:Group"..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = "\n• نورت حبي \n•  name \n• user" 
end 
if result.username_ then
t_user = "@"..result.username_
elseif not result.username_ then
t_user = "لا يوجد"
end 
t = t:gsub("name",result.first_name_) 
t = t:gsub("user",t_user) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
if redis:get(bot_id.."CAPTCHA"..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
captcha = math.random(4567,8907);
cap = math.random(10,50);
capt = math.random(60,90);
capc = math.random(100,500);
local Text ='• قم بختيار الرقم الصحيح الموجود في الصوره\n• ليتم الغاء تقييدك الان'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '9'..capt..'5', callback_data=capt..msg.sender_user_id_},{text =capc..'2', callback_data=capc..msg.sender_user_id_}},
{{text = '4'..cap..'8', callback_data=cap},{text = captcha, callback_data='okCaptcha'..msg.sender_user_id_}},
{{text = '1'..capt..'2', callback_data=capt},{text = '7'..capc, callback_data=capc}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://vvvzvv.ml/amir00/captcha.php?c='..captcha..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 
end 
-------------------------------------------------------
if msg.content_.ID == "MessagePinMessage" then
if Constructor(msg) or tonumber(msg.sender_user_id_) == tonumber(bot_id) then 
redis:set(bot_id.."Get:Id:Msg:Pin"..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = redis:get(bot_id.."Get:Id:Msg:Pin"..msg.chat_id_)
if Msg_Pin and redis:get(bot_id.."Status:lockpin"..msg.chat_id_) then
Pin_Message(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID ~= "MessageChatAddMembers" and redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Spam:User") and not Vips(msg) then 
if msg.sender_user_id_ ~= bot_id and not Vips(msg)  then
floods = redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Spam:User") or "nil"
Num_Msg_Max = redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
Time_Spam = redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 5
local post_count = tonumber(redis:get(bot_id.."Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_) or 0)
if post_count > tonumber(redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5) then 
local ch = msg.chat_id_
local type = redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Spam:User") 
NotSpam(msg,type)  
end
redis:setex(bot_id.."Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_, tonumber(redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 3), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam") then
Num_Msg_Max = redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam") 
end
if redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") then
Time_Spam = redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") 
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if redis:get(bot_id.."Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,"᥀︙عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا") 
redis:del(bot_id.."Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,"᥀︙ليس لدي صلاحية تغيير معلومات المجموعه يرجى المحاوله لاحقا") 
redis:del(bot_id.."Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,"᥀︙تم تغيير صورة المجموعه") 
end
end, nil) 
redis:del(bot_id.."Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
end   
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."ChekBotAdd") 
send(msg.chat_id_, msg.id_,"᥀︙تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
redis:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
redis:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
redis:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
redis:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
redis:del(bot_id.."Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء الاذاعه خاص") 
redis:del(bot_id.."Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id..'Num:User:Pv')  
send(msg.chat_id_, msg.id_,"᥀︙تمت الاذاعه الى *- "..#list.." * مشترك في البوت ") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."ChekBotAdd") 
send(msg.chat_id_, msg.id_,"᥀︙تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء الاذاعه بالتوجيه للمجموعات") 
redis:del(bot_id.."Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."ChekBotAdd")   
send(msg.chat_id_, msg.id_,"᥀︙تم التوجيه الى *- "..#list.." * مجموعه في البوت ") 
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء الاذاعه بالترجيه خاص") 
redis:del(bot_id.."Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."Num:User:Pv")   
send(msg.chat_id_, msg.id_,"᥀︙تم التوجيه الى *- "..#list.." * مجموعه في البوت ") 
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر تغير وصف المجموعه") 
redis:del(bot_id.."Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
redis:del(bot_id.."Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request("https://api.telegram.org/bot"..token.."/setChatDescription?chat_id="..msg.chat_id_.."&description="..text) 
send(msg.chat_id_, msg.id_,"᥀︙تم تغيير وصف المجموعه")   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر حفظ الترحيب") 
redis:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
redis:set(bot_id.."Get:Welcome:Group"..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"᥀︙تم حفظ ترحيب المجموعه")   
return false   
end
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Status:link:set"..msg.chat_id_..""..msg.sender_user_id_) then
if text == "الغاء" then
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر حفظ الرابط") 
redis:del(bot_id.."Status:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then 
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
redis:set(bot_id.."Status:link:set:Group"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"᥀︙تم حفظ الرابط بنجاح")   
redis:del(bot_id.."Status:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
------------------------------------------------------------------------------------------------------------
if text and not Vips(msg) then  
local Vi_Msg = redis:sismember(bot_id.."List:Filter:text"..msg.chat_id_,text) 
if Vi_Msg then    
Send_Options(msg,msg.sender_user_id_,"reply","*᥀︙الكلمه ممنوعه من المجموعه*")  
Delete_Message(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
if msg.content_.ID == 'MessageAnimation' and not Vips(msg) then  
local geAni = redis:sismember(bot_id.."List:Filter:Animation"..msg.chat_id_,msg.content_.animation_.animation_.persistent_id_) 
if geAni then        
Send_Options(msg,msg.sender_user_id_,"reply","*᥀︙المتحركه ممنوعه من المجموعه*")  
Delete_Message(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
if msg.content_.ID == 'MessageSticker' and not Vips(msg) then      
local ker = redis:sismember(bot_id.."List:Filter:Sticker"..msg.chat_id_,msg.content_.sticker_.sticker_.persistent_id_) 
if ker then        
Send_Options(msg,msg.sender_user_id_,"reply","*᥀︙الملصق ممنوع من المجموعه*")  
Delete_Message(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
if msg.content_.ID == 'MessagePhoto' and not Vips(msg) then      
local phh = redis:sismember(bot_id.."List:Filter:Photo"..msg.chat_id_,msg.content_.photo_.sizes_[1].photo_.persistent_id_) 
if phh then        
Send_Options(msg,msg.sender_user_id_,"reply","*᥀︙الصوره ممنوعه من المجموعه*")  
Delete_Message(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Change:Name:Bot"..msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر تغير اسم البوت") 
redis:del(bot_id.."Change:Name:Bot"..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."Change:Name:Bot"..msg.sender_user_id_) 
redis:set(bot_id.."Redis:Name:Bot",text) 
Name_Bot = text
send(msg.chat_id_, msg.id_, "᥀︙ تم تغير اسم البوت الى - "..text)  
return false
end 
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر اضافة صلاحيه") 
local CmdDel = redis:get(bot_id.."Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:del(bot_id.."Add:Validity:Group:Rt"..CmdDel..msg.chat_id_)
redis:srem(bot_id.."Validitys:Group"..msg.chat_id_,CmdDel)  
redis:del(bot_id.."Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 

if text == "مدير" or text == "ادمن" or text == "مميز" or text == "عضو" then
local textn = redis:get(bot_id.."Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:set(bot_id.."Add:Validity:Group:Rt"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "\n᥀︙تم اضافة الصلاحيه باسم ← { "..textn..' }') 
redis:del(bot_id.."Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر تعين الايدي") 
redis:del(bot_id.."Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
redis:set(bot_id.."Set:Id:Group"..msg.chat_id_,text:match("(.*)"))
send(msg.chat_id_, msg.id_,'᥀︙تم تعين الايدي الجديد')
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Status:Random:Sm"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Status:Set:Sma"..msg.chat_id_) then
if not redis:get(bot_id.."Status:Set:Sma"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n᥀︙لقد فزت في اللعبه \n᥀︙اللعب مره اخره وارسل - سمايل او سمايلات")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Status:Set:Sma"..msg.chat_id_,true)
return false
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Status:Klam:Speed"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Status:Speed:Tr"..msg.chat_id_) then
if not redis:get(bot_id.."Status:Speed:Tr"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n᥀︙لقد فزت في اللعبه \n᥀︙اللعب مره اخره وارسل - الاسرع او ترتيب")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Status:Speed:Tr"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Status:Klam:Hzor"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Status:Set:Hzora"..msg.chat_id_) then
if not redis:get(bot_id.."Status:Set:Hzora"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n᥀︙لقد فزت في اللعبه \n᥀︙اللعب مره اخره وارسل - حزوره")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Status:Set:Hzora"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Status:Maany"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Status:Set:Maany"..msg.chat_id_) then
if not redis:get(bot_id.."Status:Set:Maany"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n᥀︙لقد فزت في اللعبه \n᥀︙اللعب مره اخره وارسل - معاني")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Status:Set:Maany"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Status:Set:Aks:Game"..msg.chat_id_) or "").."" and not redis:get(bot_id.."Status:Set:Aks"..msg.chat_id_) then
if not redis:get(bot_id.."Status:Set:Aks"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n᥀︙لقد فزت في اللعبه \n᥀︙اللعب مره اخره وارسل - العكس")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Status:Set:Aks"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Status:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"᥀︙عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false  end 
local GETNUM = redis:get(bot_id.."Status:GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."Status:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."Status:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,"᥀︙مبروك فزت ويانه وخمنت الرقم الصحيح\n᥀︙تم اضافة { 5 } من النقاط \n")
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby(bot_id.."Status:SADD:NUM"..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(redis:get(bot_id.."Status:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)) >= 3 then
redis:del(bot_id.."Status:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."Status:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"᥀︙اوبس لقد خسرت في اللعبه \n᥀︙حظآ اوفر في المره القادمه \n᥀︙كان الرقم الذي تم تخمينه { "..GETNUM.." }")
else
send(msg.chat_id_, msg.id_,"᥀︙اوبس تخمينك غلط \n᥀︙ارسل رقم تخمنه مره اخرى ")
end
end
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Status:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"᥀︙عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false  end 
local GETNUM = redis:get(bot_id.."Status:Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."Status:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"᥀︙مبروك فزت وطلعت المحيبس بل ايد رقم { "..NUM.." }\n᥀︙لقد حصلت على { 3 }من نقاط يمكنك استبدالهن برسائل ")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:del(bot_id.."Status:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"᥀︙للاسف لقد خسرت \n᥀︙المحيبس بل ايد رقم { "..GETNUM.." }\n᥀︙حاول مره اخرى للعثور على المحيبس")
end
end
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Status::Set:Moktlf"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."Status:Set:Moktlf:Bot"..msg.chat_id_) then 
redis:del(bot_id.."Status::Set:Moktlf"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n᥀︙لقد فزت في اللعبه \n᥀︙اللعب مره اخره وارسل - المختلف")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Status:Set:Moktlf:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."Status:Set:Amth"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."Status:Set:Amth:Bot"..msg.chat_id_) then 
redis:del(bot_id.."Status:Set:Amth"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n᥀︙لقد فزت في اللعبه \n᥀︙اللعب مره اخره وارسل - امثله")
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."Status:Set:Amth:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Status:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."id:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر اضافة رسائل") 
redis:del(bot_id.."Status:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Status:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."id:user"..msg.chat_id_)  
redis:del(bot_id.."Msg_User"..msg.chat_id_..":"..msg.sender_user_id_) 
redis:incrby(bot_id.."Num:Message:Userr"..msg.chat_id_..":"..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n᥀︙تم اضافة له - "..numadded.." رسائل")  
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Status:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."idgem:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n᥀︙تم الغاء امر اضافة جواهر") 
redis:del(bot_id.."Status:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."Status:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."idgem:user"..msg.chat_id_)  
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n᥀︙تم اضافة له - "..numadded.." مجوهرات")  
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_, msg.id_, "᥀︙تم الغاء حفظ القوانين") 
redis:del(bot_id.."Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
redis:set(bot_id..":Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"᥀︙تم حفظ قوانين المجموعه") 
redis:del(bot_id.."Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id..'GetTexting:DevVINES'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' or text == 'الغاء ✖' then 
redis:del(bot_id..'GetTexting:DevVINES'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'᥀︙تم الغاء حفظ كليشة المطور')
return false
end
redis:set(bot_id..'Texting:DevVINES',text)
redis:del(bot_id..'GetTexting:DevVINES'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'᥀︙تم حفظ كليشة المطور')
send(msg.chat_id_,msg.id_,text)
return false
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_.."")
if redis:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"᥀︙تم حفظ رد للمدير بنجاح \n᥀︙ارسل ( "..test.." ) لرؤية الرد")
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n᥀︙ارسل لي الرد لاضافته\n᥀︙تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n᥀︙تستطيع ايضا اضافة :\n᥀︙`#username` » معرف المستخدم \n᥀︙`#msgs` » عدد الرسائل\n᥀︙`#name` » اسم المستخدم\n᥀︙`#id` » ايدي المستخدم\n᥀︙`#stast` » موقع المستخدم \n᥀︙`#edit` » عدد السحكات ')
redis:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
redis:set(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_) 
redis:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:sadd(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_.."") == "true2" then
send(msg.chat_id_, msg.id_,"᥀︙تم حذف الرد من ردود المدير ")
redis:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_) 
redis:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false
end
end
------------------------------------------------------------------------------------------------------------
if text and not redis:get(bot_id.."Status:Reply:Manager"..msg.chat_id_) then
if not redis:sismember(bot_id..'Spam_For_Bot'..msg.sender_user_id_,text) then
local anemi = redis:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = redis:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = redis:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_) 
local Text = redis:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = redis:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = redis:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = redis:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = redis:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsgg = redis:get(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local NumMsg =( redis:get(bot_id..'Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0 + NumMsgg)
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_,'['..Text..']')
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr)
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, document)   
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,photo_caption)
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end  
end
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"᥀︙تم حفظ رد للمطور \n᥀︙ارسل ( "..test.." ) لرؤية الرد")
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n᥀︙ارسل لي الكلمه الان \n᥀︙تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n᥀︙تستطيع ايضا اضافة :\n᥀︙`#username` » معرف المستخدم \n᥀︙`#msgs` » عدد الرسائل\n᥀︙`#name` » اسم المستخدم\n᥀︙`#id` » ايدي المستخدم\n᥀︙`#stast` » موقع المستخدم \n᥀︙`#edit` » عدد السحكات ')
redis:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
redis:set(bot_id.."Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:sadd(bot_id.."List:Rd:Sudo", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"᥀︙تم حذف الرد من ردود المطور")
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
redis:del(bot_id..''..v..text)
end
redis:del(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."List:Rd:Sudo", text)
return false
end
end
if Dev_VINES(msg) then
if text == 'نقل الاحصائيات' then
local Users = redis:smembers(bot_id.."VINES:UsersBot")
local Groups = redis:smembers(bot_id..'VINES:Chek:Groups') 
for i = 1, #Groups do
redis:sadd(bot_id..'ChekBotAdd',Groups[i])  
local list1 = redis:smembers(bot_id..'VINES:Basic:Constructor'..Groups[i])
for k,v in pairs(list1) do
redis:sadd(bot_id.."President:User"..Groups[i], v)
end
local list2 = redis:smembers(bot_id..'VINES:Constructor'..Groups[i])
for k,v in pairs(list2) do
redis:sadd(bot_id.."Constructor:Group"..Groups[i], v)
end
local list3 = redis:smembers(bot_id..'VINES:Manager'..Groups[i])
for k,v in pairs(list3) do
redis:sadd(bot_id.."Manager:Group"..Groups[i], v)
end
local list4 = redis:smembers(bot_id..'VINES:Mod:User'..Groups[i])
for k,v in pairs(list4) do
redis:sadd(bot_id.."Admin:Group"..Groups[i], v)
end
redis:set(bot_id.."Status:Lock:tagservrbot"..Groups[i],true)   
list ={"Status:Lock:Bot:kick","Status:Lock:User:Name","Status:Lock:hashtak","Status:Lock:Cmd","Status:Lock:Link","Status:Lock:forward","Status:Lock:Keyboard","Status:Lock:geam","Status:Lock:Photo","Status:Lock:Animation","Status:Lock:Video","Status:Lock:Audio","Status:Lock:vico","Status:Lock:Sticker","Status:Lock:Document","Status:Lock:Unsupported","Status:Lock:Markdaun","Status:Lock:Contact","Status:Status:Lock:Spam"}
for i,lock in pairs(list) do
redis:set(bot_id..lock..Groups[i],"del")
end
end
for i = 1, #Users do
redis:sadd(bot_id..'Num:User:Pv',Users[i])  
end
send(msg.chat_id_, msg.id_,'👥┇تم نقل : '..#Groups..' كروب\n👤┇تم نقل : '..#Users..' مشترك \n🔘┇من التحديث القديم الى التحديث الجديد')

elseif text == "تحديث الملفات 🔁" then
dofile("VINES.lua")  
send(msg.chat_id_, msg.id_, "᥀︙تم تحديث ملفات البوت")
elseif text == "تحديث" then
dofile("VINES.lua")  
send(msg.chat_id_, msg.id_, "᥀︙تم تحديث ملفات البوت")
elseif text == 'تحديث السورس 🔂' then
download_to_file('https://raw.githubusercontent.com/VINESTEAM/VINES/main/VINES.lua','VINES.lua') 
dofile("VINES.lua")  
send(msg.chat_id_, msg.id_, "᥀︙تم تحديث السورس وتنزيل اخر تحديث للملفات")
elseif text == 'تحديث السورس' then
download_to_file('https://raw.githubusercontent.com/VINESTEAM/VINES/main/VINES.lua','VINES.lua') 
dofile("VINES.lua")  
send(msg.chat_id_, msg.id_, "᥀︙تم تحديث السورس وتنزيل اخر تحديث للملفات")
end
if text == 'الملفات' then
Files = '\n᥀︙الملفات المفعله في البوت : \n ━━━━━━━━━━━━━\n'
i = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
i = i + 1
Files = Files..'*'..i..': * `'..v..'`\n'
end
end
if i == 0 then
Files = '᥀︙ لا توجد ملفات في البوت '
end
send(msg.chat_id_, msg.id_,Files)
elseif text == "متجر الملفات" or text == 'المتجر' then
local Get_Files, res = https.request("https://raw.githubusercontent.com/VINESTEAM/Files_VINES/main/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
if Get_info then
local TextS = "\n᥀︙قائمه ملفات متجر سورس VINES\n᥀︙الملفات المتوفره حاليا\n━━━━━━━━━━━━━\n\n"
local TextE = "\n━━━━━━━━━━━━━\n᥀︙علامة ← {✔} تعني الملف مفعل\n᥀︙علامة ← {❌} تعني الملف معطل\n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("Files/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "{✔}"
else
CeckFile = "{✖}"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.." : * `"..name..'` → '..CeckFile..'\n[- اضغط لرؤية معلومات الملف]('..Info..')\n'
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_,"᥀︙ لا يوجد اتصال من ال api") 
end
elseif text == "مسح جميع الملفات" then
os.execute("rm -fr Files/*")
send(msg.chat_id_,msg.id_,"᥀︙تم مسح جميع ملفات المفعله")
elseif text and text:match("^(تعطيل ملف) (.*)(.lua)$") then
local File_Get = {string.match(text, "^(تعطيل ملف) (.*)(.lua)$")}
local File_Name = File_Get[2]..'.lua'
local Get_Json, Res = https.request("https://raw.githubusercontent.com/VINESTEAM/Files_VINES/main/Files_VINES/"..File_Name)
if Res == 200 then
os.execute("rm -fr Files/"..File_Name)
send(msg.chat_id_, msg.id_,"\n᥀︙الملف ← *"..File_Name.."*\n᥀︙تم تعطيله وحذفه من البوت بنجاح") 
dofile('VINES.lua')  
else
send(msg.chat_id_, msg.id_,"᥀︙لا يوجد ملف بهاذا الاسم") 
end
elseif text and text:match("^(تفعيل ملف) (.*)(.lua)$") then
local File_Get = {string.match(text, "^(تفعيل ملف) (.*)(.lua)$")}
local File_Name = File_Get[2]..'.lua'
local Get_Json, Res = https.request("https://raw.githubusercontent.com/VINESTEAM/Files_VINES/main/Files_VINES/"..File_Name)
if Res == 200 then
local ChekAuto = io.open("Files/"..File_Name,'w+')
ChekAuto:write(Get_Json)
ChekAuto:close()
send(msg.chat_id_, msg.id_,"\n᥀︙الملف ← *"..File_Name.."*\n᥀︙تم تفعيله في البوت بنجاح") 
dofile('VINES.lua')  
else
send(msg.chat_id_, msg.id_,"᥀︙لا يوجد ملف بهاذا الاسم") 
end
return false
end
end

------------------------------------------------------------------------------------------------------------
if text and not redis:get(bot_id.."Status:Reply:Sudo"..msg.chat_id_) then
if not redis:sismember(bot_id..'Spam_For_Bot'..msg.sender_user_id_,text) then
local anemi = redis:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = redis:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = redis:get(bot_id.."Add:Rd:Sudo:stekr"..text) 
local Text = redis:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = redis:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = redis:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = redis:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = redis:get(bot_id.."Add:Rd:Sudo:Audio"..text)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsgg = redis:get(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local NumMsg =( redis:get(bot_id..'Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0 + NumMsgg)
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_,'['..Text..']')
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr) 
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, document) 
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,"")
redis:sadd(bot_id.."Spam_For_Bot"..msg.sender_user_id_,text) 
end  
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id..'Set:zzzKz') then
if text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"᥀︙تم الغاء العمليه بنجاح .") 
redis:del(bot_id..'Set:zzzKz') 
return false
end
local username = string.match(text, "@[%a%d_]+") 
tdcli_function({ID = "SearchPublicChat",username_ = username},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '᥀︙المعرف لا يوجد فيه قناة')
return false
end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '᥀︙عذا لا يمكنك وضع معرف حسابات في الاشتراك ')
return false
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'᥀︙عذا لا يمكنك وضع معرف مجموعه بالاشتراك ')
return false
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'᥀︙البوت ادمن في القناة \n᥀︙تم تفعيل الاشتراك الاجباري في \n᥀︙ايدي القناة ('..data.id_..')\n᥀︙معرف القناة ([@'..data.type_.channel_.username_..'])')
redis:del(bot_id..'Set:zzzKz') 
redis:set(bot_id.."zzzKz",'@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'᥀︙عذرآ البوت ليس ادمن بالقناه ')
end
return false  
end
end,nil)
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id..'Set:Cmd:Start:Bot') then
if text == 'الغاء ✖' then   
send(msg.chat_id_, msg.id_,"᥀︙تم الغاء حفظ كليشه امر /start") 
redis:del(bot_id..'Set:Cmd:Start:Bot') 
return false
end
redis:set(bot_id.."Set:Cmd:Start:Bot",text)  
send(msg.chat_id_, msg.id_,'᥀︙تم حفظ كليشه امر /start في البوت') 
redis:del(bot_id..'Set:Cmd:Start:Bot') 
return false
end
------------------------------------------------------------------------------------------------------------
end
if TypeForChat == ("ForUser") then
if text == '/start' and GetChannelMember(msg) then    
if Dev_VINES(msg) then
local Text_keyboard = '᥀︙اهلا بك في اوامر الكيبورد الجاهزه'
local List_keyboard = {
{'تفعيل النسخه التلقائيه ⏩','تعطيل النسخه التلقائيه ▶️'},
{'تفعيل تواصل البوت 🔔','تعطيل تواصل البوت 🔕'},
{'اذاعه خاص 👤','اذاعه للمجموعات 👥'},
{'اذاعه خاص بالتوجيه 👤','اذاعه بالتوجيه 👥'},
{'اذاعه بالتثبيت 📌'},
{'احصائيات البوت 📑'},
{'اضف اشتراك اجباري ➕','حذف اشتراك اجباري ➖'},
{'الاشتراك الاجباري ⭕'},
{'تفعيل مغادرة البوت ✔','تعطيل مغادرة البوت ❌'},
{'تفعيل اذاعه المطورين 🔓','تعطيل اذاعه المطورين 🔏'},
{'تفعيل الوضع الخدمي 🔖','تعطيل الوضع الخدمي 〽'},
{'تنظيف المجموعات 🔄','تنظيف المشتركين 🚯'},
{'مسح قائمه العام 💯','مسح قائمه المطورين 🚫'},
{'ازالة كليشه ستارت 🔗','تغير كليشه ستارت 🆕'},
{'قائمه العام 📝','قائمه المطورين 📝'},
{'تغير اسم البوت 🔄'},
{'تغير كليشة المطور 🆕','ازالة كليشة المطور 🆗'},
{'تحديث الملفات 🔁','تحديث السورس 🔂'},
{'جلب نسخة خزن الكروبات 📦'},
{'الغاء ✖'}
}
send_inline_keyboard(msg.chat_id_,Text_keyboard,List_keyboard)
else
if not redis:get(bot_id..'Ban:Cmd:Start'..msg.sender_user_id_) then
local GetCmdStart = redis:get(bot_id.."Set:Cmd:Start:Bot")  
if not GetCmdStart then 
CmdStart = '\n᥀︙أهلآ بك في بوت '..Name_Bot..''..
'\n᥀︙اختصاص البوت حماية المجموعات'..
'\n᥀︙لتفعيل البوت عليك اتباع مايلي ...'..
'\n᥀︙اضف البوت الى مجموعتك'..
'\n᥀︙ارفعه ادمن {مشرف}'..
'\n᥀︙ارسل كلمة { تفعيل } ليتم تفعيل المجموعه'..
'\n᥀︙سيتم ترقيتك منشئ اساسي في البوت'..
'\n᥀︙مطور البوت ← {['..UserName_Dev..']}'
send(msg.chat_id_, msg.id_,CmdStart) 
else
send(msg.chat_id_, msg.id_,GetCmdStart) 
end 
end
end
redis:setex(bot_id..'Ban:Cmd:Start'..msg.sender_user_id_,60,true)
return false
end
if text and text:match("^/start ph(.*)$") then
Sf = redis:get(bot_id.."Filter:msg")
local list = redis:smembers(bot_id.."List:Filter:Photo"..Sf)  
for k,v in pairs(list) do
if v then
inline = {
{{text = '- الغاء المنع .',callback_data="pito"..v}},
}
send_inline_Media(msg.chat_id_,"sendPhoto","photo",v,inline) 
end
end
if #list == 0 then
send(msg.chat_id_, msg.id_,"*᥀︙لا يوجد صور ممنوعه*")  
return false
end
Zs = {
{{text = '- اضغط هنا .',callback_data="delallph"..Sf}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_,"*᥀︙هل تريد الغاء منع كل الصور؟*",nil,Zs,msg_id) 
end  
if text and text:match("^/start msg(.*)$") then
sl = text:match("^/start msg(.*)$")
local list = redis:smembers(bot_id.."List:Filter:text"..sl)
t = "\n*᥀︙قائمة الكلمات الممنوعه*\n*─━─━─━─×─━─━─━─*\n"
for k,v in pairs(list) do
if v then
t = t..""..k.."- ["..v.."]\n"
end
end
if #list == 0 then
t = "*᥀︙لا يوجد كلمات ممنوعه*"  
end
send(msg.chat_id_, msg.id_,t)  
end  
if text and text:match("^/start gif(.*)$") then
Sf = text:match("^/start gif(.*)$")
local list = redis:smembers(bot_id.."List:Filter:Animation"..Sf)
for k,v in pairs(list) do
if v then
inline = {
{{text = '- الغاء المنع .',callback_data="animation"..v.."chatid"..Sf}},
}
send_inline_Media(msg.chat_id_,"sendanimation","animation",v,inline) 
end
end
if #list == 0 then
t = "*᥀︙لا يوجد متحركات ممنوعه*"  
send(msg.chat_id_, msg.id_,t)  
return false
end
ZsText = "*᥀︙هل تريد الغاء منع كل المتحركات؟*"
Zs = {
{{text = '- اضغط هنا .',callback_data="animationDdel"..Sf}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_,ZsText,nil,Zs,msg_id) 
end  
if text and text:match("^/start Sti(.*)$") then
Sf = text:match("^/start Sti(.*)$")
local list = redis:smembers(bot_id.."List:Filter:Sticker"..Sf)
for k,v in pairs(list) do
if v then
inline = {
{{text = '- الغاء المنع .',callback_data="Sticker"..v.."chatid"..Sf}},
}
send_inline_Media(msg.chat_id_,"sendSticker","sticker",v,inline) 
end
end
if #list == 0 then
t = "*᥀︙لا يوجد ملصقات ممنوعه*"  
send(msg.chat_id_, msg.id_,t)  
return false
end
ZsText = "*᥀︙هل تريد الغاء منع كل  الملصقات؟*"
Zs = {
{{text = '- اضغط هنا .',callback_data="delallSticker"..Sf}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_,ZsText,nil,Zs,msg_id) 
end
if not Dev_VINES(msg) and not redis:sismember(bot_id..'User:Ban:Pv',msg.sender_user_id_) and not redis:get(bot_id..'Status:Lock:Twasl') then
send(msg.sender_user_id_,msg.id_,'᥀︙تم ارسال رسالتك الى المطور ← { ['..UserName_Dev..'] }')
local List_id = {Id_Dev,msg.sender_user_id_}
for k,v in pairs(List_id) do   
tdcli_function({ID="GetChat",chat_id_=v},function(arg,chat) end,nil)
end
tdcli_function({ID="ForwardMessages",chat_id_=Id_Dev,from_chat_id_= msg.sender_user_id_,message_ids_={[0]=msg.id_},disable_notification_=1,from_background_=1},function(arg,data) 
if data and data.messages_ and data.messages_[0] ~= false and data.ID ~= "Error" then
if data and data.messages_ and data.messages_[0].content_.sticker_ then
Send_Optionspv(Id_Dev,0,msg.sender_user_id_,"reply_Pv","᥀︙قام بارسال الملصق")  
return false
end
end
end,nil)
end
if Dev_VINES(msg) then
if msg.reply_to_message_id_ ~= 0  then
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then 
UserForward = result.forward_info_.sender_user_id_
end 
if text == 'حظر' then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","᥀︙تم حظره من تواصل البوت")  
redis:sadd(bot_id..'User:Ban:Pv',data.id_)  
return false  
elseif text =='الغاء الحظر' then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","᥀︙تم الغاء حظره من تواصل البوت")  
redis:srem(bot_id..'User:Ban:Pv',data.id_)  
return false  
end 
tdcli_function({ID='GetChat',chat_id_=UserForward},function(a,s) end,nil)
tdcli_function({ID="SendChatAction",chat_id_=UserForward,action_={ID="SendMessageTypingAction",progress_=100}},function(arg,Get_Status) 
if (Get_Status.code_) == (400) or (Get_Status.code_) == (5) then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","᥀︙قام بحظر البوت لا تستطيع ارسال له رسائل")  
return false  
end 
if text then
send(UserForward,msg.id_,text)
elseif msg.content_.ID == 'MessageSticker' then
sendSticker(UserForward, msg.id_, msg.content_.sticker_.sticker_.persistent_id_)   
elseif msg.content_.ID == 'MessagePhoto' then
sendPhoto(UserForward, msg.id_,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))
elseif msg.content_.ID == 'MessageAnimation' then
sendDocument(UserForward, msg.id_, msg.content_.animation_.animation_.persistent_id_)
elseif msg.content_.ID == 'MessageVoice' then
sendVoice(UserForward, msg.id_, msg.content_.voice_.voice_.persistent_id_)
end 
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","᥀︙تم ارسال رسالتك اليه بنجاح")  
end,nil)end,nil)
end
if text == 'تغير كليشه ستارت 🆕' then
redis:set(bot_id..'Set:Cmd:Start:Bot',true) 
send(msg.chat_id_, msg.id_,'᥀︙ارسل الان الكليشه ليتم وضعها') 
elseif text == 'ازالة كليشه ستارت 🔗' then
redis:del(bot_id..'Set:Cmd:Start:Bot') 
send(msg.chat_id_, msg.id_,'᥀︙تم حذف كليشه ستارت') 
elseif text == "تفعيل مغادرة البوت ✔" then   
redis:del(bot_id.."Status:Lock:Left"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل مغادرة البوت") 
elseif text == "تعطيل مغادرة البوت ❌" then  
redis:set(bot_id.."Status:Lock:Left"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_, "᥀︙تم تعطيل مغادرة البوت") 
elseif text == "تفعيل اذاعه المطورين 🔓" then  
redis:del(bot_id.."Status:Broadcasting:Bot") 
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل الاذاعه \n᥀︙الان يمكن للمطورين الاذاعه" ) 
elseif text == "تعطيل اذاعه المطورين 🔏" then  
redis:set(bot_id.."Status:Broadcasting:Bot",true) 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الاذاعه") 
elseif text == 'تفعيل الوضع الخدمي 🔖' then  
redis:del(bot_id..'Free:Bot') 
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل البوت الخدمي \n᥀︙الان يمكن الجميع تفعيله') 
elseif text == 'تعطيل الوضع الخدمي 〽' then  
redis:set(bot_id..'Free:Bot',true) 
send(msg.chat_id_, msg.id_,'᥀︙تم تعطيل البوت الخدمي') 
elseif text == 'تغير كليشة المطور 🆕' then
redis:set(bot_id..'GetTexting:DevVINES'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'᥀︙ ارسل لي الكليشه الان')
elseif text=="اذاعه خاص 👤" then 
redis:setex(bot_id.."Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي المنشور الان\n᥀︙يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n᥀︙لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه للمجموعات 👥" then 
redis:setex(bot_id.."Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي المنشور الان\n᥀︙يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n᥀︙لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتثبيت 📌" and DeveloperBot(msg) then 
redis:setex(bot_id.."Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي المنشور الان\n᥀︙يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n᥀︙لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتوجيه 👥" and DeveloperBot(msg) then 
redis:setex(bot_id.."Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي التوجيه الان\n᥀︙ليتم نشره في المجموعات") 
return false
elseif text=="اذاعه خاص بالتوجيه 👤" and DeveloperBot(msg) then 
redis:setex(bot_id.."Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي التوجيه الان\n᥀︙ليتم نشره الى المشتركين") 
return false
elseif text == 'ازالة كليشة المطور 🆗' then
redis:del(bot_id..'Texting:DevVINES')
send(msg.chat_id_, msg.id_,'᥀︙ تم حذف كليشه المطور')
elseif text == "تغير اسم البوت 🔄" then 
redis:setex(bot_id.."Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"᥀︙ ارسل لي الاسم الان ")  
return false
elseif text == 'تفعيل النسخه التلقائيه ⏩' then
redis:del(bot_id.."AutoFile")
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل النسخه الاحتياطيه التلقائيه .") 
elseif text == "تعطيل النسخه التلقائيه ▶️" then  
redis:set(bot_id.."AutoFile",true) 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل النسخه الاحتياطيه التلقائيه .")   
elseif text == ("مسح قائمه العام 💯") or text == ("مسح المحظورين عام") then
redis:del(bot_id.."Removal:User:Groups")
send(msg.chat_id_, msg.id_, "᥀︙تم مسح المحظورين عام من البوت")
elseif text == ("مسح قائمه المطورين 🚫") then
redis:del(bot_id.."Developer:Bot")
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المطورين من البوت  ")
elseif text == ("قائمه العام 📝") or text == ("المحظورين عام") then
local list = redis:smembers(bot_id.."Removal:User:Groups")
Gban = "\n᥀︙قائمة المحظورين عام في البوت\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Gban = Gban..""..k.."~ : [@"..username.."]\n"
else
Gban = Gban..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Gban = "᥀︙لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, Gban)
elseif text == ("قائمه المطورين 📝") then
local list = redis:smembers(bot_id.."Developer:Bot")
Sudos = "\n᥀︙قائمة مطورين في البوت \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Sudos = Sudos..""..k.."~ : [@"..username.."]\n"
else
Sudos = Sudos..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Sudos = "᥀︙لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, Sudos)
elseif text and text:match("^حظر عام @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "᥀︙لا تسطيع حظر البوت عام")
return false 
end
if Dev_VINES_User(result.id_) == true then
send(msg.chat_id_, msg.id_, "᥀︙لا تستطيع حظر المطور الاساسي عام")
return false 
end
redis:sadd(bot_id.."Removal:User:Groups", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم حظره عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر عام @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^كتم عام @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "᥀︙لا تسطيع كتم البوت عام")
return false 
end
if Dev_VINES_User(result.id_) == true then
send(msg.chat_id_, msg.id_, "᥀︙لا تستطيع كتم المطور الاساسي عام")
return false 
end
redis:sadd(bot_id.."Mu:User:Groups", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم كتمه عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^كتم عام @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء العام @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","᥀︙تم الغاء حظره عام من المجموعات")  
redis:srem(bot_id.."Removal:User:Groups", result.id_)
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
elseif text and text:match("^الغاء كتم العام @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","᥀︙تم الغاء كتمه عام من المجموعات")  
redis:srem(bot_id.."Mu:User:Groups", result.id_)
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء العام @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^اضف مطور ثانوي @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Dev2Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^اضف مطور ثانوي @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^حذف مطور ثانوي @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Dev2Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المطور ثانويين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حذف مطور ثانوي @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^اضف مطور @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته مطور في البوت")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^اضف مطور @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^حذف مطور @(.*)$") then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المطورين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حذف مطور @(.*)$")}, FunctionStatus, nil)
elseif text =='احصائيات البوت 📑' then 
send(msg.chat_id_, msg.id_,'*᥀︙عدد احصائيات البوت الكامله \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n᥀︙عدد المجموعات : '..(redis:scard(bot_id..'ChekBotAdd') or 0)..'\n᥀︙عدد المشتركين : '..(redis:scard(bot_id..'Num:User:Pv') or 0)..'*')
elseif text and text:match("^تعين عدد الاعضاء (%d+)$") then
redis:set(bot_id..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg.chat_id_, msg.id_,'*᥀︙ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *')
elseif text == 'حذف كليشه المطور' then
redis:del(bot_id..'Texting:DevVINES')
send(msg.chat_id_, msg.id_,'᥀︙ تم حذف كليشه المطور')
elseif text == "تنظيف المشتركين 🚯" then
local pv = redis:smembers(bot_id..'Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'᥀︙لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*᥀︙عدد المشتركين الان ←{ '..#pv..' }\n᥀︙تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n᥀︙اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
elseif text == "تنظيف المجموعات 🔄" then
local group = redis:smembers(bot_id..'ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'᥀︙لا توجد مجموعات وهميه ')   
else
local taha = (w + q)
local sendok = #group - taha
if q == 0 then
taha = ''
else
taha = '\n᥀︙ تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
VINES = ''
else
VINES = '\n᥀︙ تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*᥀︙ عدد المجموعات الان ← { '..#group..' } مجموعه '..VINES..''..taha..'\n᥀︙اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
return false
elseif text == 'جلب نسخة خزن الكروبات 📦' then
local Groups = redis:smembers(bot_id..'ChekBotAdd')  
local Get_Json = '{"IdBot": '..bot_id..',"Groups":{'  
for k,v in pairs(Groups) do   
local President = redis:smembers(bot_id.."President:User"..v)
local BasicBuilder = redis:smembers(bot_id.."Basic:User"..v)
local Constructor = redis:smembers(bot_id.."Constructor:Group"..v)
local Manager = redis:smembers(bot_id.."Manager:Group"..v)
local Admin = redis:smembers(bot_id.."Admin:Group"..v)
local Vips = redis:smembers(bot_id.."Vip:Group"..v)
local LinkGroup = redis:get(bot_id.."Status:link:set:Group"..v) 
local WelcomeGroup = redis:get(bot_id.."Get:Welcome:Group"..v) or ''
local Status_Dev = redis:get(bot_id.."Developer:Bot:Reply"..v) 
local Status_Prt = redis:get(bot_id.."President:User:Reply"..v) 
local Status_Prx = redis:get(bot_id.."Basic:User:Reply"..v) 
local Status_Cto = redis:get(bot_id.."Constructor:Group:Reply"..v) 
local Status_Own = redis:get(bot_id.."Manager:Group:Reply"..v) 
local Status_Md = redis:get(bot_id.."Admin:Group:Reply"..v) 
local Status_Vip = redis:get(bot_id.."Vip:Group:Reply"..v) 
local Status_Mem = redis:get(bot_id.."Mempar:Group:Reply"..v) 
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if Status_Dev then
Get_Json = Get_Json..'"Status_Dev":"'..Status_Dev..'",'
end
if Status_Prt then
Get_Json = Get_Json..'"Status_Prt":"'..Status_Prt..'",'
end
if Status_Cto then
Get_Json = Get_Json..'"Status_Cto":"'..Status_Cto..'",'
end
if Status_Own then
Get_Json = Get_Json..'"Status_Own":"'..Status_Own..'",'
end
if Status_Md then
Get_Json = Get_Json..'"Status_Md":"'..Status_Md..'",'
end
if Status_Vip then
Get_Json = Get_Json..'"Status_Vip":"'..Status_Vip..'",'
end
if Status_Mem then
Get_Json = Get_Json..'"Status_Mem":"'..Status_Mem..'",'
end
if LinkGroup then
Get_Json = Get_Json..'"LinkGroup":"'..LinkGroup..'",'
end
Get_Json = Get_Json..'"WelcomeGroup":"'..WelcomeGroup..'"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./lib/'..bot_id..'.json', "w")
File:write(Get_Json)
File:close()
sendDocument(msg.chat_id_, msg.id_,'./lib/'..bot_id..'.json', '\n᥀︙تم جلب نسخه خاصه بالكروبات\n᥀︙يحتوي الملف على {'..#Groups..'} مجموعه')
elseif text == 'حذف اشتراك اجباري ➖'  and redis:get(bot_id..'zzzKz') then   
send(msg.chat_id_, msg.id_,"᥀︙تم حذف قناة الاشتراك الاجباري بنجاح") 
redis:del(bot_id..'zzzKz') 
elseif text == 'حذف اشتراك اجباري ➖'  and not redis:get(bot_id..'zzzKz') then   
send(msg.chat_id_, msg.id_,"᥀︙لا يوجد اشتراك اجباري بالفعل") 
elseif text == 'اضف اشتراك اجباري ➕' then
redis:set(bot_id..'Set:zzzKz',true) 
send(msg.chat_id_, msg.id_,'᥀︙قم بارسال معرف القناة مثال :- \n@zzzKz\n تأكد من ان البوت مشرف في القناة') 
elseif text == 'الاشتراك الاجباري ⭕'  and redis:get(bot_id..'zzzKz') then   
send(msg.chat_id_, msg.id_,"᥀︙قناة الاستراك الاجباري هي :- \n"..redis:get(bot_id..'zzzKz')) 
elseif text == 'الاشتراك الاجباري ⭕'  and not redis:get(bot_id..'zzzKz') then   
send(msg.chat_id_, msg.id_,"᥀︙لا يوجد اشتراك اجباري بالفعل") 
elseif text == 'تفعيل تواصل البوت 🔔' then  
redis:del(bot_id..'Status:Lock:Twasl') 
send(msg.chat_id_, msg.id_,'᥀︙ تم تفعيل التواصل ') 
elseif text == 'تعطيل تواصل البوت 🔕' then  
redis:set(bot_id..'Status:Lock:Twasl',true) 
send(msg.chat_id_, msg.id_,'᥀︙ تم تعطيل التواصل ') 
end
end 
end
if TypeForChat == ("ForSuppur") then
if text and not redis:get(bot_id.."AutoFile") then
Time = redis:get(bot_id.."AutoFile:Time")
if Time then 
if Time ~= os.date("%x") then  
local list = redis:smembers(bot_id..'ChekBotAdd')  
local t = '{"IdBot": '..bot_id..',"Groups":{'  
for k,v in pairs(list) do   
NAME = 'Tshake Chat'
ASAS = redis:smembers(bot_id.."President:User"..v)
MNSH = redis:smembers(bot_id.."Constructor:Group"..v)
MDER = redis:smembers(bot_id.."Manager:Group"..v)
MOD = redis:smembers(bot_id.."Admin:Group"..v)
link = redis:get(bot_id.."Status:link:set:Group"..v) or ''
if k == 1 then
t = t..'"'..v..'":{"tek":"'..NAME..'",'
else
t = t..',"'..v..'":{"tek":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"President":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"Admin":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"Manager":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"Constructor":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"LinkGroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./lib/'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(Id_Dev, msg.id_,'./lib/'..bot_id..'.json', '📮┇ عدد مجموعات التي في البوت { '..#list..'}')
redis:set(bot_id.."AutoFile:Time",os.date("%x"))
end
else 
redis:set(bot_id.."AutoFile:Time",os.date("%x"))
end
end
if text ==  ""..Name_Bot..' شنو رئيك بهاذا' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id.."Status:Fun:Bots"..msg.chat_id_) then 
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, function(Arg,Data) 
local Text_Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير الحب مال اني ❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, Data.id_,''..Text_Fun[math.random(#Text_Fun)]..'')   
end,nil)
return false
elseif text == ""..Name_Bot..' شنو رئيك بهاي' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id.."Status:Fun:Bots"..msg.chat_id_) then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(Arg, Data) 
local Text_Fun = {'الكبد مال اني هيه ','ختولي ماحبها ','خانتني ويه صديقي 😔','بس لو الكفها اله اعضها 💔','خوش بنيه بس عده مكسرات زايده وناقصه منا ومنا وهيه تدري بنفسها 😒','جذابه ومنافقه سوتلي مشكله ويه الحب مالتي ','ئووووووووف اموت ع ربها ','ديرو بالكم منها تلعب ع الولد 😶 ضحكت ع واحد قطته ايفون 7 ','صديقتي وختي وروحي وحياتي ','فد وحده منحرفه 😥','ساكنه بالعلاوي ونته حدد بعد لسانها لسان دلاله 🙄🤐','ام سحوره سحرت اخويا وعلكته 6 سنوات 🤕','ماحبها 🙁','بله هاي جهره تسئل عليها ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئل ع بنات العالم ولي يله 🏼','ياخي بنيه حبوبه بس لبعرك معمي عليها تشرب هواي 😹' } 
send(msg.chat_id_,Data.id_,''..Text_Fun[math.random(#Text_Fun)]..'') 
end,nil)
return false
end
if text then
local NewCmmd = redis:get(bot_id.."Set:Za:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if text == 'رفع النسخه الاحتياطيه' and tonumber(msg.reply_to_message_id_) > 0 and Dev_VINES(msg) then   
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(Arg, Data)   
if Data.content_.document_ then 
SetFile_Groups(msg,msg.chat_id_,Data.content_.document_.document_.persistent_id_ ,Data.content_.document_.file_name_)
end;end,nil)
end
if text == ("اضف مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Dev2Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته مطور ثانوي في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
return false
end
if text == ("حذف مطور ثانوي") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Dev2Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من المطور ثانويين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
return false
end
if text and text:match("^اضف مطور ثانوي @(.*)$") and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا اذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Dev2Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^اضف مطور ثانوي @(.*)$")}, FunctionStatus, nil)
return false
end
if text and text:match("^حذف مطور ثانوي @(.*)$") and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Dev2Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المطور ثانويين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حذف مطور ثانوي @(.*)$")}, FunctionStatus, nil)
return false
end
if text and text:match("^اضف مطور ثانوي (%d+)$") and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
redis:sadd(bot_id.."Dev2Bot", text:match("^اضف مطور ثانوي (%d+)$"))
Send_Options(msg,text:match("^اضف مطور ثانوي (%d+)$"),"reply","᥀︙تم ترقيته مطور ثانوي في البوت")  
return false
end
if text and text:match("^حذف مطور ثانوي (%d+)$") and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Dev2Bot", text:match("^حذف مطور ثانوي (%d+)$"))
Send_Options(msg,text:match("^حذف مطور ثانوي (%d+)$"),"reply","᥀︙تم تنزيله من المطور ثانويين")  
return false
end
if text == ("اضف مطور") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINES(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Developer:Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته مطور في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
return false
end
if text == ("حذف مطور") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINES(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Developer:Bot", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من المطورين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
return false
end
if text and text:match("^اضف مطور @(.*)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا اذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته مطور في البوت")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^اضف مطور @(.*)$")}, FunctionStatus, nil)
return false
end
if text and text:match("^حذف مطور @(.*)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Developer:Bot", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المطورين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حذف مطور @(.*)$")}, FunctionStatus, nil)
return false
end
if text and text:match("^اضف مطور (%d+)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
redis:sadd(bot_id.."Developer:Bot", text:match("^اضف مطور (%d+)$"))
Send_Options(msg,text:match("^اضف مطور (%d+)$"),"reply","᥀︙تم ترقيته مطور في البوت")  
return false
end
if text and text:match("^حذف مطور (%d+)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Developer:Bot", text:match("^حذف مطور (%d+)$"))
Send_Options(msg,text:match("^حذف مطور (%d+)$"),"reply","᥀︙تم تنزيله من المطورين")  
return false
end
if text == 'جلب نسخه احتياطيه' and Dev_VINES(msg) or text == 'جلب نسخه الكروبات' and Dev_VINES(msg) then
local list = redis:smembers(bot_id..'ChekBotAdd')  
local t = '{"IdBot": '..bot_id..',"Groups":{'  
for k,v in pairs(list) do   
NAME = 'Tshake Chat'
ASAS = redis:smembers(bot_id.."President:User"..v)
MNSH = redis:smembers(bot_id.."Constructor:Group"..v)
MDER = redis:smembers(bot_id.."Manager:Group"..v)
MOD = redis:smembers(bot_id.."Admin:Group"..v)
link = redis:get(bot_id.."Status:link:set:Group"..v) or ''
if k == 1 then
t = t..'"'..v..'":{"tek":"'..NAME..'",'
else
t = t..',"'..v..'":{"tek":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"President":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"Admin":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"Manager":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"Constructor":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"LinkGroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./lib/'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,'./lib/'..bot_id..'.json', '📮┇ عدد مجموعات التي في البوت { '..#list..'}')
end
if text == 'تنزيل جميع الرتب' and PresidentGroup(msg) then
redis:del(bot_id..'Basic:User'..msg.chat_id_)
redis:del(bot_id..'Constructor:Group'..msg.chat_id_)
redis:del(bot_id..'Manager:Group'..msg.chat_id_)
redis:del(bot_id..'Admin:Group'..msg.chat_id_)
redis:del(bot_id..'Vip:Group'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'᥀︙تم تنزيل الكل من جميع الرتب\n{الاساسين، المنشئين ، المدراء ، الادمنيه ، المميزين}')  
end
if text == 'السيرفر' and Dev_VINES(msg) then
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '📟┋•⊱ { نظام التشغيل } ⊰•\n*»» '"$linux_version"'*' 
echo '*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~*\n🔖┋•⊱ { الذاكره العشوائيه } ⊰•\n*»» '"$memUsedPrc"'*'
echo '*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~*\n💾┋•⊱ { وحـده الـتـخـزيـن } ⊰•\n*»» '"$HardDisk"'*'
echo '*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~*\n⚙️┋•⊱ { الـمــعــالــج } ⊰•\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~*\n👨🏾‍🔧┋•⊱ { الــدخــول } ⊰•\n*»» '`whoami`'*'
echo '*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉~*\n🔌┋{ مـده تـشغيـل الـسـيـرفـر }\n*»» '"$uptime"'*'
]]):read('*all'))  
end
if text == "الساعه" then
send(msg.chat_id_, msg.id_,"\n*᥀︙الساعه الان :* "..os.date("%I:%M%p"))
end
if text == "التاريخ" then
send(msg.chat_id_, msg.id_,"\n*᥀︙التاريخ :* "..os.date("%Y/%m/%d"))
end
if text then   
if redis:get(bot_id..'Set:array'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
local test = redis:get(bot_id..'Text:array'..msg.sender_user_id_..':'..msg.chat_id_..'')
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
redis:sadd(bot_id.."Add:Rd:array:Text"..test..msg.chat_id_,text)  
inline = {
{{text="اضغط هنا لانهاء الاضافه",callback_data="EndAddarray"..msg.sender_user_id_}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_,' *᥀︙تم حفظ الرد يمكنك ارسال اخر او اكمال العمليه من خلال الزر اسفل ✅*',nil,inline,msg_id) 
return false  
end
end    
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:array:Ssd"..msg.sender_user_id_..":"..msg.chat_id_) == 'dttd' then
redis:del(bot_id.."Set:array:Ssd"..msg.sender_user_id_..":"..msg.chat_id_)
gery = redis:get(bot_id.."Set:array:addpu"..msg.sender_user_id_..":"..msg.chat_id_)
if not redis:sismember(bot_id.."Add:Rd:array:Text"..gery..msg.chat_id_,text) then
send(msg.chat_id_, msg.id_,' *᥀︙لا يوجد رد متعدد * ')
return false
end
send(msg.chat_id_, msg.id_,' *᥀︙تم حذفه بنجاح .* ')
redis:srem(bot_id.."Add:Rd:array:Text"..gery..msg.chat_id_,text)
end
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:array:Ssd"..msg.sender_user_id_..":"..msg.chat_id_) == 'delrd' then
redis:del(bot_id.."Set:array:Ssd"..msg.sender_user_id_..":"..msg.chat_id_)
if not redis:sismember(bot_id..'List:array'..msg.chat_id_,text) then
send(msg.chat_id_, msg.id_,' *᥀︙لا يوجد رد متعدد * ')
return false
end
send(msg.chat_id_, msg.id_,' *᥀︙قم بارسال الرد الذي تريد حذفه منه* ')
redis:set(bot_id.."Set:array:addpu"..msg.sender_user_id_..":"..msg.chat_id_,text)
redis:set(bot_id.."Set:array:Ssd"..msg.sender_user_id_..":"..msg.chat_id_,"dttd")
return false
end
end
if text == "حذف رد من متعدد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"*᥀︙ارسل الكلمه الرد الاصليه*")
redis:set(bot_id.."Set:array:Ssd"..msg.sender_user_id_..":"..msg.chat_id_,"delrd")
return false 
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:array"..msg.sender_user_id_..":"..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,' *᥀︙ارسل الرد الذي تريد اضافته*')
redis:set(bot_id..'Set:array'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
redis:set(bot_id..'Text:array'..msg.sender_user_id_..':'..msg.chat_id_, text)
redis:del(bot_id.."Add:Rd:array:Text"..text..msg.chat_id_)   
redis:sadd(bot_id..'List:array'..msg.chat_id_..'', text)
return false
end
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."Set:array:rd"..msg.sender_user_id_..":"..msg.chat_id_) == 'delrd' then
redis:del(bot_id.."Set:array:rd"..msg.sender_user_id_..":"..msg.chat_id_)
send(msg.chat_id_, msg.id_,' *᥀︙تم ازالة الرد المتعدد بنجاح* ')
redis:del(bot_id.."Add:Rd:array:Text"..text..msg.chat_id_)
redis:srem(bot_id..'List:array'..msg.chat_id_, text)
return false
end
end
if text == "حذف رد متعدد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"*᥀︙ارسل الكلمه التي تريد حذفها*")
redis:set(bot_id.."Set:array:rd"..msg.sender_user_id_..":"..msg.chat_id_,"delrd")
return false 
end
if text and not redis:get(bot_id.."Status:Reply:Manager"..msg.chat_id_) then
if  redis:sismember(bot_id..'List:array'..msg.chat_id_,text) then
local list = redis:smembers(bot_id.."Add:Rd:array:Text"..text..msg.chat_id_)
quschen = list[math.random(#list)]
send(msg.chat_id_, msg.id_,quschen)
end
end
if text == ("الردود المتعدده") and Owner(msg) then
local list = redis:smembers(bot_id..'List:array'..msg.chat_id_..'')
text = "\n᥀︙قائمة الردود المتعدد في البوت\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
text = text..""..k..">> ("..v..") » {رساله}\n"
end
if #list == 0 then
text = " ᥀︙لا يوجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text == ("مسح الردود المتعدده") and BasicBuilder(msg) and GetChannelMember(msg) then   
local list = redis:smembers(bot_id..'List:array'..msg.chat_id_)
for k,v in pairs(list) do
redis:del(bot_id.."Add:Rd:array:Text"..v..msg.chat_id_)   
redis:del(bot_id..'List:array'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_," *᥀︙تم مسح الردود المتعدده*")
end
if text == "اضف رد متعدد" and Owner(msg) and GetChannelMember(msg) then   
send(msg.chat_id_, msg.id_,"*᥀︙ارسل الكلمه التي تريد اضافتها*")
redis:set(bot_id.."Set:array"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == 'تعطيل الالعاب الاحترافيه' and Owner(msg) and msg.reply_to_message_id_ == 0 then 
redis:set(bot_id..'lockGeamVip'..msg.chat_id_,true)  
send(msg.chat_id_, msg.id_,'*᥀︙تم تعطيل الالعاب الاحترافيه*')
end
if text == 'تفعيل الالعاب الاحترافيه' and Owner(msg) and msg.reply_to_message_id_ == 0 then 
redis:del(bot_id..'lockGeamVip'..msg.chat_id_)  
send(msg.chat_id_, msg.id_,'*᥀︙تم تفعيل الالعاب الاحترافيه*')
end
if text == 'الالعاب الاحترافيه' and Vips(msg) then  
if not redis:get(bot_id..'lockGeamVip'..msg.chat_id_) then
_key = {
{{text="♟ Chess Game ♟",url='https://t.me/T4TTTTBOT?game=chess'}},
{{text="لعبة فلابي بيرد 🐥",url='https://t.me/awesomebot?game=FlappyBird'},{text="تحداني فالرياضيات 🔢",url='https://t.me/gamebot?game=MathBattle'}},
{{text="تحداني في ❌⭕️",url='t.me/XO_AABOT?start3836619'},{text="سباق الدراجات 🏍",url='https://t.me/gamee?game=MotoFX'}},
{{text="سباق سيارات 🏎",url='https://t.me/gamee?game=F1Racer'},{text="متشابه 👾",url='https://t.me/gamee?game=DiamondRows'}},
{{text="كرة قدم ⚽",url='https://t.me/gamee?game=FootballStar'}},
{{text="دومنا🥇",url='https://vipgames.com/play/?affiliateId=wpDom/#/games/domino/lobby'},{text="❕ليدو",url='https://vipgames.com/play/?affiliateId=wpVG#/games/ludo/lobby'}},
{{text="ورق🤹‍♂",url='https://t.me/gamee?game=Hexonix'},{text="Hexonix❌",url='https://t.me/gamee?game=Hexonix'}},
{{text="MotoFx🏍️",url='https://t.me/gamee?game=MotoFx'}},
{{text="لعبة 2048 🎰",url='https://t.me/awesomebot?game=g2048'},{text="Squares🏁",url='https://t.me/gamee?game=Squares'}},
{{text="Atomic 1▶️",url='https://t.me/gamee?game=AtomicDrop1'},{text="Corsairs",url='https://t.me/gamebot?game=Corsairs'}},
{{text="LumberJack",url='https://t.me/gamebot?game=LumberJack'}},
{{text="LittlePlane",url='https://t.me/gamee?game=LittlePlane'},{text="RollerDisco",url='https://t.me/gamee?game=RollerDisco'}},
{{text="🦖 Dragon Game 🦖",url='https://t.me/T4TTTTBOT?game=dragon'},{text="🐍 3D Snake Game 🐍",url='https://t.me/T4TTTTBOT?game=snake'}},
{{text="🔵 Color Game 🔴",url='https://t.me/T4TTTTBOT?game=color'}},
{{text="🚀 Rocket Game 🚀",url='https://t.me/T4TTTTBOT?game=rocket'},{text="🏹 Arrow Game 🏹",url='https://t.me/T4TTTTBOT?game=arrow'}},
{{text = '𓂅 .VINES TEAM',url='http://t.me/Vc33h'}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_," *᥀︙قائمه الالعاب الاحترافيه اضغط للعب*",nil,_key,msg_id) 
else
_key = {
{{text = '𓂅 .VINES TEAM',url='http://t.me/Vc33h'}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_," *᥀︙الالعاب الاحترافيه معطله في الوقت الحالي .*",nil,_key,msg_id) 
end
end
if text == "تفعيل الرسائل اليوميه" and Owner(msg) then
send(msg.chat_id_, msg.id_, '*᥀︙تم تفعيل الرسائل اليوميه*')
redis:set(bot_id.."msg:match:"..msg.chat_id_,true)
end
if text == "تعطيل الرسائل اليوميه" and Owner(msg) then
send(msg.chat_id_, msg.id_,'*᥀︙تم تعطيل الرسائل اليوميه*')
redis:del(bot_id.." msg:match:"..msg.chat_id_)
end
if redis:get(bot_id.."msg:match:"..msg.chat_id_) then
if msg.content_.ID then
get_msg = redis:get(bot_id.."msg:match:"..msg.sender_user_id_..":"..msg.chat_id_) or 0
gms = get_msg + 1
redis:setex(bot_id..'msg:match:'..msg.sender_user_id_..":"..msg.chat_id_,86400,gms)
end
if text == "تفاعلي اليوم" and tonumber(msg.reply_to_message_id_) == 0 then    
get_msg = redis:get(bot_id.."msg:match:"..msg.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"*᥀︙عدد رسائلك الكلي هو :-*\n"..get_msg.." *من الرسائل*")
end  
if text == "تفاعله اليوم" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
get_msg = redis:get(bot_id.."msg:match:"..result.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"*᥀︙عدد رسائل اشخص الكلي هو :-*\n"..get_msg.." *من الرسائل*")
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
end
if text == 'تحويل' then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
elseif result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
elseif result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
elseif result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تفعيل التحقق' and Owner(msg) then   
if redis:get(bot_id.."Chek:Welcome"..msg.chat_id_) then
redis:del(bot_id.."Chek:Welcome"..msg.chat_id_)
end
if not redis:get(bot_id..'CAPTCHA'..msg.chat_id_) then
redis:set(bot_id.."CAPTCHA"..msg.chat_id_,true) 
Text = ' *᥀︙تم تفعيل التحقق عند دخول الاعضاء*'
else
Text = ' *᥀︙بالتاكيد تم تفعيل التحقق*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحقق' and Owner(msg) then  
if not redis:get(bot_id..'CAPTCHA'..msg.chat_id_) then
Text = '\n *᥀︙بالتاكيد تم تعطيل التحقق*'
else
redis:del(bot_id.."CAPTCHA"..msg.chat_id_) 
Text = '\n *᥀︙تم تعطيل التحقق عند دخول الاعضاء*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الحب' and Owner(msg) then   
if redis:get(bot_id..'Cick:lov'..msg.chat_id_) then
Text = ' *᥀︙تم تفعيل نسبه الحب*'
redis:del(bot_id..'Cick:lov'..msg.chat_id_)  
else
Text = ' *᥀︙بالتاكيد تم تفعيل نسبه الحب*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الحب' and Owner(msg) then  
if not redis:get(bot_id..'Cick:lov'..msg.chat_id_) then
redis:set(bot_id..'Cick:lov'..msg.chat_id_,true)  
Text = '\n *᥀︙تم تعطيل نسبه الحب*'
else
Text = '\n *᥀︙بالتاكيد تم تعطيل نسبه الحب*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الرجوله' and Owner(msg) then   
if redis:get(bot_id..'Cick:rjo'..msg.chat_id_) then
Text = ' *᥀︙تم تفعيل نسبه الرجوله*'
redis:del(bot_id..'Cick:rjo'..msg.chat_id_)  
else
Text = ' *᥀︙بالتاكيد تم تفعيل الرجوله*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الرجوله' and Owner(msg) then  
if not redis:get(bot_id..'Cick:rjo'..msg.chat_id_) then
redis:set(bot_id..'Cick:rjo'..msg.chat_id_,true)  
Text = '\n *᥀︙تم تعطيل نسبه الرجوله*'
else
Text = '\n *᥀︙بالتاكيد تم تعطيل نسبه الرجوله*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الكره' and Owner(msg) then   
if redis:get(bot_id..'Cick:krh'..msg.chat_id_) then
Text = ' *᥀︙تم تفعيل نسبه الكره*'
redis:del(bot_id..'Cick:krh'..msg.chat_id_)  
else
Text = ' *᥀︙بالتاكيد تم تفعيل نسبه الكره*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الكره' and Owner(msg) then  
if not redis:get(bot_id..'Cick:krh'..msg.chat_id_) then
redis:set(bot_id..'Cick:krh'..msg.chat_id_,true)  
Text = '\n *᥀︙تم تعطيل نسبه الكره*'
else
Text = '\n *᥀︙بالتاكيد تم تعطيل نسبه الكره*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الانوثه' and Owner(msg) then   
if redis:get(bot_id..'Cick:ano'..msg.chat_id_) then
Text = ' *᥀︙تم تفعيل نسبه الانوثه*'
redis:del(bot_id..'Cick:ano'..msg.chat_id_)  
else
Text = ' *᥀︙بالتاكيد تم تفعيل الانوثه*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الانوثه' and Owner(msg) then  
if not redis:get(bot_id..'Cick:ano'..msg.chat_id_) then
redis:set(bot_id..'Cick:ano'..msg.chat_id_,true)  
Text = '\n *᥀︙تم تعطيل نسبه الانوثه*'
else
Text = '\n *᥀︙بالتاكيد تم تعطيل نسبه الانوثه*'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not redis:get(bot_id..'Cick:lov'..msg.chat_id_) then
redis:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
send(msg.chat_id_, msg.id_, '*ارسل اسمك واسم الشخص الثاني،*  *\n مثال اسد و لبوى*') 
end
end
if text and text ~="نسبه الحب" and redis:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
sendnuj = math.random(0,100);
send(msg.chat_id_, msg.id_,'*نسبه حب* *'..text..'* هي :* '..sendnuj..'%*') 
redis:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not redis:get(bot_id..'Cick:krh'..msg.chat_id_) then
redis:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
send(msg.chat_id_, msg.id_,'*ارسل اسمك واسم الشخص الثاني،*  *\n مثال اسد و لبوى*') 
end
end
if text and text ~="نسبه الكره" and redis:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
sendnuj = math.random(0,100);
send(msg.chat_id_, msg.id_, '*نسبه كره* *'..text..'* هي : *'..sendnuj..'%*') 
redis:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not redis:get(bot_id..'Cick:rjo'..msg.chat_id_) then
redis:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = '*ارسل اسم الشخص الذي تريد قياس نسبه رجولته* *\n مثال حيدر*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and redis:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
sendnuj = math.random(0,100);
send(msg.chat_id_, msg.id_,'*نسبه رجوله* *'..text..'* هي : *\n '..sendnuj..'%*') 
redis:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if not redis:get(bot_id..'Cick:ano'..msg.chat_id_) then
redis:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = '*ارسل اسم الشخص الذي تريد قياس نسبه انوثتها* *\n مثال نونه*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and redis:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
sendnuj = math.random(0,100);
send(msg.chat_id_, msg.id_,'*نسبه الانوثه* *'..text..'* هي : *\n '..sendnuj..'%*') 
redis:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
if text == "قائمه المنع" and Admin(msg) and GetChannelMember(msg) then
redis:set(bot_id.."Filter:msg",msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = bot_id},function(arg,data) 
local Text = "\n *᥀︙قائمة المنع* \n*ٴ─━─━─━─×─━─━─━─*\n"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'صور', url="https://t.me/"..data.username_.."?start=ph"..msg.chat_id_},{text = 'كلمات', url="https://t.me/"..data.username_.."?start=msg"..msg.chat_id_}},
{{text = 'متحركات', url="https://t.me/"..data.username_.."?start=gif"..msg.chat_id_},{text = 'ملصقات', url="https://t.me/"..data.username_.."?start=Sti"..msg.chat_id_}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end
if text == "مسح قائمه المنع" and Admin(msg) and GetChannelMember(msg) then
local listtext = redis:smembers(bot_id.."List:Filter:text"..msg.chat_id_)  
for k,v in pairs(listtext) do  
redis:srem(bot_id.."List:Filter:text"..msg.chat_id_,v)  
end  
local listAnimation = redis:smembers(bot_id.."List:Filter:Animation"..msg.chat_id_)  
for k,v in pairs(listAnimation) do  
redis:srem(bot_id.."List:Filter:Animation"..msg.chat_id_,v)  
end  
local listSticker = redis:smembers(bot_id.."List:Filter:Sticker"..msg.chat_id_)  
for k,v in pairs(listSticker) do  
redis:srem(bot_id.."List:Filter:Sticker"..msg.chat_id_,v)  
end  
local listPhoto = redis:smembers(bot_id.."List:Filter:Photo"..msg.chat_id_)  
for k,v in pairs(listPhoto) do  
redis:srem(bot_id.."List:Filter:Photo"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"*᥀︙تم مسح قائمه المنع*")  
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Admin(msg) then       
send(msg.chat_id_, msg.id_,"*᥀︙الان ارسل الشيء الذي تريد منعه*")
redis:set(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end
if text then   
local tsssst = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم منع الكلمه بنجاح*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:sadd(bot_id.."List:Filter:text"..msg.chat_id_,text)  
return false 
end  
end
if msg.content_.ID == 'MessageAnimation' then    
local tsssst = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم منع المتحركه بنجاح*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:sadd(bot_id.."List:Filter:Animation"..msg.chat_id_,msg.content_.animation_.animation_.persistent_id_)  
return false 
end  
end
if msg.content_.ID == 'MessageSticker' then    
local tsssst = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم منع الملصق بنجاح*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:sadd(bot_id.."List:Filter:Sticker"..msg.chat_id_,msg.content_.sticker_.sticker_.persistent_id_)  
return false 
end  
end
if msg.content_.ID == 'MessagePhoto' then    
local tsssst = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم منع الصوره بنجاح*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:sadd(bot_id.."List:Filter:Photo"..msg.chat_id_,msg.content_.photo_.sizes_[1].photo_.persistent_id_)  
return false 
end  
end
if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Admin(msg) and GetChannelMember(msg) then
send(msg.chat_id_, msg.id_,"*᥀︙الان ارسل الشيء الذي تريد منعه*")
redis:set(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false 
end
if text then 
local test = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم الغاء منعها*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:srem(bot_id.."List:Filter:text"..msg.chat_id_,text)  
return false
end  
end
if msg.content_.ID == 'MessageAnimation' then    
local onte = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if onte and onte == "reppp" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم الغاء منع المتحركه بنجاح*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:srem(bot_id.."List:Filter:Animation"..msg.chat_id_,msg.content_.animation_.animation_.persistent_id_)  
return false
end  
end
if msg.content_.ID == 'MessageSticker' then    
local Stic = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if Stic and Stic == "reppp" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم الغاء منع الملصق بنجاح*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:srem(bot_id.."List:Filter:Sticker"..msg.chat_id_,msg.content_.sticker_.sticker_.persistent_id_)  
return false
end  
end
if msg.content_.ID == 'MessagePhoto' then    
local hoto = redis:get(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if hoto and hoto == "reppp" then   
send(msg.chat_id_, msg.id_,"*᥀︙تم الغاء منع الصوره بنجاح*")  
redis:del(bot_id.."Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
redis:srem(bot_id.."List:Filter:Photo"..msg.content_.photo_.sizes_[1].photo_.persistent_id_)  
return false
end
end
if text == ("مسح قائمه العام") and Dev_VINES(msg) or text == ("مسح المحظورين عام") and Dev_VINES(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Removal:User:Groups")
send(msg.chat_id_, msg.id_, "᥀︙تم مسح المحظورين عام من البوت")
elseif text == ("مسح قائمه الكتم العام") and Dev_VINES(msg) or text == ("مسح المكتومين عام") and Dev_VINES(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Mu:User:Groups")
send(msg.chat_id_, msg.id_, "᥀︙تم مسح المحظورين عام من البوت")
elseif text == ("مسح الثانويين") and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Dev2Bot")
elseif text == ("مسح المطورين") and Dev_VINES(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Developer:Bot")
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المطورين من البوت  ")
elseif text == ("مسح المنشئين الاساسين") and PresidentGroup(msg) or text == "مسح الاساسين" and DeveloperBot(msg)  and GetChannelMember(msg) then  
redis:del(bot_id.."Basic:User"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المنشئين الاساسيين في المجموعه")
elseif text == ("مسح المنشئين الاساسين") or text == "مسح الاساسين" and GetChannelMember(msg) then  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
redis:del(bot_id.."Basic:User"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المنشئين الاساسيين في المجموعه")
end
end,nil)
elseif text == ("مسح المنشئين") and BasicBuilder(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Constructor:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المنشئين في المجموعه")
elseif text == ("مسح المدراء") and Constructor(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Manager:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المدراء في المجموعه")
elseif text == ("مسح الادمنيه") and Owner(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Admin:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح الادمنيه في المجموعه")
elseif text == ("مسح المميزين") and Admin(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Vip:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المميزين في المجموعه")
elseif text == ("المقيدين") and Admin(msg) then
local list = redis:smembers(bot_id.."Keed:User:Group"..msg.chat_id_)
Keeded = "\n᥀︙قائمة المقيدين في المجموعه\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Keeded = Keeded..""..k.."~ : [@"..username.."]\n"
else
Keeded = Keeded..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Keeded = "᥀︙لا يوجد مقيدين"
end
send(msg.chat_id_, msg.id_, Keeded)
elseif text == ("مسح المكتومين") and Admin(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Silence:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المكتومين في المجموعه")
elseif text == ("مسح المقيدين") and Admin(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Keed:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙ تم مسح المقيدين في المجموعه")
elseif text == ("مسح المحظورين") and Admin(msg) and GetChannelMember(msg) then  
redis:del(bot_id.."Removal:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "᥀︙تم مسح المحظورين في المجموعه")
elseif text == "حذف الاوامر المضافه" and Constructor(msg) or text == "مسح الاوامر المضافه" and Constructor(msg) and GetChannelMember(msg) then  
local list = redis:smembers(bot_id.."List:ZaYon:Group:New"..msg.chat_id_)
for k,v in pairs(list) do
redis:del(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..v)
redis:del(bot_id.."List:ZaYon:Group:New"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"᥀︙تم مسح جميع الاوامر التي تم اضافتها")  
elseif text == "مسح الصلاحيات" and Constructor(msg) and GetChannelMember(msg) then  
local list = redis:smembers(bot_id.."Validitys:Group"..msg.chat_id_)
for k,v in pairs(list) do;redis:del(bot_id.."Add:Validity:Group:Rt"..v..msg.chat_id_);redis:del(bot_id.."Validitys:Group"..msg.chat_id_);end
send(msg.chat_id_, msg.id_,"᥀︙تم مسح صلاحيات المجموعه")
elseif text == ("قائمه العام") and Dev_VINES(msg) or text == ("المحظورين عام") and Dev_VINES(msg) and GetChannelMember(msg) then  
local list = redis:smembers(bot_id.."Removal:User:Groups")
Gban = "\n᥀︙قائمة المحظورين عام في البوت\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Gban = Gban..""..k.."~ : [@"..username.."]\n"
else
Gban = Gban..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Gban = "᥀︙لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, Gban)
elseif text == ("قائمه الكتم للعام") and Dev_VINES(msg) or text == ("المكتومين عام") and Dev_VINES(msg) and GetChannelMember(msg) then  
local list = redis:smembers(bot_id.."Mu:User:Groups")
Muan = "\n᥀︙قائمة للمكتومين عام في البوت\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Muan = Muan..""..k.."~ : [@"..username.."]\n"
else
Muan = Muan..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Muan = "᥀︙لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, Muan)
elseif text == ("الثانويين") and Dev_VINESEnd(msg) and GetChannelMember(msg) then  
local list = redis:smembers(bot_id.."Dev2Bot")
Sudoss = "\n᥀︙قائمة الثانويين في البوت \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Sudoss = Sudoss..""..k.."~ : [@"..username.."]\n"
else
Sudoss = Sudoss..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Sudoss = "᥀︙لا يوجد الثانويين"
end
send(msg.chat_id_, msg.id_, Sudoss)
elseif text == ("المطورين") and Dev_VINES(msg) and GetChannelMember(msg) then  
local list = redis:smembers(bot_id.."Developer:Bot")
Sudos = "\n᥀︙قائمة مطورين في البوت \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Sudos = Sudos..""..k.."~ : [@"..username.."]\n"
else
Sudos = Sudos..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Sudos = "᥀︙لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, Sudos)
elseif text == "المنشئين الاساسين" and PresidentGroup(msg) or text == "الاساسين" and DeveloperBot(msg) and GetChannelMember(msg) or text == ("تاك للاساسيين") then  
local list = redis:smembers(bot_id.."Basic:User"..msg.chat_id_)
Asase = "\n᥀︙قائمة المنشئين الاساسين في المجموعه\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Asase = Asase..""..k.."~ : [@"..username.."]\n"
else
Asase = Asase..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Asase = "᥀︙لا يوجد منشئين اساسيين"
end
send(msg.chat_id_, msg.id_, Asase)
elseif text == ("المنشئين") and BasicBuilder(msg) and GetChannelMember(msg) or text == ("تاك للمنشئين") then    
local list = redis:smembers(bot_id.."Constructor:Group"..msg.chat_id_)
Monsh = "\n᥀︙قائمة منشئين المجموعه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Monsh = Monsh..""..k.."~ : [@"..username.."]\n"
else
Monsh = Monsh..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Monsh = "᥀︙لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, Monsh)
elseif text == ("المدراء") and Constructor(msg) and GetChannelMember(msg) or text == ("تاك للمدراء") then      
local list = redis:smembers(bot_id.."Manager:Group"..msg.chat_id_)
Moder = "\n᥀︙قائمة المدراء في المجموعه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Moder = Moder..""..k.."~ : [@"..username.."]\n"
else
Moder = Moder..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Moder = "᥀︙لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, Moder)
elseif text == ("الادمنيه") and Owner(msg) and GetChannelMember(msg) or text == ("تاك للادمنيه") then  
local list = redis:smembers(bot_id.."Admin:Group"..msg.chat_id_)
Admin = "\n᥀︙قائمة الادمنيه في المجموعه\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Admin = Admin..""..k.."~ : [@"..username.."]\n"
else
Admin = Admin..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Admin = "᥀︙لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, Admin)
elseif text == ("المميزين") and Admin(msg) or text == ("تاك للمميزين") then      
local list = redis:smembers(bot_id.."Vip:Group"..msg.chat_id_)
Vips = "\n᥀︙قائمة المميزين في المجموعه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Vips = Vips..""..k.."~ : [@"..username.."]\n"
else
Vips = Vips..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Vips = "᥀︙لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, Vips)
elseif text == "ترتيب الاوامر" and Admin(msg) then
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":ا","ايدي")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"ا")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":م","رفع مميز")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"م")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":اد","رفع ادمن")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"اد")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":مد","رفع مدير")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"مد")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":من","رفع منشئ")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"من")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":اس","رفع منشئ اساسي")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"اس")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":تعط","تعطيل الايدي بالصوره")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"تعط")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":تفع","تفعيل الايدي بالصوره")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"تفع")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":مط","رفع مطور")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"مط")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":ثانوي","رفع مطور ثانوي")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"ثانوي")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":تك","تنزيل الكل")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"تك")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":ر","الرابط")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"ر")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":رر","ردود المدير")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"رر")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":،،","مسح المكتومين")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"،،")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":رد","اضف رد")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"رد")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":سح","مسح سحكاتي")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"سح")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":رس","مسح رسائلي")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"رس")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":غ","غنيلي")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"غ")
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":#","مسح قائمه العام")
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,"#")
send(msg.chat_id_, msg.id_,"᥀︙تم ترتيب الاوامر بالشكل التالي ~\n᥀︙ ايدي - ا .\n᥀︙ رفع مميز - م .\n᥀︙رفع ادمن - اد .\n᥀︙ رفع مدير - مد . \n᥀︙ رفع منشى - من . \n᥀︙ رفع منشئ الاساسي - اس  .\n᥀︙ رفع مطور - مط .\n᥀︙رفع مطور ثانوي - ثانوي .\n᥀︙ تنزيل الكل - تك .\n᥀︙ تعطيل الايدي بالصوره - تعط .\n᥀︙ تفعيل الايدي بالصوره - تفع .\n᥀︙ الرابط - ر .\n᥀︙ ردود المدير - رر .\n᥀︙ مسح المكتومين - ،، .\n᥀︙ اضف رد - رد .\n᥀︙ مسح سحكاتي - سح .\n᥀︙ مسح رسائلي - رس .\n᥀︙ غنيلي - غ .\n᥀︙مسح قائمه العام - #")  
elseif text == ("المكتومين") and Admin(msg) then
local list = redis:smembers(bot_id.."Silence:User:Group"..msg.chat_id_)
Muted = "\n᥀︙قائمة المكتومين في المجموعه\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Muted = Muted..""..k.."~ : [@"..username.."]\n"
else
Muted = Muted..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Muted = "᥀︙لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, Muted)
elseif text == ("المحظورين") and Admin(msg) then
local list = redis:smembers(bot_id.."Removal:User:Group"..msg.chat_id_)
Bans = "\n᥀︙قائمة المحظورين في المجموعه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
Bans = Bans..""..k.."~ : [@"..username.."]\n"
else
Bans = Bans..""..k.."~ : `"..v.."`\n"
end
end
if #list == 0 then
Bans = "᥀︙لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, Bans)
elseif text == "الصلاحيات" and Admin(msg) then 
local list = redis:smembers(bot_id.."Validitys:Group"..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,"᥀︙لا توجد صلاحيات مضافه هنا")
return false
end
Validity = "\n᥀︙قائمة الصلاحيات المضافه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
var = redis:get(bot_id.."Add:Validity:Group:Rt"..v..msg.chat_id_)
if var then
Validity = Validity..""..k.."- "..v.." ~ ("..var..")\n"
else
Validity = Validity..""..k.."- "..v.."\n"
end
end
send(msg.chat_id_, msg.id_,Validity)
elseif text == "الاوامر المضافه" and Constructor(msg) then
local list = redis:smembers(bot_id.."List:ZaYon:Group:New"..msg.chat_id_.."")
t = "᥀︙قائمه الاوامر المضافه  \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ \n"
for k,v in pairs(list) do
Cmds = redis:get(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..v)
if Cmds then 
t = t..""..k.."- ("..v..") ~ {"..Cmds.."}\n"
else
t = t..""..k.."- ("..v..") \n"
end
end
if #list == 0 then
t = "᥀︙لا توجد اوامر اضافيه"
end
send(msg.chat_id_, msg.id_,"["..t.."]")
elseif text == "تاك للكل" and Admin(msg) then
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""), offset_ = 0,limit_ = 200},function(ta,taha)
local t = "\n᥀︙ قائمة الاعضاء \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
x = 0
local list = taha.members_
for k, v in pairs(list) do
x = x + 1
if redis:get(bot_id.."Save:Username"..v.user_id_) then
t = t..""..x.." : [@"..redis:get(bot_id.."Save:Username"..v.user_id_).."]\n"
else
t = t..""..x.." : "..v.user_id_.."\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
elseif text == ("حظر عام") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINES(msg) then
function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "᥀︙لا تسطيع حظر البوت عام")
return false 
end
if Dev_VINES_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, "᥀︙لا تستطيع حظر المطور الاساسي عام")
return false 
end
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم حظره عام من المجموعات")  
redis:sadd(bot_id.."Removal:User:Groups", result.sender_user_id_)
KickGroup(result.chat_id_, result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء العام") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINES(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Removal:User:Groups", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم الغاء حظره عام من المجموعات")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("كتم عام") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINES(msg) then
function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "᥀︙لا تسطيع كتم البوت عام")
return false 
end
if Dev_VINES_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_, "᥀︙لا تستطيع كتم المطور الاساسي عام")
return false 
end
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم كتمه عام من المجموعات")  
redis:sadd(bot_id.."Mu:User:Groups", result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء كتم العام") and tonumber(msg.reply_to_message_id_) ~= 0 and Dev_VINES(msg) then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Mu:User:Groups", result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم الغاء كتمه عام من المجموعات")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and PresidentGroup(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Basic:User"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته منشئ اساسي")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and PresidentGroup(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Basic:User"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and GetChannelMember(msg) then  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Basic:User"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته منشئ اساسي")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
end,nil)
elseif text == ("تنزيل منشئ اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and GetChannelMember(msg) then   
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
redis:srem(bot_id.."Basic:User"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end
end,nil)
elseif text == "رفع منشئ" and tonumber(msg.reply_to_message_id_) ~= 0 and BasicBuilder(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Constructor:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته منشئ في المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^تنزيل منشئ$") and tonumber(msg.reply_to_message_id_) ~= 0 and BasicBuilder(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Constructor:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من المنشئين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع مدير") and tonumber(msg.reply_to_message_id_) ~= 0 and Constructor(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Manager:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته مدير المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل مدير") and tonumber(msg.reply_to_message_id_) ~= 0 and Constructor(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Manager:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من المدراء")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع ادمن") and tonumber(msg.reply_to_message_id_) ~= 0 and Owner(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Admin:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته ادمن للمجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل ادمن") and tonumber(msg.reply_to_message_id_) ~= 0 and Owner(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Admin:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من ادمنيه المجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
redis:sadd(bot_id.."Vip:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته مميز للمجموعه")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تنزيل مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Vip:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله من المميزين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Admin(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).." ")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"᥀︙لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Removal:User:Group"..msg.chat_id_, result.sender_user_id_)
KickGroup(result.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم حظره من المجموعه")  
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء حظر") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "᥀︙لا يمكنك عمل هاذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Removal:User:Group"..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم الغاء حظره من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Admin(msg) and GetChannelMember(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
return false 
end 
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم كتمه من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء كتم") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
redis:srem(bot_id.."Silence:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم الغاء كتمه من هنا")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("الغاء تقيد") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
redis:srem(bot_id.."Keed:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم الغاء تقييده")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text == ("تقيد") and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
return false
end
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
redis:sadd(bot_id.."Keed:User:Group"..msg.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تقييده")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^حظر عام @(.*)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
if result and result.type_ and result.type_.ID == ("ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "᥀︙لا تسطيع حظر البوت عام")
return false 
end
if Dev_VINES_User(result.id_) == true then
send(msg.chat_id_, msg.id_, "᥀︙لا تستطيع حظر المطور الاساسي عام")
return false 
end
redis:sadd(bot_id.."Removal:User:Groups", result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم حظره عام من المجموعات")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر عام @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء العام @(.*)$") and Dev_VINES(msg) then
function FunctionStatus(arg, result)
if (result.id_) then
Send_Options(msg,result.id_,"reply","᥀︙تم الغاء حظره عام من المجموعات")  
redis:srem(bot_id.."Removal:User:Groups", result.id_)
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء العام @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^رفع منشئ اساسي @(.*)$") and PresidentGroup(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Basic:User"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته منشئ اساسي")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ اساسي @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل منشئ اساسي @(.*)$") and PresidentGroup(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Basic:User"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ اساسي @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^رفع منشئ اساسي @(.*)$") and GetChannelMember(msg) then   
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Basic:User"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته منشئ اساسي")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end
end,nil)
elseif text and text:match("^تنزيل منشئ اساسي @(.*)$") and GetChannelMember(msg) then   
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Basic:User"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ اساسي @(.*)$")}, FunctionStatus, nil)
return false
end
end,nil)
elseif text and text:match("^رفع منشئ @(.*)$") and BasicBuilder(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Constructor:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته منشئ في المجموعه")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع منشئ @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل منشئ @(.*)$") and BasicBuilder(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Constructor:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المنشئين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل منشئ @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^رفع مدير @(.*)$") and Constructor(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Manager:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته مدير المجموعه")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مدير @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Manager:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المدراء")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل مدير @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^رفع ادمن @(.*)$") and Owner(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Admin:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته ادمن للمجموعه")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع ادمن @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل ادمن @(.*)$") and Owner(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Admin:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من ادمنيه المجموعه")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل ادمن @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^رفع مميز @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Vip:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم ترقيته مميز للمجموعه")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^رفع مميز @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تنزيل مميز @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Vip:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله من المميزين")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل مميز @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("رفع (.*)") and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) then 
if redis:sismember(bot_id.."Validitys:Group"..msg.chat_id_,text:match("رفع (.*)")) then
function Status_reply(extra, result, success)   
local statusrt = redis:get(bot_id.."Add:Validity:Group:Rt"..text:match("رفع (.*)")..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)")) 
redis:sadd(bot_id.."Vip:Group"..msg.chat_id_,result.sender_user_id_)  
elseif statusrt == "ادمن" and Owner(msg) then 
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))
redis:sadd(bot_id.."Admin:Group"..msg.chat_id_,result.sender_user_id_)  
elseif statusrt == "مدير" and Constructor(msg) then
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))  
redis:sadd(bot_id.."Manager:Group"..msg.chat_id_,result.sender_user_id_)  
elseif statusrt == "عضو" and Admin(msg) then
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))  
end
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم ترقيته : "..text:match("رفع (.*)").."")  
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, Status_reply, nil)
end
elseif text and text:match("تنزيل (.*)") and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) then 
if redis:sismember(bot_id.."Validitys:Group"..msg.chat_id_,text:match("تنزيل (.*)")) then
function Status_reply(extra, result, success)   
local statusrt = redis:get(bot_id.."Add:Validity:Group:Rt"..text:match("تنزيل (.*)")..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then 
redis:srem(bot_id.."Vip:Group"..msg.chat_id_,result.sender_user_id_)  
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_)
elseif statusrt == "ادمن" and Owner(msg) then 
redis:srem(bot_id.."Admin:Group"..msg.chat_id_,result.sender_user_id_) 
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_)
elseif statusrt == "مدير" and Constructor(msg) then
redis:srem(bot_id.."Manager:Group"..msg.chat_id_,result.sender_user_id_)  
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_)
elseif statusrt == "عضو" and Admin(msg) then
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.sender_user_id_)
end
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم تنزيله : "..text:match("تنزيل (.*)").."")  
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, Status_reply, nil)
end
elseif text and text:match("^رفع (.*) @(.*)") and Admin(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if redis:sismember(bot_id.."Validitys:Group"..msg.chat_id_,text1[2]) then
function status_username(extra, result, success)   
if (result.id_) then
local statusrt = redis:get(bot_id.."Add:Validity:Group:Rt"..text1[2]..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then
redis:sadd(bot_id.."Vip:Group"..msg.chat_id_,result.id_)  
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_,text1[2])
elseif statusrt == "ادمن" and Owner(msg) then 
redis:sadd(bot_id.."Admin:Group"..msg.chat_id_,result.id_)  
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_,text1[2])
elseif statusrt == "مدير" and Constructor(msg) then
redis:sadd(bot_id.."Manager:Group"..msg.chat_id_,result.id_)  
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_,text1[2])
elseif statusrt == "عضو" and Admin(msg) then
redis:set(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_,text1[2])
end
Send_Options(msg,result.id_,"reply","᥀︙تم رفعه : "..text1[2].."")
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},status_username,nil) 
end 
elseif text and text:match("^تنزيل (.*) @(.*)") and Admin(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if redis:sismember(bot_id.."Validitys:Group"..msg.chat_id_,text1[2]) then
function status_username(extra, result, success)   
if (result.id_) then
local statusrt = redis:get(bot_id.."Add:Validity:Group:Rt"..text1[2]..msg.chat_id_)
if statusrt == "مميز" and Admin(msg) then
redis:srem(bot_id.."Vip:Group"..msg.chat_id_,result.id_)  
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_)
elseif statusrt == "ادمن" and Owner(msg) then 
redis:srem(bot_id.."Admin:Group"..msg.chat_id_,result.id_)  
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_)
elseif statusrt == "مدير" and Constructor(msg) then 
redis:srem(bot_id.."Manager:Group"..msg.chat_id_,result.id_)  
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_)
elseif statusrt == "عضو" and Admin(msg) then
redis:del(bot_id.."Add:Validity:Users"..msg.chat_id_..result.id_)
end
Send_Options(msg,result.id_,"reply","᥀︙تم تنزيله : "..text1[2].."")
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},status_username,nil) 
end  
elseif text and text:match("^حظر @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"᥀︙لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Removal:User:Group"..msg.chat_id_, result.id_)
KickGroup(msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم حظره من المجموعه")  
end,nil)   
end
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^حظر @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء حظر @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "᥀︙لا يمكنك عمل هاذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Removal:User:Group"..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,result.id_,"reply","᥀︙تم الغاء حظره من هنا")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء حظر @(.*)$") }, FunctionStatus, nil)
elseif text and text:match("^كتم @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.id_,msg.chat_id_).." ")
return false 
end 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم كتمه من هنا")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^كتم @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^الغاء كتم @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if (result.id_) then
redis:srem(bot_id.."Silence:User:Group"..msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم الغاء كتمه من هنا")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء كتم @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^تقيد @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
if Rank_Checking(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
return false 
end  
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم تقييده في المجموعه")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تقيد @(.*)$")}, FunctionStatus, nil)
elseif text and text:match('^تقيد (%d+) (.*) @(.*)$') and Admin(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
else
Send_Options(msg,result.id_,"reply", "᥀︙تم تقيده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, FunctionStatus, nil)
elseif text and text:match("^الغاء تقيد @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
function FunctionStatus(arg, result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
if (result.id_) then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,result.id_,"reply","᥀︙تم الغاء تقييده")  
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^الغاء تقيد @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^طرد @(.*)$") and Admin(msg) and GetChannelMember(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
if not Constructor(msg) and redis:get(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
function FunctionStatus(arg, result)
if (result.id_) then
if Rank_Checking(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"᥀︙عذرا هاذا معرف قناة")   
return false 
end  
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"᥀︙لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
KickGroup(msg.chat_id_, result.id_)
Send_Options(msg,result.id_,"reply","᥀︙تم طرده من هنا")  
end,nil)   
end
else
send(msg.chat_id_, msg.id_,"᥀︙المعرف غلط ")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^طرد @(.*)$")}, FunctionStatus, nil)
elseif text and text:match("^حظر عام (%d+)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
if Dev_VINES_User(text:match("^حظر عام (%d+)$")) == true then
send(msg.chat_id_, msg.id_, "᥀︙لا تستطيع حظر المطور الاساسي عام")
return false 
end
if tonumber(text:match("^حظر عام (%d+)$")) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "᥀︙لا تسطيع حظر البوت عام")
return false 
end
redis:sadd(bot_id.."Removal:User:Groups", text:match("^حظر عام (%d+)$"))
Send_Options(msg,text:match("^حظر عام (%d+)$"),"reply","᥀︙تم حظره عام من المجموعات")  
elseif text and text:match("^الغاء العام (%d+)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Removal:User:Groups", text:match("^الغاء العام (%d+)$"))
Send_Options(msg,text:match("^الغاء العام (%d+)$"),"reply","᥀︙تم الغاء حظره عام من المجموعات")  
elseif text and text:match("^كتم عام (%d+)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
if Dev_VINES_User(text:match("^كتم عام (%d+)$")) == true then
send(msg.chat_id_, msg.id_, "᥀︙لا تستطيع كتم المطور الاساسي عام")
return false 
end
if tonumber(text:match("^كتم عام (%d+)$")) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "᥀︙لا تسطيع كتم البوت عام")
return false 
end
redis:sadd(bot_id.."Mu:User:Groups", text:match("^كتم عام (%d+)$"))
Send_Options(msg,text:match("^كتم عام (%d+)$"),"reply","᥀︙تم كتمه عام من المجموعات")  
elseif text and text:match("^الغاء كتم العام (%d+)$") and Dev_VINES(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Mu:User:Groups", text:match("^الغاء كتم العام (%d+)$"))
Send_Options(msg,text:match("^الغاء كتم العام (%d+)$"),"reply","᥀︙تم الغاء كتمه عام من المجموعات")  
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and BasicBuilder(msg) and GetChannelMember(msg) then  
redis:sadd(bot_id.."Basic:User"..msg.chat_id_, text:match("^رفع منشئ اساسي (%d+)$") )
Send_Options(msg,text:match("^رفع منشئ اساسي (%d+)$") ,"reply","᥀︙تم ترقيته منشئ اساسي")  
elseif text and text:match("^تنزيل منشئ اساسي (%d+)$") and BasicBuilder(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Basic:User"..msg.chat_id_, text:match("^تنزيل منشئ اساسي (%d+)$") )
Send_Options(msg,text:match("^تنزيل منشئ اساسي (%d+)$") ,"reply","᥀︙تم تنزيله من المنشئين")  
elseif text and text:match("^رفع منشئ (%d+)$") and BasicBuilder(msg) and GetChannelMember(msg) then  
redis:sadd(bot_id.."Constructor:Group"..msg.chat_id_, text:match("^رفع منشئ (%d+)$"))
Send_Options(msg,text:match("^رفع منشئ (%d+)$"),"reply","᥀︙تم ترقيته منشئ في المجموعه")  
elseif text and text:match("^تنزيل منشئ (%d+)$") and BasicBuilder(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Constructor:Group"..msg.chat_id_, text:match("^تنزيل منشئ (%d+)$"))
Send_Options(msg,text:match("^تنزيل منشئ (%d+)$"),"reply","᥀︙تم تنزيله من المنشئين")  
elseif text and text:match("^رفع مدير (%d+)$") and Constructor(msg) and GetChannelMember(msg) then  
redis:sadd(bot_id.."Manager:Group"..msg.chat_id_, text:match("^رفع مدير (%d+)$") )
Send_Options(msg,text:match("^رفع مدير (%d+)$") ,"reply","᥀︙تم ترقيته مدير المجموعه")  
elseif text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Manager:Group"..msg.chat_id_, text:match("^تنزيل مدير (%d+)$") )
Send_Options(msg,text:match("^تنزيل مدير (%d+)$") ,"reply","᥀︙تم تنزيله من المدراء")  
elseif text and text:match("^رفع ادمن (%d+)$") and Owner(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
redis:sadd(bot_id.."Admin:Group"..msg.chat_id_, text:match("^رفع ادمن (%d+)$"))
Send_Options(msg,text:match("^رفع ادمن (%d+)$"),"reply","᥀︙تم ترقيته ادمن للمجموعه")  
elseif text and text:match("^تنزيل ادمن (%d+)$") and Owner(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Admin:Group"..msg.chat_id_, text:match("^تنزيل ادمن (%d+)$"))
Send_Options(msg,text:match("^تنزيل ادمن (%d+)$"),"reply","᥀︙تم تنزيله من ادمنيه المجموعه")  
elseif text and text:match("^رفع مميز (%d+)$") and Admin(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Cheking:Seted"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع رفع احد وذالك لان تم تعطيل الرفع من قبل المنشئين')
return false
end
redis:sadd(bot_id.."Vip:Group"..msg.chat_id_, text:match("^رفع مميز (%d+)$"))
Send_Options(msg,text:match("^رفع مميز (%d+)$"),"reply","᥀︙تم ترقيته مميز للمجموعه")  
elseif text and text:match("^تنزيل مميز (%d+)$") and Admin(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Vip:Group"..msg.chat_id_, text:match("^تنزيل مميز (%d+)$") )
Send_Options(msg,text:match("^تنزيل مميز (%d+)$") ,"reply","᥀︙تم تنزيله من المميزين")  
elseif text and text:match("^حظر (%d+)$") and Admin(msg) and GetChannelMember(msg) then  
if not Constructor(msg) and redis:get(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
if Rank_Checking(text:match("^حظر (%d+)$") , msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(text:match("^حظر (%d+)$"),msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = text:match("^حظر (%d+)$") , status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"᥀︙لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
redis:sadd(bot_id.."Removal:User:Group"..msg.chat_id_, text:match("^حظر (%d+)$") )
KickGroup(msg.chat_id_, text:match("^حظر (%d+)$") )  
Send_Options(msg,text:match("^حظر (%d+)$") ,"reply","᥀︙تم حظره من المجموعه")  
end,nil)   
end
elseif text and text:match("^الغاء حظر (%d+)$") and Admin(msg) and GetChannelMember(msg) then  
if tonumber(text:match("^الغاء حظر (%d+)$") ) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, "᥀︙لا يمكنك عمل هاذا الامر على البوت") 
return false 
end
redis:srem(bot_id.."Removal:User:Group"..msg.chat_id_, text:match("^الغاء حظر (%d+)$") )
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = text:match("^الغاء حظر (%d+)$") , status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
Send_Options(msg,text:match("^الغاء حظر (%d+)$") ,"reply","᥀︙تم الغاء حظره من هنا")  
elseif text and text:match("^كتم (%d+)$") and Admin(msg) and GetChannelMember(msg) then  
if Rank_Checking(text:match("^كتم (%d+)$"), msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(text:match("^كتم (%d+)$"),msg.chat_id_).."")
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
redis:sadd(bot_id.."Silence:User:Group"..msg.chat_id_, text:match("^كتم (%d+)$"))
Send_Options(msg,text:match("^كتم (%d+)$"),"reply","᥀︙تم كتمه من هنا")  
end
elseif text and text:match("^الغاء كتم (%d+)$") and Admin(msg) and GetChannelMember(msg) then  
redis:srem(bot_id.."Silence:User:Group"..msg.chat_id_,text:match("^الغاء كتم (%d+)$") )
Send_Options(msg,text:match("^الغاء كتم (%d+)$") ,"reply","᥀︙تم الغاء كتمه من هنا")  
elseif text and text:match("^تقيد (%d+)$") and Admin(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
if Rank_Checking(text:match("^تقيد (%d+)$"), msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(text:match("^تقيد (%d+)$"),msg.chat_id_).."")
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..text:match("^تقيد (%d+)$"))
Send_Options(msg,text:match("^تقيد (%d+)$"),"reply","᥀︙تم تقييده في المجموعه")  
end
elseif text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
else
Send_Options(msg,result.sender_user_id_,"reply", "᥀︙تم تقيده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^الغاء تقيد (%d+)$") and Admin(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..text:match("^الغاء تقيد (%d+)$").. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
Send_Options(msg,text:match("^الغاء تقيد (%d+)$"),"reply","᥀︙تم الغاء تقييده")  
elseif text == ("طرد") and msg.reply_to_message_id_ ~=0 and Admin(msg) then
if not Constructor(msg) and redis:get(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"᥀︙لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
KickGroup(result.chat_id_, result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","᥀︙تم طرده من هنا")  
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
elseif text and text:match("^طرد (%d+)$") and Admin(msg) then 
if not Constructor(msg) and redis:get(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'᥀︙لقد تم تعطيل الحظر و الطرد من قبل المنشئين')
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"᥀︙عذرآ البوت ليس ادمن") 
return false  
end
if Rank_Checking(text:match("^طرد (%d+)$") , msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(text:match("^طرد (%d+)$"),msg.chat_id_).."")
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = text:match("^طرد (%d+)$") , status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"᥀︙لا توجد لدي صلاحية حظر المستخدمين") 
return false  
end
KickGroup(msg.chat_id_, text:match("^طرد (%d+)$") )
Send_Options(msg,text:match("^طرد (%d+)$") ,"reply","᥀︙تم طرده من هنا")  
end,nil)   
end
elseif text and text:match('^وضع عدد الكانسر (%d+)$') and Owner(msg) then 
local Num = text:match('^وضع عدد الكانسر (%d+)$')
redis:set(bot_id..'Num:kansers'..msg.chat_id_,Num)
send(msg.chat_id_, msg.id_, '\n᥀︙تم وضع عدد حروف الاسم {'..Num..'} حرف')
elseif text == "قفل الكانسر" and Owner(msg) then 
redis:set(bot_id.."Status:lock:kanser"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙ تم قفل الكانسر ")
elseif text == "فتح الكانسر" and Owner(msg) then 
redis:del(bot_id.."Status:lock:kanser"..msg.chat_id_) 
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الكانسر ")
elseif text == "قفل الفارسيه" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:set(bot_id.."Status:lock:Far"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الفارسيه")  
elseif text == "قفل الفشار" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:set(bot_id.."Status:lock:Fsh"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الفشار")  
elseif text == "قفل الدردشه" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:set(bot_id.."Status:Lock:text"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الدردشه")  
elseif text == "قفل الاضافه" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Status:Lock:AddMempar"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل اضافة الاعضاء")  
elseif text == "قفل الدخول" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Status:Lock:Join"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل دخول الاعضاء")  
elseif text == "قفل البوتات" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل البوتات")  
elseif text == "قفل البوتات بالطرد" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل البوتات")  
elseif text == "قفل البوتات بالتقيد" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:set(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل البوتات")  
elseif text == "قفل الاشعارات" and msg.reply_to_message_id_ == 0 and Admin(msg) then  
redis:set(bot_id.."Status:Lock:tagservr"..msg.chat_id_,true)  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الاشعارات")  
elseif text == "قفل التثبيت" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set(bot_id.."Status:lockpin"..msg.chat_id_, true) 
redis:sadd(bot_id.."Status:Lock:pin",msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  redis:set(bot_id.."Get:Id:Msg:Pin"..msg.chat_id_,data.pinned_message_id_)  end,nil)
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل التثبيت هنا")  
elseif text == "قفل التعديل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set(bot_id.."Status:Lock:edit"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل تعديل")  
elseif text == "قفل تعديل الميديا" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:set(bot_id.."Status:Lock:edit"..msg.chat_id_,true) 
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل تعديل")  
elseif text == "قفل الكل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
redis:set(bot_id.."Status:Lock:tagservrbot"..msg.chat_id_,true)   
list ={"Status:Lock:Bot:kick","Status:Lock:User:Name","Status:Lock:hashtak","Status:Lock:Cmd","Status:Lock:Link","Status:Lock:forward","Status:Lock:Keyboard","Status:Lock:geam","Status:Lock:Photo","Status:Lock:Animation","Status:Lock:Video","Status:Lock:Audio","Status:Lock:vico","Status:Lock:Sticker","Status:Lock:Document","Status:Lock:Unsupported","Status:Lock:Markdaun","Status:Lock:Contact","Status:Status:Lock:Spam"}
for i,lock in pairs(list) do;redis:set(bot_id..lock..msg.chat_id_,"del");end
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل جميع الاوامر")  
elseif text == "فتح الاضافه" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Status:Lock:AddMempar"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح اضافة الاعضاء")  
elseif text == "فتح الفارسيه" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:del(bot_id.."Status:lock:Far"..msg.chat_id_) 
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الفارسيه")  
elseif text == "فتح الفشار" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:del(bot_id.."Status:lock:Fsh"..msg.chat_id_) 
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الفشار")  
elseif text == "فتح الدردشه" and msg.reply_to_message_id_ == 0 and Owner(msg) then 
redis:del(bot_id.."Status:Lock:text"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الدردشه")  
elseif text == "فتح الدخول" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Status:Lock:Join"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح دخول الاعضاء")  
elseif text == "فتح البوتات" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح البوتات")  
elseif text == "فتح البوتات " and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","\n᥀︙تم فتح البوتات")  
elseif text == "فتح الاشعارات" and msg.reply_to_message_id_ == 0 and Admin(msg) then  
redis:del(bot_id.."Status:Lock:tagservr"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الاشعارات")  
elseif text == "فتح التثبيت" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del(bot_id.."Status:lockpin"..msg.chat_id_)  
redis:srem(bot_id.."Status:Lock:pin",msg.chat_id_)
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح التثبيت هنا")  
elseif text == "فتح التعديل" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del(bot_id.."Status:Lock:edit"..msg.chat_id_) 
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح تعديل")  
elseif text == "فتح تعديل الميديا" and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
redis:del(bot_id.."Status:Lock:edit"..msg.chat_id_) 
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح تعديل")  
elseif text == "فتح الكل" and msg.reply_to_message_id_ == 0 and Admin(msg) then 
redis:del(bot_id.."Status:Lock:tagservrbot"..msg.chat_id_)   
list ={"Status:Lock:Bot:kick","Status:Lock:User:Name","Status:Lock:hashtak","Status:Lock:Cmd","Status:Lock:Link","Status:Lock:forward","Status:Lock:Keyboard","Status:Lock:geam","Status:Lock:Photo","Status:Lock:Animation","Status:Lock:Video","Status:Lock:Audio","Status:Lock:vico","Status:Lock:Sticker","Status:Lock:Document","Status:Lock:Unsupported","Status:Lock:Markdaun","Status:Lock:Contact","Status:Status:Lock:Spam"}
for i,lock in pairs(list) do;redis:del(bot_id..lock..msg.chat_id_);end
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح جميع الاوامر")  
elseif text == "قفل الروابط" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Link"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الروابط")  
elseif text == "قفل الروابط بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Link"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الروابط")  
elseif text == "قفل الروابط بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Link"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الروابط")  
elseif text == "قفل الروابط بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Link"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الروابط")  
elseif text == "فتح الروابط" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Link"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الروابط")  
elseif text == "قفل المعرفات" and Admin(msg) then
redis:set(bot_id.."Status:Lock:User:Name"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل المعرفات")  
elseif text == "قفل المعرفات بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:User:Name"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل المعرفات")  
elseif text == "قفل المعرفات بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:User:Name"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل المعرفات")  
elseif text == "قفل المعرفات بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:User:Name"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل المعرفات")  
elseif text == "فتح المعرفات" and Admin(msg) then
redis:del(bot_id.."Status:Lock:User:Name"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح المعرفات")  
elseif text == "قفل التاك" and Admin(msg) then
redis:set(bot_id.."Status:Lock:hashtak"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل التاك")  
elseif text == "قفل التاك بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:hashtak"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل التاك")  
elseif text == "قفل التاك بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:hashtak"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل التاك")  
elseif text == "قفل التاك بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:hashtak"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل التاك")  
elseif text == "فتح التاك" and Admin(msg) then
redis:del(bot_id.."Status:Lock:hashtak"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح التاك")  
elseif text == "قفل الشارحه" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Cmd"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الشارحه")  
elseif text == "قفل الشارحه بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Cmd"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الشارحه")  
elseif text == "قفل الشارحه بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Cmd"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الشارحه")  
elseif text == "قفل الشارحه بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Cmd"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الشارحه")  
elseif text == "فتح الشارحه" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Cmd"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الشارحه")  
elseif text == "قفل الصور"and Admin(msg) then
redis:set(bot_id.."Status:Lock:Photo"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الصور")  
elseif text == "قفل الصور بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Photo"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الصور")  
elseif text == "قفل الصور بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Photo"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الصور")  
elseif text == "قفل الصور بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Photo"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الصور")  
elseif text == "فتح الصور" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Photo"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الصور")  
elseif text == "قفل الفيديو" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Video"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الفيديو")  
elseif text == "قفل الفيديو بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Video"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الفيديو")  
elseif text == "قفل الفيديو بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Video"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الفيديو")  
elseif text == "قفل الفيديو بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Video"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الفيديو")  
elseif text == "فتح الفيديو" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Video"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الفيديو")  
elseif text == "قفل المتحركه" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Animation"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل المتحركه")  
elseif text == "قفل المتحركه بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Animation"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل المتحركه")  
elseif text == "قفل المتحركه بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Animation"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل المتحركه")  
elseif text == "قفل المتحركه بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Animation"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل المتحركه")  
elseif text == "فتح المتحركه" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Animation"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح المتحركه")  
elseif text == "قفل الالعاب" and Admin(msg) then
redis:set(bot_id.."Status:Lock:geam"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الالعاب")  
elseif text == "قفل الالعاب بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:geam"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الالعاب")  
elseif text == "قفل الالعاب بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:geam"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الالعاب")  
elseif text == "قفل الالعاب بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:geam"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الالعاب")  
elseif text == "فتح الالعاب" and Admin(msg) then
redis:del(bot_id.."Status:Lock:geam"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الالعاب")  
elseif text == "قفل الاغاني" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Audio"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الاغاني")  
elseif text == "قفل الاغاني بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Audio"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الاغاني")  
elseif text == "قفل الاغاني بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Audio"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الاغاني")  
elseif text == "قفل الاغاني بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Audio"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الاغاني")  
elseif text == "فتح الاغاني" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Audio"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الاغاني")  
elseif text == "قفل الصوت" and Admin(msg) then
redis:set(bot_id.."Status:Lock:vico"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الصوت")  
elseif text == "قفل الصوت بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:vico"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الصوت")  
elseif text == "قفل الصوت بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:vico"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الصوت")  
elseif text == "قفل الصوت بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:vico"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الصوت")  
elseif text == "فتح الصوت" and Admin(msg) then
redis:del(bot_id.."Status:Lock:vico"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الصوت")  
elseif text == "قفل الكيبورد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Keyboard"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الكيبورد")  
elseif text == "قفل الكيبورد بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Keyboard"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الكيبورد")  
elseif text == "قفل الكيبورد بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Keyboard"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الكيبورد")  
elseif text == "قفل الكيبورد بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Keyboard"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الكيبورد")  
elseif text == "فتح الكيبورد" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Keyboard"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الكيبورد")  
elseif text == "قفل الملصقات" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Sticker"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الملصقات")  
elseif text == "قفل الملصقات بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Sticker"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الملصقات")  
elseif text == "قفل الملصقات بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Sticker"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الملصقات")  
elseif text == "قفل الملصقات بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Sticker"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الملصقات")  
elseif text == "فتح الملصقات" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Sticker"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الملصقات")  
elseif text == "قفل التوجيه" and Admin(msg) then
redis:set(bot_id.."Status:Lock:forward"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل التوجيه")  
elseif text == "قفل التوجيه بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:forward"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل التوجيه")  
elseif text == "قفل التوجيه بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:forward"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل التوجيه")  
elseif text == "قفل التوجيه بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:forward"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل التوجيه")  
elseif text == "فتح التوجيه" and Admin(msg) then
redis:del(bot_id.."Status:Lock:forward"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح التوجيه")  
elseif text == "قفل الملفات" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Document"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الملفات")  
elseif text == "قفل الملفات بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Document"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الملفات")  
elseif text == "قفل الملفات بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Document"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الملفات")  
elseif text == "قفل الملفات بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Document"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الملفات")  
elseif text == "فتح الملفات" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Document"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الملفات")  
elseif text == "قفل السيلفي" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Unsupported"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل السيلفي")  
elseif text == "قفل السيلفي بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Unsupported"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل السيلفي")  
elseif text == "قفل السيلفي بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Unsupported"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل السيلفي")  
elseif text == "قفل السيلفي بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Unsupported"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل السيلفي")  
elseif text == "فتح السيلفي" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Unsupported"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح السيلفي")  
elseif text == "قفل الماركداون" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Markdaun"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الماركداون")  
elseif text == "قفل الماركداون بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Markdaun"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الماركداون")  
elseif text == "قفل الماركداون بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Markdaun"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الماركداون")  
elseif text == "قفل الماركداون بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Markdaun"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الماركداون")  
elseif text == "فتح الماركداون" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Markdaun"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الماركداون")  
elseif text == "قفل الجهات" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Contact"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الجهات")  
elseif text == "قفل الجهات بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Contact"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الجهات")  
elseif text == "قفل الجهات بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Contact"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الجهات")  
elseif text == "قفل الجهات بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Contact"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الجهات")  
elseif text == "فتح الجهات" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Contact"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الجهات")  
elseif text == "قفل الكلايش" and Admin(msg) then
redis:set(bot_id.."Status:Status:Lock:Spam"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الكلايش")  
elseif text == "قفل الكلايش بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Status:Lock:Spam"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الكلايش")  
elseif text == "قفل الكلايش بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Status:Lock:Spam"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الكلايش")  
elseif text == "قفل الكلايش بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Status:Lock:Spam"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الكلايش")  
elseif text == "فتح الكلايش" and Admin(msg) then
redis:del(bot_id.."Status:Status:Lock:Spam"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الكلايش")  
elseif text == "قفل الانلاين" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Inlen"..msg.chat_id_,"del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل الانلاين")  
elseif text == "قفل الانلاين بالتقيد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Inlen"..msg.chat_id_,"ked")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل الانلاين")  
elseif text == "قفل الانلاين بالكتم" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Inlen"..msg.chat_id_,"ktm")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل الانلاين")  
elseif text == "قفل الانلاين بالطرد" and Admin(msg) then
redis:set(bot_id.."Status:Lock:Inlen"..msg.chat_id_,"kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل الانلاين")  
elseif text == "فتح الانلاين" and Admin(msg) then
redis:del(bot_id.."Status:Lock:Inlen"..msg.chat_id_)  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح الانلاين")  
elseif text == "قفل التكرار بالطرد" and Admin(msg) then 
redis:hset(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Spam:User","kick")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","᥀︙تم قفـل التكرار")
elseif text == "قفل التكرار" and Admin(msg) then 
redis:hset(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
Send_Options(msg,msg.sender_user_id_,"Close_Status","᥀︙تم قفـل التكرار بالحذف")
elseif text == "قفل التكرار بالتقيد" and Admin(msg) then 
redis:hset(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","᥀︙تم قفـل التكرار")
elseif text == "قفل التكرار بالكتم" and Admin(msg) then 
redis:hset(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Spam:User","mute")  
Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","᥀︙تم قفـل التكرار")
elseif text == "فتح التكرار" and Admin(msg) then 
redis:hdel(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Spam:User")  
Send_Options(msg,msg.sender_user_id_,"Open_Status","᥀︙تم فتح التكرار")
elseif text == "تفعيل الحمايه القصوى" and Owner(msg) then  
redis:set(bot_id.."Link_Group"..msg.chat_id_,true) 
redis:set(bot_id.."Status:Status:Lock:Spam"..msg.chat_id_,"del")  
redis:hset(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
redis:set(bot_id..'Status:Lock:Id:Py:Photo'..msg.chat_id_,true) 
redis:set(bot_id.."Chek:Welcome"..msg.chat_id_,true) 
redis:set(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_,"true")
redis:set(bot_id.."Status:Cheking:Seted"..msg.chat_id_,"true")
redis:set(bot_id.."Status:Lock:tagservrbot"..msg.chat_id_,true)   
list ={"Status:lock:Far","Status:lock:Fsh","Status:Lock:Bot:kick","Status:Lock:User:Name","Status:Lock:hashtak","Status:Lock:Cmd","Status:Lock:Link","Status:Lock:forward","Status:Lock:Keyboard","Status:Lock:geam","Status:Lock:Photo","Status:Lock:Animation","Status:Lock:Video","Status:Lock:Audio","Status:Lock:vico","Status:Lock:Sticker","Status:Lock:Document","Status:Lock:Unsupported","Status:Lock:Markdaun","Status:Lock:Contact","Status:Status:Lock:Spam"}
for i,lock in pairs(list) do;redis:set(bot_id..lock..msg.chat_id_,"del");end
redis:set(bot_id.."Status:lockpin"..msg.chat_id_, true) 
redis:sadd(bot_id.."Status:Lock:pin",msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  redis:set(bot_id.."Get:Id:Msg:Pin"..msg.chat_id_,data.pinned_message_id_)  end,nil)
redis:set(bot_id.."Status:Lock:edit"..msg.chat_id_,true) 
redis:set(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_,"kick")  
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل الحمايه القصوى") 
elseif text == "تفعيل جلب الرابط" and Admin(msg) or text == 'تفعيل الرابط' and Admin(msg) then  
redis:del(bot_id.."Link_Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل جلب الرابط المجموعه") 
elseif text == "تعطيل جلب الرابط" and Admin(msg) or text == 'تعطيل الرابط' and Admin(msg) then
redis:set(bot_id.."Link_Group"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل جلب رابط المجموعه") 
elseif text == "تفعيل الترحيب" and Admin(msg) then  
redis:set(bot_id.."Chek:Welcome"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل ترحيب المجموعه") 
elseif text == "تعطيل الترحيب" and Admin(msg) then  
redis:del(bot_id.."Chek:Welcome"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل ترحيب المجموعه") 
elseif text == "تفعيل ردود المدير" and Owner(msg) then   
redis:del(bot_id.."Status:Reply:Manager"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل ردود المدير") 
elseif text == "تعطيل ردود المدير" and Owner(msg) then  
redis:set(bot_id.."Status:Reply:Manager"..msg.chat_id_,true)  
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل ردود المدير" ) 
elseif text == "تفعيل ردود المطور" and Owner(msg) then   
redis:del(bot_id.."Status:Reply:Sudo"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل ردود المطور" ) 
elseif text == "تعطيل ردود المطور" and Owner(msg) then  
redis:set(bot_id.."Status:Reply:Sudo"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل ردود المطور" ) 
elseif text == "تفعيل اطردني" and Owner(msg) then   
redis:del(bot_id.."Status:Cheking:Kick:Me:Group"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,Text) 
elseif text == "تعطيل اطردني" and Owner(msg) then  
redis:set(bot_id.."Status:Cheking:Kick:Me:Group"..msg.chat_id_,true)  
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل امر اطردني") 
elseif text == "تفعيل المغادره" and Dev_VINES(msg) then   
redis:del(bot_id.."Status:Lock:Left"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل مغادرة البوت") 
elseif text == "تعطيل المغادره" and Dev_VINES(msg) then  
redis:set(bot_id.."Status:Lock:Left"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_, "᥀︙تم تعطيل مغادرة البوت") 
elseif text == "تفعيل الاذاعه" and Dev_VINES(msg) then  
redis:del(bot_id.."Status:Broadcasting:Bot") 
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل الاذاعه \n᥀︙الان يمكن للمطورين الاذاعه" ) 
elseif text == "تعطيل الاذاعه" and Dev_VINES(msg) then  
redis:set(bot_id.."Status:Broadcasting:Bot",true) 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الاذاعه") 
elseif text == "تعطيل اوامر التحشيش" and Owner(msg) then
send(msg.chat_id_, msg.id_, '᥀︙تم تعطيل اوامر التحشيش')
redis:set(bot_id.."Status:Fun:Group"..msg.chat_id_,"true")
elseif text == "تفعيل اوامر التحشيش" and Owner(msg) then
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل اوامر التحشيش')
redis:del(bot_id.."Status:Fun:Group"..msg.chat_id_)
elseif text == 'تفعيل الايدي' and Owner(msg) then   
redis:del(bot_id..'Status:Lock:Id:Photo'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل الايدي') 
elseif text == 'تعطيل الايدي' and Owner(msg) then  
redis:set(bot_id..'Status:Lock:Id:Photo'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'᥀︙تم تعطيل الايدي') 
elseif text == 'تفعيل الايدي بالصوره' and Owner(msg) then   
redis:del(bot_id..'Status:Lock:Id:Py:Photo'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل الايدي بالصوره') 
elseif text == 'تعطيل الايدي بالصوره' and Owner(msg) then  
redis:set(bot_id..'Status:Lock:Id:Py:Photo'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'᥀︙تم تعطيل الايدي بالصوره') 
elseif text == "تعطيل الالعاب" and Owner(msg) then   
redis:del(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الالعاب") 
elseif text == "تفعيل الالعاب" and Owner(msg) then  
redis:set(bot_id.."Status:Lock:Game:Group"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"᥀︙تم تفعيل الالعاب") 
elseif text == 'تفعيل البوت الخدمي' and Dev_VINES(msg) then  
redis:del(bot_id..'Free:Bot') 
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل البوت الخدمي \n᥀︙الان يمكن الجميع تفعيله') 
elseif text == 'تعطيل البوت الخدمي' and Dev_VINES(msg) then  
redis:set(bot_id..'Free:Bot',true) 
send(msg.chat_id_, msg.id_,'᥀︙تم تعطيل البوت الخدمي') 
elseif text == "تعطيل الطرد" and Constructor(msg) or text == "تعطيل الحظر" and Constructor(msg) then
redis:set(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_,"true")
send(msg.chat_id_, msg.id_, '᥀︙تم تعطيل - ( الحظر - الطرد ) ')
elseif text == "تفعيل الطرد" and Constructor(msg) or text == "تفعيل الحظر" and Constructor(msg) then
redis:del(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '᥀︙تم تفعيل - ( الحظر - الطرد ) ')
elseif text == "تعطيل الرفع" and Constructor(msg) or text == "تعطيل الترقيه" and Constructor(msg) then
redis:set(bot_id.."Status:Cheking:Seted"..msg.chat_id_,"true")
send(msg.chat_id_, msg.id_, '᥀︙تم تعطيل رفع - ( الادمن - المميز ) ')
elseif text == "تفعيل الرفع" and Constructor(msg) or text == "تفعيل الترقيه" and Constructor(msg) then
redis:del(bot_id.."Status:Cheking:Seted"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '᥀︙تم تفعيل رفع - ( الادمن - المميز ) ')
elseif text ==("تثبيت") and msg.reply_to_message_id_ ~= 0 and Admin(msg) and GetChannelMember(msg) then  
if redis:sismember(bot_id.."Status:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"᥀︙التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100",""),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"᥀︙تم تثبيت الرساله بنجاح")   
redis:set(bot_id.."Get:Id:Msg:Pin"..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"᥀︙البوت ليس ادمن هنا")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"᥀︙ليست لدي صلاحية التثبيت .")  
end;end,nil) 
elseif text == "الغاء التثبيت" and Admin(msg) and GetChannelMember(msg) then  
if redis:sismember(bot_id.."Status:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"᥀︙التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"᥀︙تم الغاء تثبيت الرساله بنجاح")   
redis:del(bot_id.."Get:Id:Msg:Pin"..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"᥀︙البوت ليس ادمن هنا")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"᥀︙ليست لدي صلاحية التثبيت .")
end;end,nil)
elseif text == "الغاء التثبيت الكل" and Admin(msg) and GetChannelMember(msg) then  
if redis:sismember(bot_id.."Status:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"᥀︙التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"᥀︙تم الغاء تثبيت الرساله بنجاح")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
redis:del(bot_id.."Get:Id:Msg:Pin"..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"᥀︙البوت ليس ادمن هنا")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"᥀︙ليست لدي صلاحية التثبيت .")
end;end,nil)
elseif text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Admin(msg) then
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
KickGroup(msg.chat_id_, data.id_)
end;end,nil);end
send(msg.chat_id_, msg.id_,'᥀︙تم طرد الحسابات المحذوفه')
end,nil)
end
elseif text ==("مسح المطرودين") and Admin(msg) then
local function delbans(extra, result)  
if not msg.can_be_deleted_ == true then  
send(msg.chat_id_, msg.id_, "᥀︙ يرجى ترقيتي ادمن هنا") 
return false
end  
local num = 0 
for k,y in pairs(result.members_) do 
num = num + 1  
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft"}, }, dl_cb, nil)  
end  
send(msg.chat_id_, msg.id_,"᥀︙ تم الغاء الحظر عن *: "..num.." * شخص") 
end
elseif text == "مسح البوتات" and Admin(msg) then 
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
KickGroup(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end 
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "᥀︙لا توجد بوتات في المجموعه")
else
send(msg.chat_id_, msg.id_,"\n᥀︙عدد البوتات هنا : "..c.."\n᥀︙عدد البوتات التي هي ادمن : "..x.."\n᥀︙تم طرد - "..(c - x).." - بوتات ") 
end 
end,nil)  
elseif text == "غنيلي" then
data,res = https.request('https://vvvzvv.ml/amirVois/Teland.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='᥀︙تم اختيار المقطع الصوتي لك'
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true")
end
end
elseif text == 'عدد الوسائط' and Admin(msg) then   
send(msg.chat_id_, msg.id_,'᥀︙العدد الكلي '..(redis:scard(bot_id..":IdMsg:"..msg.chat_id_) or 0)) 
elseif text == "امسح" and Admin(msg) then 
local IdMsgGet = redis:smembers(bot_id..":IdMsg:"..msg.chat_id_)
for k,v in pairs(IdMsgGet) do 
Delete_Message(msg.chat_id_, {[0] = v}) 
redis:srem(bot_id..":IdMsg:"..msg.chat_id_,v)
end
send(msg.chat_id_, msg.id_,"᥀︙تم مسح الميديا بنجاح")
elseif text == 'تفعيل التنظيف التلقائي' and Owner(msg) then   
redis:set(bot_id.."LoMsg"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل التنظيف التلقائي ') 
elseif text == 'تعطيل التنظيف التلقائي' and Owner(msg) then  
redis:del(bot_id.."LoMsg"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'᥀︙تم تعطيل التنظيف التلقائي') 
elseif text == 'تفعيل الزخرفه' and Owner(msg) then   
redis:del(bot_id..'Status:Lock:zhrf_Bots'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل الزخرفه') 
elseif text == 'تعطيل الزخرفه' and Owner(msg) then  
redis:set(bot_id..'Status:Lock:zhrf_Bots'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'᥀︙تم تعطيل الزخرفه') 
elseif text == 'تفعيل الابراج' and Owner(msg) then   
redis:del(bot_id..'Status:Lock:brj_Bots'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل الابراج') 
elseif text == 'تعطيل الابراج' and Owner(msg) then  
redis:set(bot_id..'Status:Lock:brj_Bots'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'᥀︙تم تعطيل الابراج') 
elseif text and text:match("^زخرفه (.*)$") and not redis:get(bot_id..'Status:Lock:zhrf_Bots'..msg.chat_id_) then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://black-source.tk/BlackTeAM/frills.php?en='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n᥀️︙قائمه الزخرفه \n — — — — — — — — — \n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  `"..v.."` \n"
end
send(msg.chat_id_, msg.id_, t..' — — — — — — — — —\n᥀︙اضغط على الاسم ليتم نسخه')
elseif text and text:match('^وضع وقت التنظيف (%d+)$') and Owner(msg) then 
local Num = text:match('^وضع وقت التنظيف (%d+)$')
redis:set(bot_id..':TiMsg:'..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,"*᥀︙تم وضع وقت التنظيف ( "..Num.." ) ساعه*")
elseif text and text:match("^برج (.*)$") and not redis:get(bot_id..'Status:Lock:brj_Bots'..msg.chat_id_) then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://black-source.tk/BlackTeAM/Horoscopes.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
send(msg.chat_id_, msg.id_, br.ok.hso)
elseif text == "مسح الرابط" and Admin(msg) or text == "حذف الرابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"᥀︙تم ازالة رابط المجموعه")   
redis:del(bot_id.."Status:link:set:Group"..msg.chat_id_) 
elseif text == "حذف الصوره" and Admin(msg) or text == "مسح الصوره" and Admin(msg) then 
https.request("https://api.telegram.org/bot"..token.."/deleteChatPhoto?chat_id="..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"᥀︙تم ازالة صورة المجموعه") 
elseif text == "مسح الترحيب" and Admin(msg) or text == "حذف الترحيب" and Admin(msg) then 
redis:del(bot_id.."Get:Welcome:Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"᥀︙تم ازالة ترحيب المجموعه") 
elseif text == "مسح القوانين" and Admin(msg) or text == "حذف القوانين" and Admin(msg) then  
send(msg.chat_id_, msg.id_,"᥀︙تم ازالة قوانين المجموعه")  
redis:del(bot_id..":Rules:Group"..msg.chat_id_) 
elseif text == 'حذف الايدي' and Owner(msg) or text == 'مسح الايدي' and Owner(msg) then
redis:del(bot_id.."Set:Id:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '᥀︙تم ازالة كليشة الايدي ')
elseif text == 'مسح رسائلي' then
redis:del(bot_id..'Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_)
redis:del(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'᥀︙تم مسح جميع رسائلك ') 
elseif text == 'مسح الرسائل المضافه' then
redis:del(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'᥀︙تم مسح جميع رسائلك ') 
elseif text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
redis:del(bot_id..'Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'᥀︙تم مسح جميع تعديلاتك ') 
elseif text == 'مسح جهاتي' then
redis:del(bot_id..'Num:Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'᥀︙تم مسح جميع جهاتك المضافه ') 
elseif text ==("مسح") and Admin(msg) and tonumber(msg.reply_to_message_id_) > 0 then
Delete_Message(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, delbans, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})
elseif text and text:match("^وضع تكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Num:Spam" ,text:match("^وضع تكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"᥀︙تم وضع عدد التكرار : "..text:match("^وضع تكرار (%d+)$").."")  
elseif text and text:match("^وضع زمن التكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."Spam:Group:User"..msg.chat_id_ ,"Num:Spam:Time" ,text:match("^وضع زمن التكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"᥀︙تم وضع زمن التكرار : "..text:match("^وضع زمن التكرار (%d+)$").."") 
elseif text == "ضع رابط" and Admin(msg) or text == "وضع رابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"᥀︙ارسل رابط المجموعه او رابط قناة المجموعه")
redis:setex(bot_id.."Status:link:set"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
elseif text and text:match("^ضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 or text and text:match("^وضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 then  
redis:set(bot_id.."Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_,true) 
send(msg.chat_id_,msg.id_,"᥀︙ارسل الصوره لوضعها") 
elseif text == "ضع وصف" and Admin(msg) or text == "وضع وصف" and Admin(msg) then  
redis:setex(bot_id.."Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"᥀︙ارسل الان الوصف")
elseif text == "ضع ترحيب" and Admin(msg) or text == "وضع ترحيب" and Admin(msg) then  
redis:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"᥀︙ارسل لي الترحيب الان".."\n᥀︙تستطيع اضافة مايلي !\n᥀︙دالة عرض الاسم »{`name`}\n᥀︙دالة عرض المعرف »{`user`}") 
elseif text == "ضع قوانين" and Admin(msg) or text == "وضع قوانين" and Admin(msg) then 
redis:setex(bot_id.."Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"᥀︙ارسل لي القوانين الان")  
elseif text == 'وضع كليشه المطور' and Dev_VINES(msg) then
redis:set(bot_id..'GetTexting:DevVINES'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'᥀︙ ارسل لي الكليشه الان')
elseif text and text:match("^ضع اسم (.*)") and Owner(msg) or text and text:match("^وضع اسم (.*)") and Owner(msg) then 
local Name = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"᥀︙ البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"᥀︙ ليست لدي صلاحية تغير اسم المجموعه")  
else
send(msg.chat_id_,msg.id_,"᥀︙ تم تغيير اسم المجموعه الى {["..Name.."]}")  
end
end,nil) 
elseif text == 'روابط الكروبات' and Dev_VINES(msg) then
local list = redis:smembers(bot_id..'ChekBotAdd') 
test = '᥀︙روابط الكروبات \n\n'
for k,v in pairs(list) do 
local link = redis:get(bot_id.."Status:link:set:Group"..v)   
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..v)) 
if link then  
test = test..""..k.."- » "..v.."\n { "..link.."}\n"
else
test = test..""..k.."- » "..v.."\n { "..(linkgpp.result or 'no link').."}\n"
end
end
local f = io.open('Link_Groups.txt', 'w')
f:write(test)
f:close()
sendDocument(msg.chat_id_, msg.id_,'./Link_Groups.txt', '\nLink_Groups.txt')
elseif text == "الترحيب" and Admin(msg) then 
if redis:get(bot_id.."Get:Welcome:Group"..msg.chat_id_)   then 
Welcome = redis:get(bot_id.."Get:Welcome:Group"..msg.chat_id_)  
else 
Welcome = "᥀︙لم يتم تعيين ترحيب للمجموعه"
end 
send(msg.chat_id_, msg.id_,"["..Welcome.."]") 
elseif text == ("كشف البوتات") and Admin(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n᥀︙قائمة البوتات \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ""
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = " {★}"
end
text = text..": [@"..ta.username_.."]"..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "᥀︙لا توجد بوتات في المجموعه")
return false 
end
if #admins == i then 
local a = "\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n᥀︙عدد البوتات التي هنا : "..n.." بوت"
local f = "\n᥀︙عدد البوتات التي هي ادمن : "..t.."\n᥀︙ملاحضه علامة النجمه يعني البوت ادمن - ★ \n"
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
elseif text == "القوانين" then 
local Set_Rules = redis:get(bot_id..":Rules:Group" .. msg.chat_id_)   
if Set_Rules then 
send(msg.chat_id_,msg.id_, Set_Rules)   
else  
send(msg.chat_id_, msg.id_,"᥀︙لا توجد قوانين هنا")   
end
elseif text == "اضف امر" and Constructor(msg) then
redis:set(bot_id.."Set:Za:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"᥀︙الان ارسل لي الامر القديم ...")  
elseif text == "حذف امر" and Constructor(msg) or text == "مسح امر" and Constructor(msg) then 
redis:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"᥀︙ارسل الان الامر الذي قمت بوضعه مكان الامر القديم")  
elseif text and text:match("^مسح صلاحيه (.*)$") and Admin(msg) or text and text:match("^حذف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^مسح صلاحيه (.*)$") or text:match("^حذف صلاحيه (.*)$")
redis:del(bot_id.."Add:Validity:Group:Rt"..ComdNew..msg.chat_id_)
redis:srem(bot_id.."Validitys:Group"..msg.chat_id_,ComdNew)  
send(msg.chat_id_, msg.id_, "\n᥀︙تم مسح ← { "..ComdNew..' } من الصلاحيات') 
elseif text and text:match("^اضف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^اضف صلاحيه (.*)$")
redis:set(bot_id.."Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
redis:sadd(bot_id.."Validitys:Group"..msg.chat_id_,ComdNew)  
redis:setex(bot_id.."Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "\n᥀︙ارسل نوع الصلاحيه كما مطلوب منك :\n᥀︙انواع الصلاحيات المطلوبه ← { عضو ، مميز  ، ادمن  ، مدير }") 
elseif text and text:match("^تغير رد المطور (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
redis:set(bot_id.."Developer:Bot:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد المطور الى :"..Teext)
elseif text and text:match("^تغير رد المالك (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المالك (.*)$") 
redis:set(bot_id.."President:User:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد المالك الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ الاساسي (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
redis:set(bot_id.."Basic:User:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
redis:set(bot_id.."Constructor:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغير رد المدير (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
redis:set(bot_id.."Manager:Group:Reply"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد المدير الى :"..Teext)
elseif text and text:match("^تغير رد الادمن (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
redis:set(bot_id.."Admin:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد الادمن الى :"..Teext)
elseif text and text:match("^تغير رد المميز (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
redis:set(bot_id.."Vip:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد المميز الى :"..Teext)
elseif text and text:match("^تغير رد العضو (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
redis:set(bot_id.."Mempar:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"᥀︙ تم تغير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' and Owner(msg) then
redis:del(bot_id.."Developer:Bot:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"᥀︙تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' and Owner(msg) then
redis:del(bot_id.."Basic:User:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"᥀︙تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المنشئ' and Owner(msg) then
redis:del(bot_id.."Constructor:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"᥀︙تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' and Owner(msg) then
redis:del(bot_id.."Manager:Group:Reply"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"᥀︙تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' and Owner(msg) then
redis:del(bot_id.."Admin:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"᥀︙تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' and Owner(msg) then
redis:del(bot_id.."Vip:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"᥀︙تم حذف رد المميز")
elseif text == 'حذف رد العضو' and Owner(msg) then
redis:del(bot_id.."Mempar:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"᥀︙تم حذف رد العضو")
elseif text == ("مسح ردود المدير") and Owner(msg) then
local list = redis:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
for k,v in pairs(list) do
redis:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) 
redis:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
redis:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
redis:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
redis:del(bot_id.."List:Manager"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"᥀︙تم مسح قائمه ردود المدير")
elseif text == ("ردود المدير") and Owner(msg) then
local list = redis:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
text = "᥀︙قائمه ردود المدير \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if redis:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = "متحركه 🎭"
elseif redis:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = "بصمه 📢"
elseif redis:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = "ملصق 🃏"
elseif redis:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = "رساله ✉"
elseif redis:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = "صوره 🎇"
elseif redis:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = "فيديو 📹"
elseif redis:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = "ملف 📁"
elseif redis:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = "اغنيه 🎵"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
if #text > 7000 then
send(msg.chat_id_, msg.id_,  text)
text = ""
end
end
if #list == 0 then
text = "᥀︙لاتوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
elseif text == "اضف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"᥀︙ارسل الان الكلمه لاضافتها في ردود المدير ")
redis:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
elseif text == "حذف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"᥀︙ارسل الان الكلمه لحذفها من ردود المدير")
redis:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
elseif text == ("مسح ردود المطور") and Dev_VINES(msg) then 
local list = redis:smembers(bot_id.."List:Rd:Sudo")
for k,v in pairs(list) do
redis:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
redis:del(bot_id.."Add:Rd:Sudo:vico"..v)   
redis:del(bot_id.."Add:Rd:Sudo:stekr"..v) 
redis:del(bot_id.."Add:Rd:Sudo:Text"..v)   
redis:del(bot_id.."Add:Rd:Sudo:Photo"..v)
redis:del(bot_id.."Add:Rd:Sudo:Video"..v)
redis:del(bot_id.."Add:Rd:Sudo:File"..v)
redis:del(bot_id.."Add:Rd:Sudo:Audio"..v)
redis:del(bot_id.."List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"᥀︙تم حذف ردود المطور")
elseif text == ("ردود المطور") and Dev_VINES(msg) then 
local list = redis:smembers(bot_id.."List:Rd:Sudo")
text = "\n᥀︙قائمة ردود المطور \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
if redis:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif redis:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif redis:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif redis:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif redis:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif redis:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif redis:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = "ملف 📁"
elseif redis:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
if #text > 7000 then
send(msg.chat_id_, msg.id_,  text)
text = ""
end
end
if #list == 0 then
text = "᥀︙لاتوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
elseif text == "اضف رد للكل" and Dev_VINES(msg) then 
send(msg.chat_id_, msg.id_,"᥀︙ارسل الان الكلمه لاضافتها في ردود المكور ")
redis:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
elseif text == "حذف رد للكل" and Dev_VINES(msg) then 
send(msg.chat_id_, msg.id_,"᥀︙ارسل الان الكلمه لحذفها من ردود المطور")
redis:set(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
end
if text and text:match("^تنزيل الكل @(.*)$") and Owner(msg) then
print('&&&')
function FunctionStatus(extra, result, success)
if (result.id_) then
if Dev_VINES_User(result.id_) == true then
send(msg.chat_id_, msg.id_,"᥀︙لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."Developer:Bot",result.id_) then
dev = "᥀︙( المطور ... ✓️) \n" else dev = "" end
if redis:sismember(bot_id.."President:User"..msg.chat_id_, result.id_) then
mal = "᥀︙( المالك ... ✓️) \n" else mal = "" end
if redis:sismember(bot_id.."Basic:User"..msg.chat_id_, result.id_) then
crr = "᥀︙( المنشئ الاساسي ... ✓️) \n" else crr = "" end
if redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, result.id_) then
cr = "᥀︙( المنشئ ... ✓️) \n" else cr = "" end
if redis:sismember(bot_id..'Manager:Group'..msg.chat_id_, result.id_) then
own = "᥀︙( المدير ... ✓️) \n" else own = "" end
if redis:sismember(bot_id..'Admin:Group'..msg.chat_id_, result.id_) then
mod = "᥀︙( الادمن ... ✓️) \n" else mod = "" end
if redis:sismember(bot_id..'Vip:Group'..msg.chat_id_, result.id_) then
vip = "᥀︙( عضو مميز ... ✓️) \n" else vip = ""
end
if Rank_Checking(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n᥀︙ تم تنزيله من الرتب الاتيه : \n\n"..mal..""..dev..""..crr..""..cr..""..own..""..mod..""..vip.."")
else
send(msg.chat_id_, msg.id_,"\n᥀︙ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_VINES_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."Developer:Bot", result.id_)
redis:srem(bot_id.."President:User"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Basic:User"..msg.chat_id_,result.id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id.."Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id.."Basic:User"..msg.chat_id_,result.id_)
redis:srem(bot_id.."President:User"..msg.chat_id_,result.id_)
elseif redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id.."Basic:User"..msg.chat_id_,result.id_)
elseif redis:sismember(bot_id.."Basic:User"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, FunctionStatus, nil)
end
if text and text:match("^وضع لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.result.can_promote_members == false then
send(msg.chat_id_, msg.id_,'*᥀︙لا يمكنني تعديل  او وضع لقب ليس لدي صلاحيه*') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n*᥀︙العضو »* ['..data.first_name_..'](t.me/'..(data.username_ or 'TeLaNd')..') '
status  = '\n*᥀︙الايدي »* '..result.sender_user_id_..'\n*᥀︙تم ضافه {'..timsh..'} كلقب له*'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == 'لقبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
send(msg.chat_id_, msg.id_,'*᥀︙ لقبه هو :* '..getcustom(msg,result)) 
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == 'لقبي' and tonumber(msg.reply_to_message_id_) == 0 then
send(msg.chat_id_, msg.id_,'*᥀︙ لقبك هو :* '..getcustom(msg,msg)) 
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_VINES_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_,"᥀︙لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."Developer:Bot",result.sender_user_id_) then
dev = "᥀︙( المطور ... ✓️) \n" else dev = "" end
if redis:sismember(bot_id.."President:User"..msg.chat_id_, result.id_) then
mal = "᥀︙( المالك ... ✓️) \n" else mal = "" end
if redis:sismember(bot_id.."Basic:User"..msg.chat_id_, result.sender_user_id_) then
crr = "᥀︙( المنشئ الاساسي ... ✓️) \n" else crr = "" end
if redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, result.sender_user_id_) then
cr = "᥀︙( المنشئ ... ✓️) \n" else cr = "" end
if redis:sismember(bot_id..'Manager:Group'..msg.chat_id_, result.sender_user_id_) then
own = "᥀︙( المدير ... ✓️) \n" else own = "" end
if redis:sismember(bot_id..'Admin:Group'..msg.chat_id_, result.sender_user_id_) then
mod = "᥀︙( الادمن ... ✓️) \n" else mod = "" end
if redis:sismember(bot_id..'Vip:Group'..msg.chat_id_, result.sender_user_id_) then
vip = "᥀︙( عضو مميز ... ✓️) \n" else vip = ""
end
if Rank_Checking(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n᥀︙ تم تنزيله من الرتب الاتيه : \n\n"..mal..""..dev..""..crr..""..cr..""..own..""..mod..""..vip.."")
else
send(msg.chat_id_, msg.id_,"\n᥀︙ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_VINES_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."Developer:Bot", result.sender_user_id_)
redis:srem(bot_id.."President:User"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Basic:User"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id.."Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id.."Basic:User"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."President:User"..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember(bot_id.."President:User"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id.."Basic:User"..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember(bot_id.."Basic:User"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Constructor:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Manager:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'Vip:Group'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
elseif text == 'بايو' then   
send(msg.chat_id_, msg.id_,getbio(msg.sender_user_id_)) 
elseif text == "رتبتي" then
local rtp = Get_Rank(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,"᥀︙ رتبتك في البوت : "..rtp)
elseif text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = "᥀︙ اسمك الاول : `"..(result.first_name_).."`"
else
first_name = ""
end   
if result.last_name_ then 
last_name = "᥀︙ اسمك الثاني ← : `"..result.last_name_.."`" 
else
last_name = ""
end  
send(msg.chat_id_, msg.id_,first_name.."\n"..last_name) 
end,nil)
elseif text==("عدد الكروب") and Admin(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"᥀︙ البوت ليس ادمن هنا \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID = "GetChannelFull",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
local taha = "᥀︙ عدد الادمنيه : "..data.administrator_count_..
"\n᥀︙ عدد المطرودين : "..data.kicked_count_..
"\n᥀︙ عدد الاعضاء : "..data.member_count_..
"\n᥀︙ عدد رسائل الكروب : "..(msg.id_/2097152/0.5)..
"\n᥀︙ اسم المجموعه : ["..ta.title_.."]"
send(msg.chat_id_, msg.id_, taha) 
end,nil)end,nil)
elseif text == "الرابط" then 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local status_Link = redis:get(bot_id.."Link_Group"..msg.chat_id_)
if status_Link then
send(msg.chat_id_, msg.id_,"᥀︙جلب الرابط معطل") 
return false  
end
local link = redis:get(bot_id.."Status:link:set:Group"..msg.chat_id_)
if link then  
inline = {
{{text=ta.title_,url=link}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_,"["..link.."]",nil,inline,msg_id) 
else
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
inline = {
{{text=ta.title_,url=linkgpp.result}},
}
local msg_id = msg.id_/2097152/0.5
send_inline_keyboard(msg.chat_id_,"["..linkgpp.result.."]",nil,inline,msg_id) 
redis:set(bot_id.."Status:link:set:Group"..msg.chat_id_,linkgpp.result)
else
send(msg.chat_id_, msg.id_,"᥀︙لا يوجد رابط للمجموعه")  
end
end
end,nil)
elseif text == "تحديث الرابط" and Admin(msg) then
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
send(msg.chat_id_,msg.id_,"᥀︙تم تحديث رابط المجموعه")   
redis:set(bot_id.."Status:link:set:Group"..msg.chat_id_,linkgpp.result)
elseif text == "غادر" then 
if DeveloperBot(msg) and not redis:get(bot_id.."Status:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"᥀︙تم حبيبي حغادر") 
redis:srem(bot_id.."ChekBotAdd",msg.chat_id_)  
end
elseif text and text:match("^غادر (-%d+)$") then
local GP_ID = {string.match(text, "^(غادر) (-%d+)$")}
if DeveloperBot(msg) and not redis:get(bot_id.."Status:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=GP_ID[2],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"᥀︙تم حبيبي حغادر") 
send(GP_ID[2], 0,"᥀︙ تم مغادرة المجموعه بامر من مطور البوت") 
redis:srem(bot_id.."ChekBotAdd",GP_ID[2])  
end
elseif text == Name_Bot then
local namebot = {
"لابسك لتلح",
"لاتوصخ اسمي",
"هاقلبي؟ كول",
"دعبل يمعود",
"اهو شتريد ؟"
}
name = math.random(#namebot)
send(msg.chat_id_, msg.id_, namebot[name]) 
elseif text == "بوت" then
local BotName = {
"باوع لك خليني احبك وصيحلي باسمي "..Name_Bot.. "",
"لتخليني ارجع لحركاتي لقديمه وردا ترا اسمي "..Name_Bot.. "",
"راح نموت بكورونا ونته بعدك تصيح بوت"
}
BotNameText = math.random(#BotName)
send(msg.chat_id_, msg.id_,BotName[BotNameText]) 
elseif text == "تغير اسم البوت" and Dev_VINES(msg) or text == "تغيير اسم البوت" and Dev_VINES(msg) then 
redis:setex(bot_id.."Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"᥀︙ ارسل لي الاسم الان ")  
elseif text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Status:Broadcasting:Bot") and not Dev_VINES(msg) then 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي المنشور الان\n᥀︙يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n᥀︙لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Status:Broadcasting:Bot") and not Dev_VINES(msg) then 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي المنشور الان\n᥀︙يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n᥀︙لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."Status:Broadcasting:Bot") and not Dev_VINES(msg) then 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي المنشور الان\n᥀︙يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n᥀︙لالغاء الاذاعه ارسل : الغاء") 
return false
elseif text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."Status:Broadcasting:Bot") and not Dev_VINES(msg) then 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي التوجيه الان\n᥀︙ليتم نشره في المجموعات") 
return false
elseif text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."Status:Broadcasting:Bot") and not Dev_VINES(msg) then 
send(msg.chat_id_, msg.id_,"᥀︙تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"᥀︙ارسل لي التوجيه الان\n᥀︙ليتم نشره الى المشتركين") 
return false

elseif text == "الاعدادات" and Admin(msg) then
if redis:get(bot_id.."Status:lockpin"..msg.chat_id_) then
lock_pin = "{✔️}"
else 
lock_pin = "{✖}"
end
if redis:get(bot_id.."Status:Lock:tagservr"..msg.chat_id_) then
lock_tagservr = "{✔️}"
else 
lock_tagservr = "{✖}"
end
if redis:get(bot_id.."Status:Lock:text"..msg.chat_id_) then
lock_text = "← {✔️}"
else 
lock_text = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:AddMempar"..msg.chat_id_) == "kick" then
lock_add = "← {✔️}"
else 
lock_add = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Join"..msg.chat_id_) == "kick" then
lock_join = "← {✔️}"
else 
lock_join = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:edit"..msg.chat_id_) then
lock_edit = "← {✔️}"
else 
lock_edit = "← {✖}"
end
if redis:get(bot_id.."Chek:Welcome"..msg.chat_id_) then
welcome = "← {✔️}"
else 
welcome = "← {✖}"
end
if redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_, "Spam:User") == "kick" then 
flood = "← { بالطرد }" 
elseif redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Spam:User") == "keed" then 
flood = "← { بالتقيد }" 
elseif redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Spam:User") == "mute" then 
flood = "← { بالكتم }"   
elseif redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Spam:User") == "del" then 
flood = "← {✔️}"
else 
flood = "← {✖}" 
end
if redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "del" then
lock_photo = "← {✔️}" 
elseif redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = "← { بالتقيد }"   
elseif redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = "← { بالطرد }"   
else
lock_photo = "← {✖}"   
end
if redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "del" then
lock_phon = "← {✔️}" 
elseif redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = "← { بالطرد }"
else
lock_phon = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "del" then
lock_links = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "ked" then
lock_links = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "ktm" then
lock_links = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) == "kick" then
lock_links = "← { بالطرد }"
else
lock_links = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = "← { بالكتم }"   
elseif redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = "← { بالطرد }"
else
lock_cmds = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "del" then
lock_user = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "ked" then
lock_user = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "ktm" then
lock_user = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) == "kick" then
lock_user = "← { بالطرد }"
else
lock_user = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = "← { بالطرد }"
else
lock_hash = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "del" then
lock_muse = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = "← { بالطرد }"
else
lock_muse = "← {✖}"
end 
if redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "del" then
lock_ved = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = "← { بالطرد }"
else
lock_ved = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "del" then
lock_gif = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = "← { بالطرد }"
else
lock_gif = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = "بالتقيد "
elseif redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = "بالكتم "
elseif redis:get(bot_id.."Status:Lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = "← { بالطرد }"
else
lock_ste = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "del" then
lock_geam = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = "← { بالطرد }"
else
lock_geam = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "del" then
lock_vico = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = "← { بالطرد }"
else
lock_vico = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = "← { بالطرد }"
else
lock_inlin = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "del" then
lock_fwd = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = "← { بالطرد }"
else
lock_fwd = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "del" then
lock_file = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "ked" then 
lock_file = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Document"..msg.chat_id_) == "kick" then 
lock_file = "← { بالطرد }"
else
lock_file = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = "← { بالطرد }"
else
lock_self = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_) == "del" then
lock_bots = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_) == "ked" then
lock_bots = "← { بالتقيد }"   
elseif redis:get(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_) == "kick" then
lock_bots = "← { بالطرد }"
else
lock_bots = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = "← { بالطرد }"
else
lock_mark = "← {✖}"
end
if redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "del" then
lock_spam = "← {✔️}"
elseif redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = "← { بالتقيد }"
elseif redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = "← { بالكتم }"
elseif redis:get(bot_id.."Status:Lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = "← { بالطرد }"
else
lock_spam = "← {✖}"
end
if not redis:get(bot_id.."Status:Reply:Manager"..msg.chat_id_) then
ReplyManager = "← {✔️}"
else
ReplyManager = "← {✖}"
end
if not redis:get(bot_id.."Status:Reply:Sudo"..msg.chat_id_) then
ReplySudo = "← {✔️}"
else
ReplySudo = "← {✖}"
end
if not redis:get(bot_id.."Status:Lock:Id:Photo"..msg.chat_id_)  then
IdPhoto = "← {✔️}"
else
IdPhoto = "← {✖}"
end
if not redis:get(bot_id.."Status:Lock:Id:Py:Photo"..msg.chat_id_) then
IdPyPhoto = "← {✔️}"
else
IdPyPhoto = "← {✖}"
end
if not redis:get(bot_id.."Status:Cheking:Kick:Me:Group"..msg.chat_id_)  then
KickMe = "← {✔️}"
else
KickMe = "← {✖}"
end
if not redis:get(bot_id.."Status:Lock:Ban:Group"..msg.chat_id_)  then
Banusers = "← {✔️}"
else
Banusers = "← {✖}"
end
if not redis:get(bot_id.."Status:Cheking:Seted"..msg.chat_id_) then
Setusers = "← {✔️}"
else
Setusers = "← {✖}"
end
if redis:get(bot_id.."Link_Group"..msg.chat_id_) then
Link_Group = "← {✔️}"
else
Link_Group = "← {✖}"
end
if not redis:get(bot_id.."Status:Fun:Group"..msg.chat_id_) then
FunGroup = "← {✔️}"
else
FunGroup = "← {✖}"
end
local Num_Flood = redis:hget(bot_id.."Spam:Group:User"..msg.chat_id_,"Num:Spam") or 0
send(msg.chat_id_, msg.id_,"*\n᥀︙اعدادات المجموعه "..
"\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"..
"\n᥀︙علامة ال (✔️) تعني مفعل"..
"\n᥀︙علامة ال (✖) تعني معطل"..
"\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"..
"\n᥀︙الروابط "..lock_links..
"\n".."᥀︙الكلايش "..lock_spam..
"\n".."᥀︙الكيبورد "..lock_inlin..
"\n".."᥀︙الاغاني "..lock_vico..
"\n".."᥀︙المتحركه "..lock_gif..
"\n".."᥀︙الملفات "..lock_file..
"\n".."᥀︙الدردشه "..lock_text..
"\n".."᥀︙الفيديو "..lock_ved..
"\n".."᥀︙الصور "..lock_photo..
"\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"..
"\n".."᥀︙المعرفات  "..lock_user..
"\n".."᥀︙التاك "..lock_hash..
"\n".."᥀︙البوتات "..lock_bots..
"\n".."᥀︙التوجيه "..lock_fwd..
"\n".."᥀︙الصوت "..lock_muse..
"\n".."᥀︙الملصقات "..lock_ste..
"\n".."᥀︙الجهات "..lock_phon..
"\n".."᥀︙الدخول "..lock_join..
"\n".."᥀︙الاضافه "..lock_add..
"\n".."᥀︙السيلفي "..lock_self..
"\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"..
"\n".."᥀︙التثبيت "..lock_pin..
"\n".."᥀︙الاشعارات "..lock_tagservr..
"\n".."᥀︙الماركدون "..lock_mark..
"\n".."᥀︙التعديل "..lock_edit..
"\n".."᥀︙الالعاب "..lock_geam..
"\n".."᥀︙التكرار "..flood..
"\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"..
"\n".."᥀︙الترحيب "..welcome..
"\n".."᥀︙الرفع "..Setusers..
"\n".."᥀︙الطرد "..Banusers..
"\n".."᥀︙الايدي "..IdPhoto..
"\n".."᥀︙الايدي بالصوره "..IdPyPhoto..
"\n".."᥀︙اطردني "..KickMe..
"\n".."᥀︙ردود المدير "..ReplyManager..
"\n".."᥀︙ردود المطور "..ReplySudo..
"\n".."᥀︙اوامر التحشيش "..FunGroup..
"\n".."᥀︙جلب الرابط "..Link_Group..
"\n".."᥀︙عدد التكرار ← {"..Num_Flood.."}\n\n.*") 
elseif text == 'تعين الايدي' and Owner(msg) then
redis:setex(bot_id.."Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
send(msg.chat_id_, msg.id_,[[
᥀︙ارسل الان النص
᥀︙يمكنك اضافه :
᥀︙`#username` » اسم المستخدم
᥀︙`#msgs` » عدد الرسائل
᥀︙`#photos` » عدد الصور
᥀︙`#id` » ايدي المستخدم
᥀︙`#auto` » نسبة التفاعل
᥀︙`#stast` » رتبة المستخدم 
᥀︙`#edit` » عدد السحكات
᥀︙`#game` » عدد المجوهرات
᥀︙`#AddMem` » عدد الجهات
᥀︙`#Description` » تعليق الصوره
᥀︙ قناة الكلايش • @jEEEEI
]])
return false  
elseif text == 'تغير الايدي' and Owner(msg) then 
local List = {
[[
᥀︙Msgs : #msgs
᥀︙ID : #id
᥀︙Stast : #stast
᥀︙UserName : #username
]],
[[
ᯓ 𝟔𝟔𝟔𖡋 #username 
ᯓ 𝟔𝟔𝟔𖡋 #stast  
ᯓ 𝟔𝟔𝟔𖡋 #id  
ᯓ 𝟔𝟔𝟔𖡋 #msgs  
ᯓ 𝟔𝟔𝟔𖡋 #game
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬𝐭𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
.?? 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game 
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]]}
local Text_Rand = List[math.random(#List)]
redis:set(bot_id.."Set:Id:Group"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'᥀︙ تم تغير الايدي ارسل ايدي لرؤيته')
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id..'Status:Lock:Id:Photo'..msg.chat_id_) then
function Function_Status(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'᥀︙ الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local DevZain = data.first_name_..' '..(data.last_name_ or "")
local Status_Gps = Get_Rank(Id,msg.chat_id_)
send(msg.chat_id_, msg.id_,'\n*᥀︙الاسم ← ('..DevZain..')\n᥀︙الايدي ← '..Id..'\n᥀︙المعرف ← *['..UserName_User..']*\n᥀︙الرتبة ← '..Status_Gps..'\n᥀︙نوع الكشف ←بالرد*') 
end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
return false
elseif text and text:match("^كشف @(.*)$") and not redis:get(bot_id..'Status:Lock:Id:Photo'..msg.chat_id_) then
local username = text:match("^كشف @(.*)$")
function Function_Status(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local DevZain = data.first_name_..' '..(data.last_name_ or "")
local Status_Gps = Get_Rank(Id,msg.chat_id_)
send(msg.chat_id_, msg.id_,'\n*᥀︙الاسم ← ('..DevZain..')\n᥀︙الايدي ← '..Id..'\n᥀︙المعرف ← *['..UserName_User..']*\n᥀︙الرتبة ← '..Status_Gps..'\n᥀︙نوع الكشف ←بالمعرف*') 
end,nil)   
else
send(msg.chat_id_, msg.id_,'᥀︙لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
return false
elseif text and text:match("^كشف (%d+)$") and GetChannelMember(msg) then  
tdcli_function ({ID = "GetUser",user_id_ = text:match("^كشف (%d+)$")},function(arg,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'᥀︙ الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local DevZain = data.first_name_..' '..(data.last_name_ or "")
local Status_Gps = Get_Rank(Id,msg.chat_id_)
send(msg.chat_id_, msg.id_,'\n*᥀︙الاسم ← ('..DevZain..')\n᥀︙الايدي ← '..Id..'\n᥀︙المعرف ← *['..UserName_User..']*\n᥀︙الرتبة ← '..Status_Gps..'\n᥀︙نوع الكشف ←بالايدي*') 
end,nil)   
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) == 0 and not redis:get(bot_id..'Status:Lock:Id:Photo'..msg.chat_id_) and GetChannelMember(msg) then  
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,taha,success) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = msg.sender_user_id_
local NumMsgg1 = redis:get(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local nummsg = redis:get(bot_id..'Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 1 
local NumMsg = (NumMsgg1 + nummsg)
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Num_Games = redis:get(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
local Add_Mem = redis:get(bot_id.."Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
local Total_Photp = (taha.total_count_ or 0)
local Texting = {
'ملاك وناسيك بكروبنه😟',
"حلغوم والله☹️ ",
"اطلق صوره🐼❤️",
"كيكك والله🥺",
"لازك بيها غيرها عاد😒",
}
local Description = Texting[math.random(#Texting)]
local Get_Is_Id = redis:get(bot_id.."Set:Id:Group"..msg.chat_id_)
if not redis:get(bot_id..'Status:Lock:Id:Py:Photo'..msg.chat_id_) then
if taha.photos_[0] then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
sendPhoto(msg.chat_id_,msg.id_,taha.photos_[0].sizes_[1].photo_.persistent_id_,Get_Is_Id)
else
sendPhoto(msg.chat_id_,msg.id_,taha.photos_[0].sizes_[1].photo_.persistent_id_,'᥀︙'..Description..'\n᥀︙ايديك ← '..Id..'\n᥀︙معرفك ← '..UserName_User..'\n᥀︙رتبتك ← '..Status_Gps..'\n᥀︙رسائلك ← '..NumMsg..'\n᥀︙السحكات ← '..NumMessageEdit..' \n᥀︙تتفاعلك ← '..TotalMsg..'\n᥀︙ مجوهراتك ← '..Num_Games)
end
else
send(msg.chat_id_, msg.id_,'\n*᥀︙ايديك ← '..Id..'\n᥀︙معرفك ← *['..UserName_User..']*\n᥀︙رتبتك ← '..Status_Gps..'\n᥀︙رسائلك ← '..NumMsg..'\n᥀︙السحكات ← '..NumMessageEdit..' \n᥀︙تتفاعلك ← '..TotalMsg..'\n᥀︙ مجوهراتك ← '..Num_Games..'*') 
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
send(msg.chat_id_, msg.id_,'['..Get_Is_Id..']') 
else
send(msg.chat_id_, msg.id_,'\n*᥀︙ايديك ← '..Id..'\n᥀︙معرفك ← *['..UserName_User..']*\n᥀︙رتبتك ← '..Status_Gps..'\n᥀︙رسائلك ← '..NumMsg..'\n᥀︙السحكات ← '..NumMessageEdit..' \n᥀︙تتفاعلك ← '..TotalMsg..'\n᥀︙ مجوهراتك ← '..Num_Games..'*') 
end
end
end,nil)   
end,nil)   
end

if text and text:match('^تنظيف (%d+)$') and Admin(msg) or text and text:match('^حذف (%d+)$') and Admin(msg) or text and text:match('^مسح (%d+)$') and Admin(msg) then
local Msg_Num = tonumber(text:match('^تنظيف (%d+)$')) or tonumber(text:match('^حذف (%d+)$'))  or tonumber(text:match('^مسح (%d+)$')) 
if Msg_Num > 1000 then 
send(msg.chat_id_, msg.id_,'᥀︙تستطيع حذف *(1000)* رساله فقط') 
return false  
end  
lk_lkid = {[0]=msg.id_}
local Message = msg.id_
new = 0
for i=1,tonumber(Msg_Num) do
Message = Message - 1048576
lk_lkid[i] = Message
end
Delete_Message(msg.chat_id_,lk_lkid)
send(msg.chat_id_, msg.id_,'᥀︙تم ازالة *- '..Msg_Num..'* رساله من المجموعه')  
elseif text and (text == "تنظيف جميع الميديا" or text == "تنظيف الميديا") and Admin(msg) then   
lk_lkid = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
lk_lkid[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = lk_lkid},function(arg,data)
new = 0
lk_lkid2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and data.messages_[i].content_ and data.messages_[i].content_.ID ~= "MessageText" then
lk_lkid2[new] = data.messages_[i].id_
new = new + 1
end
end
Delete_Message(msg.chat_id_,lk_lkid2)
end,nil)  
send(msg.chat_id_, msg.id_,"᥀︙تم ازالة 100 من وسائط 🛡") 
elseif text and (text == "تنظيف جميع الرسائل المعدله" or text == "تنظيف الرسائل المعدلة" or text == "تنظيف الرسائل المعدله") and Admin(msg) then   
lk_lkid = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
lk_lkid[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = lk_lkid},function(arg,data)
new = 0
lk_lkid2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
lk_lkid2[new] = data.messages_[i].id_
new = new + 1
end
end
Delete_Message(msg.chat_id_,lk_lkid2)
end,nil)  
send(msg.chat_id_, msg.id_,'᥀︙تم ازالة 100 رساله معدلة 🛡') 
elseif text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id..'Status:Lock:Id:Photo'..msg.chat_id_) then
function Function_Status(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'᥀︙ الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsgg1 = redis:get(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..data.id_) or 0
local nummsg = redis:get(bot_id..'Num:Message:User'..msg.chat_id_..':'..data.id_) or 1 
local NumMsg = (NumMsgg1 + nummsg)
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."Status:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*᥀︙ايديه ← '..Id..'\n᥀︙رسائله ← '..NumMsg..'\n᥀︙معرفه ← *['..UserName_User..']*\n᥀︙تفاعله ← '..TotalMsg..'\n᥀︙رتبته ← '..Status_Gps..'\n᥀︙تعديلاته ← '..NumMessageEdit..'\n᥀︙جهاته ← '..Add_Mem..'*') 
end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
return false
elseif text and text:match("^ايدي @(.*)$") and not redis:get(bot_id..'Status:Lock:Id:Photo'..msg.chat_id_) then
local username = text:match("^ايدي @(.*)$")
function Function_Status(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsgg1 = redis:get(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..data.id_) or 0
local nummsg = redis:get(bot_id..'Num:Message:User'..msg.chat_id_..':'..data.id_) or 1 
local NumMsg = (NumMsgg1 + nummsg)
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."Status:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*᥀︙ايديه ← '..Id..'\n᥀︙رسائله ← '..NumMsg..'\n᥀︙معرفه ← *['..UserName_User..']*\n᥀︙تفاعله ← '..TotalMsg..'\n᥀︙رتبته ← '..Status_Gps..'\n᥀︙تعديلاته ← '..NumMessageEdit..'\n᥀︙جهاته ← '..Add_Mem..'*') 
end,nil)   
else
send(msg.chat_id_, msg.id_,'᥀︙لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
return false
elseif text == "سمايلات" or text == "سمايل" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Status:Set:Sma"..msg.chat_id_)
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","??","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","🇮🇶","⚔","🛡","🔮","🌡","💣","📌","📍","📓","📗","📂","📅","📪","📫","📬","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
redis:set(bot_id.."Status:Random:Sm"..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,"᥀︙اسرع واحد يدز هاذا السمايل ? ~ {`"..SM.."`}")
return false
end
elseif text == "الاسرع" or tect == "ترتيب" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Status:Speed:Tr"..msg.chat_id_)
KlamSpeed = {"سحور","سياره","استقبال","قنفه","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","كهوه","سفينه","العراق","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","بتيته","لهانه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنيت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
redis:set(bot_id.."Status:Klam:Speed"..msg.chat_id_,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفه","ه ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"بزونه","ز و ه ن")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"كهوه","ه ك ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"العراق","ق ع ا ل ر ا")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"بتيته","ب ت ت ي ه")
name = string.gsub(name,"لهانه","ه ن ل ه ل")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنيت","ا ت ن ر ن ي ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
send(msg.chat_id_, msg.id_,"᥀︙اسرع واحد يرتبها ~ {"..name.."}")
return false
end
elseif text == "حزوره" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Status:Set:Hzora"..msg.chat_id_)
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
redis:set(bot_id.."Status:Klam:Hzor"..msg.chat_id_,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
send(msg.chat_id_, msg.id_,"᥀︙اسرع واحد يحل الحزوره ↓\n {"..name.."}")
return false
end
elseif text == "معاني" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Status:Set:Maany"..msg.chat_id_)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
redis:set(bot_id.."Status:Maany"..msg.chat_id_,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","🦔")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
send(msg.chat_id_, msg.id_,"᥀︙اسرع واحد يدز معنى السمايل ~ {"..name.."}")
return false
end
elseif text == "صراحه" or text == "الصراحه" then
local KtsaMsg = {"صراحه  |  صوتك حلوة؟","صراحه  |  التقيت الناس مع وجوهين؟","صراحه  |  شيء وكنت تحقق اللسان؟","صراحه  |  أنا شخص ضعيف عندما؟","صراحه  |  هل ترغب في إظهار حبك ومرفق لشخص أو رؤية هذا الضعف؟","صراحه  |  يدل على أن الكذب مرات تكون ضرورية شي؟","صراحه  |  أشعر بالوحدة على الرغم من أنني تحيط بك كثيرا؟","صراحه  |  كيفية الكشف عن من يكمن عليك؟","صراحه  |  إذا حاول شخص ما أن يكرهه أن يقترب منك ويهتم بك تعطيه فرصة؟","صراحه  |  أشجع شيء حلو في حياتك؟","صراحه  |  طريقة جيدة يقنع حتى لو كانت الفكرة خاطئة توافق؟","صراحه  |  كيف تتصرف مع من يسيئون فهمك ويأخذ على ذهنه ثم ينتظر أن يرفض؟","صراحه  |  التغيير العادي عندما يكون الشخص الذي يحبه؟","صراحه  |  المواقف الصعبة تضعف لك ولا ترفع؟","صراحه  |  نظرة و يفسد الصداقة؟","صراحه  |  ‏‏إذا أحد قالك كلام سيء بالغالب وش تكون ردة فعلك؟","صراحه  |  شخص معك بالحلوه والمُره؟","صراحه  |  ‏هل تحب إظهار حبك وتعلقك بالشخص أم ترى ذلك ضعف؟","صراحه  |  تأخذ بكلام اللي ينصحك ولا تسوي اللي تبي؟","صراحه  |  وش تتمنى الناس تعرف عليك؟","صراحه  |  ابيع المجرة عشان؟","صراحه  |  أحيانا احس ان الناس ، كمل؟","صراحه  |  مع مين ودك تنام اليوم؟","صراحه  |  صدفة العمر الحلوة هي اني؟","صراحه  |  الكُره العظيم دايم يجي بعد حُب قوي تتفق؟","صراحه  |  صفة تحبها في نفسك؟","صراحه  |  ‏الفقر فقر العقول ليس الجيوب  ، تتفق؟","صراحه  |  تصلي صلواتك الخمس كلها؟","صراحه  |  ‏تجامل أحد على راحتك؟","صراحه  |  اشجع شيء سويتة بحياتك؟","صراحه  |  وش ناوي تسوي اليوم؟","صراحه  |  وش شعورك لما تشوف المطر؟","صراحه  |  غيرتك هاديه ولا تسوي مشاكل؟","صراحه  |  ما اكثر شي ندمن عليه؟","صراحه  |  اي الدول تتمنى ان تزورها؟","صراحه  |  متى اخر مره بكيت؟","صراحه  |  تقيم حظك ؟ من عشره؟","صراحه  |  هل تعتقد ان حظك سيئ؟","صراحه  |  شـخــص تتمنــي الإنتقــام منـــه؟","صراحه  |  كلمة تود سماعها كل يوم؟","صراحه  |  **هل تُتقن عملك أم تشعر بالممل؟","صراحه  |  هل قمت بانتحال أحد الشخصيات لتكذب على من حولك؟","صراحه  |  متى آخر مرة قمت بعمل مُشكلة كبيرة وتسببت في خسائر؟","صراحه  |  ما هو اسوأ خبر سمعته بحياتك؟","‏صراحه  | هل جرحت شخص تحبه من قبل ؟","صراحه  |  ما هي العادة التي تُحب أن تبتعد عنها؟","‏صراحه  | هل تحب عائلتك ام تكرههم؟","‏صراحه  |  من هو الشخص الذي يأتي في قلبك بعد الله – سبحانه وتعالى- ورسوله الكريم – صلى الله عليه وسلم؟","‏صراحه  |  هل خجلت من نفسك من قبل؟","‏صراحه  |  ما هو ا الحلم  الذي لم تستطيع ان تحققه؟","‏صراحه  |  ما هو الشخص الذي تحلم به كل ليلة؟","‏صراحه  |  هل تعرضت إلى موقف مُحرج جعلك تكره صاحبهُ؟","‏صراحه  |  هل قمت بالبكاء أمام من تُحب؟","‏صراحه  |  ماذا تختار حبيبك أم صديقك؟","‏صراحه  | هل حياتك سعيدة أم حزينة؟","صراحه  |  ما هي أجمل سنة عشتها بحياتك؟","‏صراحه  |  ما هو عمرك الحقيقي؟","‏صراحه  |  ما اكثر شي ندمن عليه؟","صراحه  |  ما هي أمنياتك المُستقبلية؟‏","صراحه  | هل قبلت فتاه؟"}
send(msg.chat_id_, msg.id_,'*'..KtsaMsg[math.random(#KtsaMsg)]..'*') 
elseif text == "كت تويت" or text == "كت" then
local texting = {"آخر مرة زرت مدينة الملاهي؟","آخر مرة أكلت أكلتك المفضّلة؟","الوضع الحالي؟\n‏1. سهران\n‏2. ضايج\n‏3. أتأمل","آخر شيء ضاع منك؟","كلمة أخيرة لشاغل البال؟","طريقتك المعتادة في التخلّص من الطاقة السلبية؟","شهر من أشهر العام له ذكرى جميلة معك؟","كلمة غريبة من لهجتك ومعناها؟🤓","‏- شيء سمعته عالق في ذهنك هاليومين؟","متى تكره الشخص الذي أمامك حتى لو كنت مِن أشد معجبينه؟","‏- أبرز صفة حسنة في صديقك المقرب؟","هل تشعر أن هنالك مَن يُحبك؟","اذا اكتشفت أن أعز أصدقائك يضمر لك السوء، موقفك الصريح؟","أجمل شيء حصل معك خلال هاليوم؟","صِف شعورك وأنت تُحب شخص يُحب غيرك؟👀💔","كلمة لشخص غالي اشتقت إليه؟💕","آخر خبر سعيد، متى وصلك؟","أنا آسف على ....؟","أوصف نفسك بكلمة؟","صريح، مشتاق؟","‏- صريح، هل سبق وخذلت أحدهم ولو عن غير قصد؟","‏- ماذا ستختار من الكلمات لتعبر لنا عن حياتك التي عشتها الى الآن؟💭","‏- فنان/ة تود لو يدعوكَ على مائدة عشاء؟😁❤","‏- تخيّل شيء قد يحدث في المستقبل؟","‏- للشباب | آخر مرة وصلك غزل من فتاة؟🌚","شخص أو صاحب عوضك ونساك مُر الحياة ما اسمه ؟","اذا شفت حد واعجبك وعندك الجرأه انك تروح وتتعرف عليه ، مقدمة الحديث شو راح تكون ؟."," فنانك المُفضل؟","لو خيروك تصاحب الناس الاذكياء او الناس المرحين","اسم معلم ترك اثراً جميل عليك رغم قسوتة.؟","وش الحب بنظرك؟","لو خيروك جاي او قهوه","لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟","شاركنا أقوى بيت شِعر من تأليفك؟","نصيحه تبدا ب -لا- ؟","كل شيء يهون الا ؟","عندك الشخص الي مستعد يوقف ضد العالم عشانك.؟","العلاقة السرية دائماً تكون حلوة؟","منشن شخص واعترف له بشي","منشن لصديقك المُقرب؟.","اخر خيانه؟.","أول حرف من اسم الحب؟","تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟","أكثر شيء تغيّر في أسلوب حياتك بعد كورونا ؟","هات شعورك بسطر اغُنيه؟","شيء مهما حطيت فيه مصاري بتكون مبسوط؟","اغرب شي سويته ؟","كيف تشوف الجيل هذا؟","اخر همك في الحياة ؟","انت من الناس الكتومة ولا تفضفض؟","اكثر مكان تروحه لحالك ؟","قوة الصداقة بشو بتتكون؟","تطبيق تبي تحذفه من جهازك بس مضطر تستخدمه ؟","كم أعلى مبلغ جمعته؟","اخر شي شريته ؟","كلمة للشخص اللي يسب ويسكر؟","لعبة بجوالك تلعبها دايم ؟","مر عليك موقف محرج؟","علمنا عن تجربه خلت شخصيتك اقوى ؟","يوم من أيام الأسبوع روتينه ممل عندك ؟","عندك شخص تسميه ثالث والديك؟","شو هو طعامك المفضل؟","اخر همك في الحياة ؟","شو حابب تقول للاشخاص اللي بتدخل حياتك؟","عبر عن حبك او كرهك لشخص ما تقدر توصل له مشاعرك","موهبتك المكبوتة ؟","انت من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟","عبر عن حبك او كرهك لشخص ما تقدر توصل له مشاعرك","ماذا يعني لك حرف A","ماذا يعني لك حرحرM","نسبة رضاك عن نفسك من 10 ؟","عندكم شخص بالبيت بصلح اي شي بيخرب؟","تحس نفسك هطف ؟","تدوس على قلبك او كرامتك؟","  تحس حياتك فاشله ولا ناجحه؟","لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا بترفض؟","ميزة وعيب فيك ؟","وش ينادونك في البيت ؟", }  
send(msg.chat_id_, msg.id_,'*'..texting[math.random(#texting)]..'*')
elseif text == "العكس" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."Status:Set:Aks"..msg.chat_id_)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
redis:set(bot_id.."Status:Set:Aks:Game"..msg.chat_id_,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"ناصي","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
send(msg.chat_id_, msg.id_,"᥀︙اسرع واحد يدز العكس ~ {"..name.."}")
return false
end
elseif text == "خمن" or text == "تخمين" then   
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
Num = math.random(1,20)
redis:set(bot_id.."Status:GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,"\n᥀︙اهلا بك عزيزي في لعبة التخمين :\nٴ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n".."᥀︙ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."᥀︙سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ")
redis:setex(bot_id.."Status:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
elseif text == "محيبس" or text == "بات" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then   
Num = math.random(1,6)
redis:set(bot_id.."Status:Games:Bat"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,[[
*➀   ➁ ➂  ➃  ➄ ➅
↓  ↓ ↓  ↓ ↓ ↓
👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊
᥀︙اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
᥀︙الفائز يحصل على { 3 } من النقاط *
]])
redis:setex(bot_id.."Status:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
elseif text == "المختلف" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","🧜‍♂","??‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
redis:del(bot_id.."Status:Set:Moktlf:Bot"..msg.chat_id_)
redis:set(bot_id.."Status::Set:Moktlf"..msg.chat_id_,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍??👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍??👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️??‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬??👭👭")
name = string.gsub(name,"??‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","??📆📆📆📆📆📅📆📆")
send(msg.chat_id_, msg.id_,"᥀︙اسرع واحد يدز الاختلاف ~ {"..name.."}")
return false
end
elseif text and text:match('^(@[%a%d_]+)$') and redis:get(bot_id..":Number_Add:"..msg.chat_id_..msg.sender_user_id_) then
if redis:sismember(bot_id..':List_Rolet:'..msg.chat_id_,text) then
send(msg.chat_id_,msg.id_,"*᥀︙المعرف ["..text.." ] موجود اساساً*")
return false
end 
redis:sadd(bot_id..':List_Rolet:'..msg.chat_id_,text)
local CountAdd = redis:get(bot_id..":Number_Add:"..msg.chat_id_..msg.sender_user_id_)
local CountAll = redis:scard(bot_id..':List_Rolet:'..msg.chat_id_)
local CountUser = CountAdd - CountAll
if tonumber(CountAll) == tonumber(CountAdd) then 
redis:del(bot_id..":Number_Add:"..msg.chat_id_..msg.sender_user_id_) 
redis:setex(bot_id..":Witting_StartGame:"..msg.chat_id_..msg.sender_user_id_,1400,true)  
send(msg.chat_id_,msg.id_,"*᥀︙تم حفظ المعرف* (["..text.."])\n*᥀︙تم اكمال العدد الكلي*\n*᥀︙ارسل (نعم) للبدء*")
return false
end  
send(msg.chat_id_,msg.id_,"*᥀︙تم حفظ المعرف* (["..text.."])\n*᥀︙تبقى "..CountUser.." لاعبين ليكتمل العدد*\n*᥀︙ارسل المعرف التالي*")
return false
elseif text and text:match("^(%d+)$") and redis:get(bot_id..":Start_Rolet:"..msg.chat_id_..msg.sender_user_id_) then
if text == "1" then
send(msg.chat_id_, msg.id_," *᥀︙لا استطيع بدء اللعبه بلاعب واحد فقط*")
elseif text ~= "1" then
redis:set(bot_id..":Number_Add:"..msg.chat_id_..msg.sender_user_id_,text)  
redis:del(bot_id..":Start_Rolet:"..msg.chat_id_..msg.sender_user_id_)  
send(msg.chat_id_, msg.id_,"*᥀︙قم  بأرسال معرفات اللاعبين الان*")
return false
end
elseif text == 'روليت' then
redis:del(bot_id..":Number_Add:"..msg.chat_id_..msg.sender_user_id_) 
redis:del(bot_id..':List_Rolet:'..msg.chat_id_)  
redis:setex(bot_id..":Start_Rolet:"..msg.chat_id_..msg.sender_user_id_,3600,true)  
send(msg.chat_id_, msg.id_, '*᥀︙ارسل عدد اللاعبين للروليت*')
elseif text == 'نعم' and redis:get(bot_id..":Witting_StartGame:"..msg.chat_id_..msg.sender_user_id_) then
local list = redis:smembers(bot_id..':List_Rolet:'..msg.chat_id_) 
if #list == 1 then 
send(msg.chat_id_, msg.id_,  "*᥀︙لم يكتمل العدد الكلي للاعبين*" )
elseif #list == 0 then 
send(msg.chat_id_, msg.id_, "*᥀︙عذرا لم تقوم باضافه اي لاعب*" )
return false
end 
local UserName = list[math.random(#list)]
redis:del(bot_id..':List_Rolet:'..msg.chat_id_) 
redis:del(bot_id..":Witting_StartGame:"..msg.chat_id_..msg.sender_user_id_)
send(msg.chat_id_, msg.id_, '*᥀︙الفائز هوه* ['..UserName..']')
return false
elseif text == 'الاعبين' then
local list = redis:smembers(bot_id..':List_Rolet:'..msg.chat_id_) 
local Text = '\n*ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ*\n' 
if #list == 0 then 
send(msg.chat_id_, msg.id_,'*᥀︙لا يوجد لاعبين هنا*')
end 
for k, v in pairs(list) do 
Text = Text..k.."•  » [" ..v.."] »\n"  
end 
send(msg.chat_id_, msg.id_, Text)
elseif text == "امثله" then
if redis:get(bot_id.."Status:Lock:Game:Group"..msg.chat_id_) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
redis:set(bot_id.."Status:Set:Amth"..msg.chat_id_,name)
redis:del(bot_id.."Status:Set:Amth:Bot"..msg.chat_id_)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
send(msg.chat_id_, msg.id_,"᥀︙اسرع واحد يكمل المثل ~ {"..name.."}")
return false
end
elseif text == 'السورس' or text == 'سورس' or text == 'ياسورس'  then
send(msg.chat_id_, msg.id_,[[
⦑ Welcome to Source ⦒

𓂅 .VINES TEAM 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
𓂅 . [Source Channel](t.me/Vc33h)

𓂅 . [Source dev ](t.me/NNUUU) 
 ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
𓂅 . [TWS VINES](t.me/Z_A_XBOT) 
]]) 
elseif text == 'الاوامر' and Admin(msg) then
send(msg.chat_id_, msg.id_,[[*
᥀︙توجد ← 5 اوامر في البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙ارسل { م1 } ← اوامر الحمايه
᥀︙ارسل { م2 } ← اوامر الادمنيه
᥀︙ارسل { م3 } ← اوامر المدراء
᥀︙ارسل { م4 } ← اوامر المنشئين
᥀︙ارسل { م5 } ← اوامر مطورين البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙قناة البوت ←* @Vc33h
]]) 
elseif text == 'م1' and Admin(msg) then
send(msg.chat_id_, msg.id_,[[*
᥀︙اوامر الحمايه اتبع مايلي ...
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙قفل ، فتح ← الامر 
᥀︙تستطيع قفل حمايه كما يلي ...
᥀︙← { بالتقيد ، بالطرد ، بالكتم }
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙الروابط
᥀︙المعرف
᥀︙التاك
᥀︙الشارحه
᥀︙التعديل
᥀︙التثبيت
᥀︙المتحركه
᥀︙الملفات
᥀︙الصور
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙الماركداون
᥀︙البوتات
᥀︙التكرار
᥀︙الكلايش
᥀︙السيلفي
᥀︙الملصقات
᥀︙الفيديو
᥀︙الانلاين
᥀︙الدردشه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙التوجيه
᥀︙الاغاني
᥀︙الصوت
᥀︙الجهات
᥀︙الاشعارات
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙قناة البوت ←* @Vc33h
]]) 
elseif text == 'م2' and Admin(msg) then
send(msg.chat_id_, msg.id_,[[*
᥀︙اوامر ادمنية المجموعه ...
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙رفع، تنزيل ← مميز
᥀︙تاك للكل ، عدد الكروب
᥀︙كتم ، حظر ، طرد ، تقيد
᥀︙الغاء كتم ، الغاء حظر ، الغاء تقيد
᥀︙منع ، الغاء منع 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙عرض القوائم كما يلي ...
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙المكتومين
᥀︙المميزين 
᥀︙قائمه المنع
᥀︙الصلاحيات
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙تثبيت ، الغاء تثبيت
᥀︙الرابط ، الاعدادات
᥀︙الترحيب ، القوانين
᥀︙تفعيل ، تعطيل ← الترحيب
᥀︙تفعيل ، تعطيل ← الرابط
᥀︙اضف صلاحيه ، مسح صلاحيه 
᥀︙جهاتي ،ايدي ، رسائلي
᥀︙سحكاتي ، مجوهراتي
᥀︙كشف البوتات
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙وضع ، ضع ← الاوامر التاليه 
᥀︙اسم ، رابط ، صوره
᥀︙قوانين ، وصف ، ترحيب
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙حذف ، مسح ← الاوامر التاليه
᥀︙قائمه المنع ، المحظورين 
᥀︙المميزين ، المكتومين ، القوانين
᥀︙المطرودين ، البوتات ، الصوره
᥀︙الصلاحيات ، الرابط
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙قناة البوت ←* @Vc33h
]]) 
elseif text == 'م3' and Owner(msg) then
send(msg.chat_id_, msg.id_,[[*
᥀︙اوامر المدراء في المجموعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙رفع ، تنزيل ← ادمن
᥀︙الادمنيه 
᥀︙رفع، كشف ← القيود
᥀︙تنزيل الكل ← { بالرد ، بالمعرف }
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙لتغيير رد الرتب في البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙تغير رد ← {اسم الرتبه والنص} 
᥀︙المطور ، المنشئ الاساسي
᥀︙المنشئ ، المدير ، الادمن
᥀︙المميز ، العضو
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙تفعيل ، تعطيل ← الاوامر التاليه ↓
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙الايدي ، الايدي بالصوره
᥀︙ردود المطور ، ردود المدير
᥀︙اطردني ، الالعاب ، الرفع
᥀︙الحظر ، الرابط ، اوامر التحشيش
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙تعين ، مسح ←{ الايدي }
᥀︙رفع الادمنيه ، مسح الادمنيه
᥀︙ردود المدير ، مسح ردود المدير
᥀︙اضف ، حذف ← { رد }
᥀︙تنظيف ← { عدد }
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙قناة البوت ←* @Vc33h
]]) 
elseif text == 'م4' and Constructor(msg) then
send(msg.chat_id_, msg.id_,[[*
᥀︙اوامر المنشئ الاساسي
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙رفع ، تنزيل ←{ منشئ }
᥀︙المنشئين ، مسح المنشئين
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙اوامر المنشئ المجموعه
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙رفع ، تنزيل ← { مدير }
᥀︙المدراء ، مسح المدراء
᥀︙اضف رسائل ← { بالرد او الايدي }
᥀︙اضف مجوهرات ← { بالرد او الايدي }
᥀︙اضف ، حذف ← { امر }
᥀︙الاوامر المضافه ، مسح الاوامر المضافه
᥀︙تنزيل جميع الرتب
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙قناة البوت ←* @Vc33h
]]) 
elseif text == 'م5' and DeveloperBot(msg)  then
send(msg.chat_id_, msg.id_,[[*
᥀︙اوامر المطور الاساسي  
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙حظر عام ، الغاء العام
᥀︙اضف ، حذف ← { مطور } 
᥀︙قائمه العام ، مسح قائمه العام
᥀︙المطورين ، مسح المطورين
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙اضف ، حذف ← { رد للكل }
᥀︙وضع ، حذف ← { كليشه المطور } 
᥀︙مسح ردود المطور ، ردود المطور 
᥀︙تحديث ،  تحديث السورس 
᥀︙تعين عدد الاعضاء ← { العدد }
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙تفعيل ، تعطيل ← { الاوامر التاليه ↓}
᥀︙البوت الخدمي ، المغادرة ، الاذاعه
᥀︙ملف ← { اسم الملف }
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙مسح جميع الملفات 
᥀︙المتجر ، الملفات
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙اوامر المطور في البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙تفعيل ، تعطيل ، الاحصائيات
᥀︙رفع، تنزيل ← { منشئ اساسي }
᥀︙مسح الاساسين ، المنشئين الاساسين 
᥀︙غادر ، غادر ← { والايدي }
᥀︙اذاعه ، اذاعه بالتوجيه ، اذاعه بالتثبيت
᥀︙اذاعه خاص ، اذاعه خاص بالتوجيه 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙قناة البوت ←* @Vc33h
]]) 
elseif text == 'الالعاب' then
send(msg.chat_id_, msg.id_,[[*
᥀︙قائمه الالعاب البوت
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙لعبة المختلف » المختلف
᥀︙لعبة الامثله » امثله
᥀︙لعبة العكس » العكس
᥀︙لعبة الحزوره » حزوره
᥀︙لعبة المعاني » معاني
᥀︙لعبة البات » بات
᥀︙لعبة التخمين » خمن
᥀︙لعبه الاسرع » الاسرع
᥀︙لعبة السمايلات » سمايلات
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
᥀︙مجوهراتي ← لعرض عدد الارباح
᥀︙بيع مجوهراتي ← { العدد } ← لبيع كل مجوهره مقابل {50} رساله
*]]) 
elseif text == 'رسائلي' then
local NumMsgg1 = redis:get(bot_id..'Num:Message:Userr'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local nummsg = redis:get(bot_id..'Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 1 
local NumMsg = (NumMsgg1 + nummsg)
send(msg.chat_id_, msg.id_,'᥀︙عدد رسائلك هنا *~ '..NumMsg..'*') 
elseif text == 'سحكاتي' or text == 'تعديلاتي' then
local edit = redis:get(bot_id..'Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'᥀︙عدد التعديلات هنا *~ '..edit..'*') 
elseif text == 'جهاتي' then
local addmem = redis:get(bot_id.."Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'᥀︙عدد جهاتك المضافه هنا *~ '..addmem..'*') 
elseif text == "مجوهراتي" then 
local Num = redis:get(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = "᥀︙لم تفز بأي مجوهره "
else
Text = "᥀︙عدد الجواهر التي ربحتها *← "..Num.." *"
end
send(msg.chat_id_, msg.id_,Text) 
elseif text and text:match("^بيع مجوهراتي (%d+)$") then
local NUMPY = text:match("^بيع مجوهراتي (%d+)$") 
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*᥀︙لا استطيع البيع اقل من 1 *") 
return false 
elseif tonumber(redis:get(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,"᥀︙ليس لديك جواهر من الالعاب \n᥀︙اذا كنت تريد ربح الجواهر \n᥀︙ارسل الالعاب وابدأ اللعب ! ") 
else
local NUM_GAMES = redis:get(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,"\n᥀︙ليس لديك جواهر بهاذا العدد \n᥀︙لزيادة مجوهراتك في اللعبه \n᥀︙ارسل الالعاب وابدأ اللعب !") 
return false 
end
local NUMNKO = (NUMPY * 50)
redis:decrby(bot_id.."Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,NUMPY)  
redis:incrby(bot_id.."Num:Message:User"..msg.chat_id_..":"..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,"᥀︙تم خصم *~ { "..NUMPY.." }* من مجوهراتك \n᥀︙وتم اضافة* ~ { "..(NUMPY * 50).." } رساله الى رسالك *")
end 
return false 
elseif text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then
taha = text:match("^اضف رسائل (%d+)$")
redis:set(bot_id.."Status:id:user"..msg.chat_id_,taha)  
redis:setex(bot_id.."Status:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "᥀︙ارسل لي عدد الرسائل الان") 
return false
elseif text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
taha = text:match("^اضف مجوهرات (%d+)$")
redis:set(bot_id.."Status:idgem:user"..msg.chat_id_,taha)  
redis:setex(bot_id.."Status:gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "᥀︙ارسل لي عدد المجوهرات الان") 
elseif text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:incrby(bot_id.."Num:Add:Games"..msg.chat_id_..result.sender_user_id_,text:match("^اضف مجوهرات (%d+)$"))  
send(msg.chat_id_, msg.id_,"᥀︙تم اضافه عدد مجوهرات : "..text:match("^اضف مجوهرات (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
elseif text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:del(bot_id.."Status:Msg_User"..msg.chat_id_..":"..result.sender_user_id_) 
redis:incrby(bot_id.."Num:Message:Userr"..msg.chat_id_..":"..result.sender_user_id_,text:match("^اضف رسائل (%d+)$"))  
send(msg.chat_id_, msg.id_, "᥀︙تم اضافه عدد الرسائل : "..text:match("^اضف رسائل (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
elseif text == "تنظيف المشتركين" and Dev_VINES(msg) then
local pv = redis:smembers(bot_id..'Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'᥀︙لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*᥀︙عدد المشتركين الان ←{ '..#pv..' }\n᥀︙تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n᥀︙اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
elseif text == "تنظيف الكروبات" and Dev_VINES(msg) then
local group = redis:smembers(bot_id..'ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'᥀︙لا توجد مجموعات وهميه ')   
else
local taha = (w + q)
local sendok = #group - taha
if q == 0 then
taha = ''
else
taha = '\n᥀︙ تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
VINES = ''
else
VINES = '\n᥀︙ تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*᥀︙ عدد المجموعات الان ← { '..#group..' } مجموعه '..VINES..''..taha..'\n᥀︙اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
elseif text == "اطردني" or text == "طردني" then
if not redis:get(bot_id.."Status:Cheking:Kick:Me:Group"..msg.chat_id_) then
if Rank_Checking(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n᥀︙ عذرا لا استطيع طرد ( "..Get_Rank(msg.sender_user_id_,msg.chat_id_).." )")
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"᥀︙ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,"᥀︙ البوت ليس ادمن يرجى ترقيتي !") 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,"᥀︙ عذرا لا استطيع طرد ادمنية المجموعه") 
return false  
end
if data and data.ID and data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"᥀︙ تم طردك من المجموعه ") 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,"᥀︙ امر اطردني تم تعطيله من قبل المدراء ") 
end
elseif text and text:match("^رفع القيود @(.*)") and Owner(msg) then 
local username = text:match("^رفع القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if Dev_VINES(msg) then
redis:srem(bot_id.."Mu:User:Groups",result.id_)
redis:srem(bot_id.."Removal:User:Groups",result.id_)
redis:srem(bot_id.."Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Silence:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Keed:User:Group"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n᥀︙ تم الغاء القيود عنه")  
else
redis:srem(bot_id.."Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Silence:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."Keed:User:Group"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n᥀︙ تم الغاء القيود عنه")  
end
else
send(msg.chat_id_, msg.id_,"᥀︙ المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
elseif text == "رفع القيود" and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_VINES(msg) then
redis:srem(bot_id.."Mu:User:Groups",result.sender_user_id_)
redis:srem(bot_id.."Removal:User:Groups",result.sender_user_id_)
redis:srem(bot_id.."Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Keed:User:Group"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n᥀︙ تم الغاء القيود عنه")  
else
redis:srem(bot_id.."Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."Keed:User:Group"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n᥀︙ تم الغاء القيود عنه")  
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
elseif text and text:match("^كشف القيود @(.*)") and Owner(msg) then 
local username = text:match("^كشف القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if redis:sismember(bot_id.."Silence:User:Group"..msg.chat_id_,result.id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."Keed:User:Group"..msg.chat_id_,result.id_) then
Zain = "مقيد"
else
Zain = "غير مقيد"
end
if redis:sismember(bot_id.."Removal:User:Group"..msg.chat_id_,result.id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."Removal:User:Groups",result.id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
send(msg.chat_id_, msg.id_,"᥀︙ الحظر العام ← "..GBan.."\n᥀︙ التقيد ← "..Zain.."\n᥀︙ الحظر ← "..Ban.."\n᥀︙ الكتم ← "..Muted)
else
send(msg.chat_id_, msg.id_,"᥀︙ المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
elseif text == "كشف القيود" and Owner(msg) then 
function Function_Status(extra, result, success)
if redis:sismember(bot_id.."Silence:User:Group"..msg.chat_id_,result.sender_user_id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."Keed:User:Group"..msg.chat_id_,result.sender_user_id_) then
Zain = "مقيد"
else
Zain = "غير مقيد"
end
if redis:sismember(bot_id.."Removal:User:Group"..msg.chat_id_,result.sender_user_id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."Removal:User:Groups",result.sender_user_id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
send(msg.chat_id_, msg.id_,"᥀︙ الحظر العام ← "..GBan.."\n᥀︙ التقيد ← "..Zain.."\n᥀︙ الحظر ← "..Ban.."\n᥀︙ الكتم ← "..Muted)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
elseif text ==("رفع الادمنيه") and Owner(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
redis:sadd(bot_id..'Admin:Group'..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
redis:srem(bot_id..'Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
redis:sadd(bot_id..'Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"᥀︙ لا توجد ادمنية ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"᥀︙ تمت ترقية - "..num2.." من ادمنية المجموعه") 
end
end,nil)   
elseif text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"᥀︙ حساب المنشئ محذوف")
return false  
end
first_name = '['..b.first_name_..'](tg://user?id='..owner_id..')'
first_Id = owner_id
firsme = b.first_name_
local UserName = (b.username_ or "zzzKz")
local function getpro(extra, result, success)
if result.photos_[0] then
keyboard = {}
keyboard.inline_keyboard = {{{text =firsme, url = "https://t.me/"..UserName}},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape('*᥀︙Creator Name* ↬ › '..first_name..'\n*᥀︙Creator Bio *↬ » '..getbio(first_Id))..'&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
send(msg.chat_id_, msg.id_,'*᥀︙Creator Name* ↬ › '..first_name..'\n*᥀︙Creator Bio *↬ » '..getbio(owner_id))
end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = Id_Dev, offset_ = 0, limit_ = 1 }, getpro, nil)
end,nil)   
end
end
end,nil)   
elseif text ==("رفع المنشئ") and DeveloperBot(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"᥀︙حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "zzzKz")
send(msg.chat_id_, msg.id_,"᥀︙تم ترقية منشئ المجموعه ← ["..b.first_name_.."](T.me/"..UserName..")")  
redis:sadd(bot_id.."President:User"..msg.chat_id_,b.id_)
end,nil)   
end,nil)   
elseif text and text:match("^تعين عدد الاعضاء (%d+)$") and Dev_VINES(msg) then
redis:set(bot_id..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg.chat_id_, msg.id_,'*᥀︙ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *')
elseif text =='الاحصائيات' and DeveloperBot(msg) then 
send(msg.chat_id_, msg.id_,'*᥀︙عدد احصائيات البوت الكامله \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n᥀︙عدد المجموعات : '..(redis:scard(bot_id..'ChekBotAdd') or 0)..'\n᥀︙عدد المشتركين : '..(redis:scard(bot_id..'Num:User:Pv') or 0)..'*')
elseif text == 'المطور' or text == 'مطور' then
tdcli_function({ID="GetUser",user_id_=Id_Dev},function(extra,result,success)
if result.first_name_  then
first_name = '['..result.first_name_..'](tg://user?id='..Id_Dev..')'
firsme = result.first_name_
else
first_name = ""
end   
local TextingDevVINES = redis:get(bot_id..'Texting:DevVINES')
if TextingDevVINES then 
send(msg.chat_id_, msg.id_,TextingDevVINES)
else
local function getpro(extra, result, success)
if result.photos_[0] then
keyboard = {}
keyboard.inline_keyboard = {{{text =firsme, url = "https://t.me/"..UserName_Dev}},}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape('*᥀︙Dev Name* ↬ › '..first_name..'\n*᥀︙Dev User* ↬ @'..UserName_Dev..'\n*᥀︙Dev Id* ↬ ( `'..Id_Dev..'` )\n*᥀︙Dev Bio *↬ » '..getbio(Id_Dev))..'&photo='..result.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
send(msg.chat_id_, msg.id_,'*᥀︙Dev Name* ↬ › '..first_name..'\n*᥀︙Dev User* ↬ @'..UserName_Dev..'\n*᥀︙Dev Id* ↬ ( `'..Id_Dev..'` )\n*᥀︙Dev Bio *↬ » '..getbio(Id_Dev))
end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = Id_Dev, offset_ = 0, limit_ = 1 }, getpro, nil)
end
end,nil)
elseif text == 'حذف كليشه المطور' and Dev_VINES(msg) then
redis:del(bot_id..'Texting:DevVINES')
send(msg.chat_id_, msg.id_,'᥀︙ تم حذف كليشه المطور')
end
end
------------------------------------------------------------------------------------------------------------
if text == 'تفعيل' and DeveloperBot(msg) and GetChannelMember(msg) then  
if TypeForChat ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'🚸¦ يجب تحويل المجموعة الى خارقة. او وضع معرف للمجموعه لتصبح عامه ثم ارفع البوت وارسل تفعيل⚙️') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'᥀︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'Num:Add:Bot') or 0) and not Dev_VINES(msg) then
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'Num:Add:Bot') or 0)..'* عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if redis:sismember(bot_id..'ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل المجموعه مسبقا')
else
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
redis:sadd(bot_id.."President:User"..msg.chat_id_,owner_id)
end
end
end,nil)   
Send_Options(msg,result.id_,'reply_Add','᥀︙تم تفعيل مجموعه '..chat.title_..'')
redis:sadd(bot_id..'ChekBotAdd',msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_VINES(msg) then
sendText(Id_Dev,'᥀︙تم تفعيل مجموعه جديده\n'..'\n᥀︙بواسطة : '..Name..''..'\n᥀︙ايدي المجموعه : `'..IdChat..'`'..'\n᥀︙عدد اعضاء المجموعه *: '..NumMember..'*'..'\n᥀︙اسم المجموعه : ['..NameChat..']'..'\n᥀︙الرابط : ['..LinkGp..']',0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
------------------------------------------------------------------------------------------------------------
if text == 'تعطيل' and DeveloperBot(msg) and GetChannelMember(msg) then  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not redis:sismember(bot_id..'ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'᥀︙المجموعه بالتاكيد معطله')
else
Send_Options(msg,result.id_,'reply_Add','᥀︙تم تعطيل مجموعه '..chat.title_..'')
redis:srem(bot_id..'ChekBotAdd',msg.chat_id_)  
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_VINES(msg) then
sendText(Id_Dev,'᥀︙تم تعطيل مجموعه جديده\n'..'\n᥀︙بواسطة : '..Name..''..'\n᥀︙ايدي المجموعه : `'..IdChat..'`\n᥀︙اسم المجموعه : ['..NameChat..']',0,'md')
end
end
end,nil) 
end,nil) 
end
------------------------------------------------------------------------------------------------------------
if text == 'تفعيل' and not DeveloperBot(msg) and not redis:get(bot_id..'Free:Bot') and GetChannelMember(msg) then  
if TypeForChat ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'🚸¦ يجب تحويل المجموعة الى خارقة. او وضع معرف للمجموعه لتصبح عامه ثم ارفع البوت وارسل تفعيل⚙️') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'᥀︙البوت ليس ادمن يرجى ترقيتي') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,DataChat) 
if DataChat and DataChat.status_.ID == "ChatMemberStatusEditor" or DataChat and DataChat.status_.ID == "ChatMemberStatusCreator" then
if DataChat and DataChat.user_id_ == msg.sender_user_id_ then
if DataChat.status_.ID == "ChatMemberStatusCreator" then
Status_Rt = 'المنشئ'
elseif DataChat.status_.ID == "ChatMemberStatusEditor" then
Status_Rt = 'الادمن'
else 
Status_Rt = 'عضو'
end
if redis:sismember(bot_id..'ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'᥀︙تم تفعيل المجموعه مسبقا')
return false
end
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'Num:Add:Bot') or 0) and not Dev_VINES(msg) then
send(msg.chat_id_, msg.id_,'᥀︙لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'Num:Add:Bot') or 0)..'* عضو')
return false
end
Send_Options(msg,msg.sender_user_id_,'reply_Add','᥀︙تم تفعيل مجموعه '..chat.title_..'')
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
redis:sadd(bot_id.."President:User"..msg.chat_id_,owner_id)
end
end
end,nil)   
redis:sadd(bot_id..'ChekBotAdd',msg.chat_id_)  
redis:sadd(bot_id..'President:User'..msg.chat_id_, msg.sender_user_id_)
local LinkApi = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkApi.ok == true then 
LinkChat = LinkApi.result
else
LinkChat = 'لا يوجد'
end
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not Dev_VINES(msg) then
sendText(Id_Dev,'᥀︙تم تفعيل مجموعه جديده\n᥀︙بواسطة : '..Name..'\n᥀︙موقعه في المجموعه : '..Status_Rt..'\n᥀︙ايدي المجموعه : `'..msg.chat_id_..'`\n᥀︙عدد اعضاء المجموعه *: '..NumMember..'*\n᥀︙اسم المجموعه : ['..NameChat..']\n᥀︙الرابط : ['..LinkChat..']',0,'md')
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil) 
end
------------------------------------------------------------------------------------------------------------
end
end
------------------------------------------------------------------------------------------------------------
local ban_Lkid = {}
function tdcli_update_callback(data)
if data.ID == ("UpdateChannel") then 
if data.channel_.status_.ID == ("ChatMemberStatusKicked") then 
redis:srem(bot_id..'ChekBotAdd','-100'..data.channel_.id_)  
tdcli_function({ID ="GetChat",chat_id_="-100"..data.channel_.id_},function(arg,chat)  
sendText(Id_Dev,"*᥀︙لقد تم طردي من المجموعه .*\n᥀︙["..chat.title_.."]\n᥀︙`-100"..data.channel_.id_.."`",0,'md')
end,nil)
end
elseif data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local From_id = data.id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local DAata = data.payload_.data_
if DAata and DAata:match("^animation(.*)$") and Admin(data) then  
idch = DAata:match("-100(%d+)")
local idchci = "-100"..idch
local animation = DAata:match("^animation(.*)$"):gsub('chatid',''):gsub('chatid',''):gsub(idch,''):gsub('-100','')
local Text ="*᥀︙تم الغاء منعها بنجاح*"
inline = {
{{text = '᥀︙ 𓂅 .VINES TEAM  .',url='http://t.me/AMERDEV'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inline_keyboard(Chat_id,Text,nil,inline) 
redis:srem(bot_id.."List:Filter:Animation"..idchci,animation)  
end
if DAata and DAata:match("^pito(.*)$") and Admin(data) then  
local idchci = redis:get(bot_id.."Filter:msg")
local photo = DAata:match("^pito(.*)$")
local Text ="*᥀︙تم الغاء منعها بنجاح*"
inline = {
{{text = '᥀︙ 𓂅 .VINES TEAM  .',url='http://t.me/AMERDEV'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inline_keyboard(Chat_id,Text,nil,inline)
redis:srem(bot_id.."List:Filter:Photo"..idchci,photo)  
end
if DAata and DAata:match("^Sticker(.*)$") and Admin(data) then  
idch = DAata:match("-100(%d+)")
local idchci = "-100"..idch
local Sticker = DAata:match("^Sticker(.*)$"):gsub('chatid',''):gsub('chatid',''):gsub(idch,''):gsub('-100','')
local Text ="*᥀︙تم الغاء منعه بنجاح*"
inline = {
{{text = '᥀︙ 𓂅 .VINES TEAM  .',url='http://t.me/AMERDEV'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inline_keyboard(Chat_id,Text,nil,inline)
redis:srem(bot_id.."List:Filter:Sticker"..idchci,Sticker)  
end
if DAata and DAata:match("^delallSticker(.*)$") and Admin(data) then  
local delallSticker = DAata:match("^delallSticker(.*)$")
local Text ="*᥀︙تم الغاء منع كل الملصقات*"
inline = {
{{text = '᥀︙ 𓂅 .VINES TEAM  .',url='http://t.me/AMERDEV'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inline_keyboard(Chat_id,Text,nil,inline)
local listSticker = redis:smembers(bot_id.."List:Filter:Sticker"..delallSticker)  
for k,v in pairs(listSticker) do  
redis:srem(bot_id.."List:Filter:Sticker"..delallSticker,v)  
end  
end
if DAata and DAata:match("^animationDdel(.*)$") and Admin(data) then  
local delallmation = DAata:match("^animationDdel(.*)$")
local Text ="*᥀︙تم الغاء منع كل المتحركات*"
inline = {
{{text = '᥀︙ 𓂅 .VINES TEAM  .',url='http://t.me/AMERDEV'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inline_keyboard(Chat_id,Text,nil,inline)
local listAnimation = redis:smembers(bot_id.."List:Filter:Animation"..delallmation)  
for k,v in pairs(listAnimation) do  
redis:srem(bot_id.."List:Filter:Animation"..delallmation,v)  
end  
end
if DAata and DAata:match("^delallph(.*)$") and Admin(data) then  
local delallph = DAata:match("^delallph(.*)$")
local Text ="*᥀︙تم الغاء منع كل الصور*"
inline = {
{{text = '᥀︙ 𓂅 .VINES TEAM  .',url='http://t.me/AMERDEV'}},
}
https.request("https://api.telegram.org/bot"..token.."/deleteMessage?chat_id="..Chat_id.."&message_id="..msg_idd)
send_inline_keyboard(Chat_id,Text,nil,inline)
local listPhoto = redis:smembers(bot_id.."List:Filter:Photo"..delallph)  
for k,v in pairs(listPhoto) do  
redis:srem(bot_id.."List:Filter:Photo"..delallph,v)  
end  
end
if DAata == 'EndAddarray'..data.sender_user_id_ then  
if redis:get(bot_id..'Set:array'..data.sender_user_id_..':'..Chat_id) == 'true1' then
redis:del(bot_id..'Set:array'..data.sender_user_id_..':'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '𓂅 .VINES TEAM',url='http://t.me/Vc33h'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" *᥀︙تم حفظ الردود بنجاح*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '𓂅 .VINES TEAM',url='http://t.me/Vc33h'}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(" *᥀︙تم تنفيذ الامر سابقا*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if DAata == 'okCaptcha'..data.sender_user_id_ then  
Delete_Message(Chat_id,{[0] = Msg_id})
return https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. Chat_id .. "&user_id="..DAata:match("(%d+)") .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
end
elseif data.ID == ("UpdateNewMessage") then
msg = data.message_
text = msg.content_.text_
if (data.message_.content_.text_) then 
if (ban_Lkid["ban"..msg.chat_id_..msg.sender_user_id_] and ban_Lkid["ban"..msg.chat_id_..msg.sender_user_id_] == data.message_.content_.text_ and ban_Lkid["ban:count:"..msg.chat_id_..msg.sender_user_id_] and ban_Lkid["ban:count:"..msg.chat_id_..msg.sender_user_id_] >= 3) then 
if (ban_Lkid["ban2:"..msg.chat_id_..msg.sender_user_id_]) then 
ban_Lkid["ban2:"..msg.chat_id_..msg.sender_user_id_] = nil
-- send(msg.chat_id_, msg.id_,"᥀︙لتلح يا حلو 😉")  
end 
return false
elseif(ban_Lkid["ban"..msg.chat_id_..msg.sender_user_id_] and ban_Lkid["ban"..msg.chat_id_..msg.sender_user_id_] == data.message_.content_.text_ and ban_Lkid["ban:count:"..msg.chat_id_..msg.sender_user_id_]) then 
ban_Lkid["ban:count:"..msg.chat_id_..msg.sender_user_id_] = ban_Lkid["ban:count:"..msg.chat_id_..msg.sender_user_id_] + 1;
elseif(ban_Lkid["ban"..msg.chat_id_..msg.sender_user_id_] and ban_Lkid["ban"..msg.chat_id_..msg.sender_user_id_] == data.message_.content_.text_) then 
ban_Lkid["ban:count:"..msg.chat_id_..msg.sender_user_id_] = 1;
else 
ban_Lkid["ban"..msg.chat_id_..msg.sender_user_id_] = data.message_.content_.text_
ban_Lkid["ban2:"..msg.chat_id_..msg.sender_user_id_] = true
ban_Lkid["ban:count:"..msg.chat_id_..msg.sender_user_id_] = 1;
end 

end 
if msg.date_ and msg.date_ < tonumber(os.time() - 30) then
print("->> Old Message End <<-")
return false
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text then
local NewCmmd = redis:get(bot_id.."Set:Za:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
------------------------------------------------------------------------------------------------------------
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
redis:set(bot_id..'Save:Username'..msg.sender_user_id_,data.username_)
end;end,nil)   
--------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = redis:get(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..text)
if NewCmmd then
redis:del(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..text)
redis:del(bot_id.."Set:Za:Group:New"..msg.chat_id_)
redis:srem(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"᥀︙تم ازالة هاذا ← { "..text.." }")  
else
send(msg.chat_id_, msg.id_,"᥀︙لا يوجد امر بهاذا الاسم تاكد من الامر واعد المحاوله")  
end
redis:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Set:Za:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
redis:set(bot_id.."Set:Za:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"᥀︙ارسل الامر الجديد ليتم وضعه مكان القديم")  
redis:del(bot_id.."Set:Za:Group"..msg.chat_id_..":"..msg.sender_user_id_)
redis:set(bot_id.."Set:Za:Group1"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."Set:Za:Group1"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = redis:get(bot_id.."Set:Za:Group:New"..msg.chat_id_)
redis:set(bot_id.."Set:Za:Group:New1"..msg.chat_id_..":"..text,NewCmd)
redis:sadd(bot_id.."List:ZaYon:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"᥀︙تم حفظ الامر باسم ← { "..text..' }')  
redis:del(bot_id.."Set:Za:Group1"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if msg.content_.ID == "MessageChatAddMembers" then  
redis:set(bot_id.."Who:Added:Me"..msg.chat_id_..":"..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "ked" then   
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
Get_Info = https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
redis:sadd(bot_id.."Keed:User:Group"..msg.chat_id_, mem_id[i].id_)
redis:sadd(bot_id.."Keed:User:Group"..msg.chat_id_, msg.sender_user_id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end 
end
end
if msg.content_.ID == "MessageChatAddMembers" then  
redis:set(bot_id.."Who:Added:Me"..msg.chat_id_..":"..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end 
end
end
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."Status:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "del" then   
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end 
end
end
------------------------------------------------------------------------------------------------------------
if tonumber(msg.sender_user_id_) ~= tonumber(bot_id) then  
if msg.sender_user_id_ and RemovalUserGroup(msg.chat_id_,msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false  
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroup(msg.chat_id_,msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false
elseif msg.sender_user_id_ and RemovalUserGroups(msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false 
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroups(msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
elseif msg.sender_user_id_ and MutedGroupsval(msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
elseif msg.sender_user_id_ and MutedGroups(msg.chat_id_,msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
end
end
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == "MessagePinMessage" or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == "MessageChatChangeTitle" or msg.content_.ID == "MessageChatDeleteMember" then   
if redis:get(bot_id.."Status:Lock:tagservr"..msg.chat_id_) then  
Delete_Message(msg.chat_id_,{[0] = msg.id_})   
return false
end
elseif text and not redis:sismember(bot_id..'Spam_For_Bot'..msg.sender_user_id_,text) then
redis:del(bot_id..'Spam_For_Bot'..msg.sender_user_id_) 

end

--------------------------------------------------------------------------------------------------------------
Dev_VINES_File(msg,data)
FilesVINESBot(msg,data)
elseif data.ID == ("UpdateMessageEdited") then
tdcli_function ({ID = "GetMessage",chat_id_ = data.chat_id_,message_id_ = tonumber(data.message_id_)},function(extra, result, success)
local textedit = result.content_.text_
redis:incr(bot_id..'Num:Message:Edit'..result.chat_id_..result.sender_user_id_)
if redis:get(bot_id.."Status:Lock:edit"..result.chat_id_) and not textedit and not PresidentGroup(result) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
local list = redis:smembers(bot_id.."Basic:User"..result.chat_id_)
if #list == 0 then
Send_Options(result,result.sender_user_id_,"reply","᥀︙قام بالتعديل على الميديا")  
else
tt = "\n᥀︙يا منشئين\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ \n"
for k,v in pairs(list) do
local username = redis:get(bot_id.."Save:Username" .. v)
if username then
tt = tt..""..k.."- ([@"..username.."])\n"
else
tt = tt..""..k.."- (`"..v.."`)\n"
end
end
Send_Options(result,result.sender_user_id_,"reply",tt.."\n᥀︙قام بالتعديل على الميديا")  
end
end
if not Vips(result) then
------------------------------------------------------------------------
if textedit and textedit:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[hH][tT][tT][pP][sT]") or textedit and textedit:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if redis:get(bot_id.."Status:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(@)(.*)") then
if redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("@") then
if redis:get(bot_id.."Status:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(#)(.*)") then
if redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("#") then
if redis:get(bot_id.."Status:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("/") then
if redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("(.*)(/)(.*)") then
if redis:get(bot_id.."Status:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit then
local Text_Filter = redis:get(bot_id.."Filter:Reply2"..textedit..result.chat_id_)   
if Text_Filter then
Delete_Message(result.chat_id_, {[0] = data.message_id_}) 
Send_Options(result,result.sender_user_id_,"reply","᥀︙"..Text_Filter)  
return false
end
end
end
end,nil)
elseif data.ID == ("UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = redis:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;redis:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end
elseif data.ID == ("UpdateOption") and data.value_.value_ == ("Ready")  then
end
end