<#
# ���߼ҽ� ������ ���� �ҽ� ��Ű¡ ��ũ��Ʈ [charset: Window ANSI]
#
# 1. �� ��ũ��Ʈ�� ���ϴ� ������ ����/�̵�
# 2. ���� ������ JSON �������� �ۼ�
#    �� ��ũ��Ʈ ���� $JSON ������ ���� �ۼ��ϰų�, �� ��ũ��Ʈ�� ���� �������� map.json ���ϸ����� ���� �ۼ�
# 3. ��Ŭ���Ͽ� [PowerShell���� ����]
#
# JSON ����
# [
#   ["necwitak/witak-webdocs/.../file1.jsp" , "C:\zegov-framework\...\file1.jsp"],
#   ["necwitak/witak-webdocs/.../file2.xml" , "C:\zegov-framework\...\file2.xml"]
# ]
#>


$JSON = '[
]'


# map.json ���� ���� �ּ� ����
#[String] $JSON = Get-Content map.json




########################################

[String] $pwd = "��������: " + (pwd)
echo $pwd

$confirm = read-host "�½��ϱ�? [y/n]"
if(($confirm -ne "Y") -and ($confirm -ne "y"))
{
	throw ("Stop")
}
echo ""

$jsonobj = ConvertFrom-Json -inputObject $JSON.Replace("\","/")
[String] $prt_cnt = "���: " + ($jsonobj.length) + "��"
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
