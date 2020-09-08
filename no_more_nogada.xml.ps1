<#
# ���߼ҽ� ������ ���� �ҽ� ��Ű¡ ��ũ��Ʈ [charset: CP949]
#
# 1. �� ��ũ��Ʈ�� ���ϴ� ������ ����/�̵�
# 2. ���� ������ XML �������� �ۼ�
#    �� ��ũ��Ʈ�� ���� �������� map.xml ���ϸ����� �ۼ�
# 3. ��Ŭ���Ͽ� [PowerShell���� ����]
#
# XML ����
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

[String] $pwd = "��������: " + (pwd)
echo $pwd

$confirm = read-host "�½��ϱ�? [y/n]"
if(($confirm -ne "Y") -and ($confirm -ne "y"))
{
	throw ("Stop")
}
echo ""

[String] $prt_cnt = "���: " + ($XML.content.item.count) + "��"
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
