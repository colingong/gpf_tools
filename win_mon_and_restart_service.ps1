function test_main_page {
    $return_number = 0
    $code = e:\scripts\curl.exe --max-time 3 -sL -w "%{http_code}"  $SITE -o ./null
    if ($code -eq 200) { $return_number = 1 } else { $return_number = 0}
    return $return_number
}

# restart phpstudy 
function restart_phpstudy {

# kill all php-cgi.exe processes
taskkill /F /IM php-cgi*

# phpstudy
net stop Apache2a

net stop MySQLa

net start MySQLa
net start apache2a

}

################ define the site or page to test / log file:  ########################
$SITE = "http://127.0.0.1"
$LogFile = "E:\scripts\test_site.log"


#  $IsSiteLive = curl.exe --max-time 3 -sL -w "%{http_code}"  $SITE -o ./null
# 如果5次，页面访问不正常，即重启服务
$count = 0
$limit_count = 5

# 记日志
date >> $LogFile

for ($i=0; $i -lt $limit_count ;$i++) {
$count += test_main_page
}

if ($count -eq 0) {
# echo $count
restart_phpstudy
echo "bad, restart phpstudy" >> $LogFile
} else {
echo "good , it is ok"
echo "good , it is ok"  >> $LogFile
}
