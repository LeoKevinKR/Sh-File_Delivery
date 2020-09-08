<#
# 개발소스 전달을 위한 소스 패키징 스크립트 [charset: Window ANSI]
#
# 1. 본 스크립트를 원하는 폴더에 복사/이동
# 2. 파일 정보를 JSON 형식으로 작성
#    본 스크립트 내에 $JSON 변수에 직접 작성하거나, 본 스크립트와 동일 폴더내에 map.json 파일명으로 따로 작성
# 3. 우클릭하여 [PowerShell에서 실행]
#
# JSON 예시
# [
#   ["necwitak/witak-webdocs/.../file1.jsp" , "C:\zegov-framework\...\file1.jsp"],
#   ["necwitak/witak-webdocs/.../file2.xml" , "C:\zegov-framework\...\file2.xml"]
# ]
#>


$JSON = '[
]'


# map.json 파일 사용시 주석 해제
#[String] $JSON = Get-Content map.json




########################################

[String] $pwd = "실행폴더: " + (pwd)
echo $pwd

$confirm = read-host "맞습니까? [y/n]"
if(($confirm -ne "Y") -and ($confirm -ne "y"))
{
	throw ("Stop")
}
echo ""

$jsonobj = ConvertFrom-Json -inputObject $JSON.Replace("\","/")
[String] $prt_cnt = "대상: " + ($jsonobj.length) + "건"
echo $prt_cnt

foreach($item in $jsonobj)
{
	$artarget = $item[0].split("/")
	$targetPath = $item[0].Replace($artarget[$artarget.length-1],"")
	if($targetPath.length -lt 1)
	{
		echo "ERROR : " (echo $item[0])
		pause
		throw ("Stop")
	}
	$ret = mkdir $targetPath
	cp $item[1] $targetPath
	echo $item[0]
}

pause
