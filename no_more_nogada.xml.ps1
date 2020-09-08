<#
# 개발소스 전달을 위한 소스 패키징 스크립트 [charset: CP949]
#
# 1. 본 스크립트를 원하는 폴더에 복사/이동
# 2. 파일 정보를 XML 형식으로 작성
#    본 스크립트와 동일 폴더내에 map.xml 파일명으로 작성
# 3. 우클릭하여 [PowerShell에서 실행]
#
# XML 예시
# <content>
# <item>
#     <target>necwitak/witak-webdocs/.../file1.jsp</target>
#     <source>C:\zegov-framework\...\file1.jsp</source>
# </item>
# <item>
#     <target>necwitak/witak-webdocs/.../file2.xml</target>
#     <source>C:\zegov-framework\...\file2.xml</source>
# </item>
# </content>
#>

[xml] $XML = Get-Content 'map.xml'




########################################

[String] $pwd = "실행폴더: " + (pwd)
echo $pwd

$confirm = read-host "맞습니까? [y/n]"
if(($confirm -ne "Y") -and ($confirm -ne "y"))
{
	throw ("Stop")
}
echo ""

[String] $prt_cnt = "대상: " + ($XML.content.item.count) + "건"
echo $prt_cnt

foreach($item in $XML.content.item)
{
	$artarget = $item.target.split("/")
	$targetPath = $item.target.Replace($artarget[$artarget.length-1],"")
	if($targetPath.length -lt 1)
	{
		echo "ERROR : " (echo $item.target)
		pause
		throw ("Stop")
	}
	$ret = mkdir $targetPath
	cp $item.source $targetPath

	echo $item.target
}

pause
